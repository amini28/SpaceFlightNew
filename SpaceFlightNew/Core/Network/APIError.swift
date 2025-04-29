//
//  APIError.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case badServerResponse
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .requestFailed(let error): return "Network error: \(error.localizedDescription)"
        case .decodingFailed(let error): return "Decoding error: \(error.localizedDescription)"
        case .badServerResponse: return "Bad response"
        case .unknown: return "Something went wrong"
        }
    }
}
