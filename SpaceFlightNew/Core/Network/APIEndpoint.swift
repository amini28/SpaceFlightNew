//
//  APIEndpoint.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation

enum APIEndpoint {
    case getArticles
    case getArticle(id: Int)
    case getBlogs
    case getBlog(id: Int)
    case getReports
    case getReport(id: Int)

    var baseURL: String {
        return "https://api.spaceflightnewsapi.net/v4"
    }

    var path: String {
        switch self {
        case .getArticles:
            return "/articles"
        case .getArticle(let id):
            return "/articles/\(id)"
        case .getBlogs:
            return "/blogs"
        case .getBlog(let id):
            return "/blogs/\(id)"
        case .getReports:
            return "/reports"
        case .getReport(let id):
            return "/reports/\(id)"
        }
    }

    var method: String {
        switch self {
        case .getArticles, .getArticle, .getBlogs, .getBlog, .getReports, .getReport:
            return "GET"
        }
    }

    var urlRequest: URLRequest {
        let urlString = baseURL + path
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }

    var headers: [String: String] {
        return [
            "Content-Type": "application/json",
        ]
    }
}
