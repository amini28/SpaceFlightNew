//
//  APIService.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation
import Combine


protocol APIServiceProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, APIError>
}

final class APIService: NSObject, APIServiceProtocol {

    private let session: URLSession
    private let pinnedCertificates: [Data]

    init(session: URLSession = .shared, pinnedCertificates: [Data]? = nil) {
        let configuration = URLSessionConfiguration.default
        configuration.tlsMinimumSupportedProtocolVersion = .TLSv12
        self.session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        self.pinnedCertificates = pinnedCertificates ?? APIService.loadPinnedCertificates()
        super.init()
        self.session.configuration.connectionProxyDictionary = [:]
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, APIError> {
        session.dataTaskPublisher(for: endpoint.urlRequest)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw APIError.badServerResponse
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                } else if let decodingError = error as? DecodingError {
                    return .decodingFailed(decodingError)
                } else if let urlError = error as? URLError {
                    return .requestFailed(urlError)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

extension APIService: URLSessionDelegate {

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust,
              let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        
        if isServerTrustValid(serverTrust, forHost: challenge.protectionSpace.host) {
            let credential = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }

    private func isServerTrustValid(_ serverTrust: SecTrust, forHost host: String) -> Bool {
        let policy = SecPolicyCreateSSL(true, host as CFString)
        SecTrustSetPolicies(serverTrust, policy)

        guard let serverCertificates = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate],
              !serverCertificates.isEmpty else {
            #if DEBUG
            print("❌ SSL Pinning failed: No certificates found for host \(host)")
            #endif
            return false
        }

        let serverCertificateData = serverCertificates.map { SecCertificateCopyData($0) as Data }
        
        if serverCertificateData.contains(where: { pinnedCertificates.contains($0) }) {
            return true
        } else {
            #if DEBUG
            print("❌ SSL Pinning failed: Certificate mismatch for host \(host)")
            serverCertificateData.forEach { data in
                print("Received Cert: \(data.base64EncodedString())")
            }
            pinnedCertificates.forEach { pinned in
                print("Pinned Cert: \(pinned.base64EncodedString())")
            }
            #endif
            return false
        }
    }
}

// MARK: - Certificate Loading
private extension APIService {

    static func loadPinnedCertificates() -> [Data] {
        let certificateNames = ["spaceflightnewsapi.net"]
        
        return certificateNames.compactMap { name in
            guard let certPath = Bundle.main.path(forResource: name, ofType: "cer"),
                  let certData = try? Data(contentsOf: URL(fileURLWithPath: certPath)) else {
                #if DEBUG
                print("⚠️ Certificate not found or invalid for name: \(name)")
                #endif
                return nil
            }
            return certData
        }
    }
}
