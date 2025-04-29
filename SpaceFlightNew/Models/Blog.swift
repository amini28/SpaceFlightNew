//
//  Blog.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation

struct Blog: Codable {
    let id: Int
    let title: String
    let authors: [Author]
    let url: String
    let imageURL: URL
    let content: String
    let publishedAt: Date
    let updatedAt: Date
    let featured: Bool
    let tags: [String]
    let relatedLinks: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case authors
        case url
        case imageURL = "image_url"
        case content
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case featured
        case tags
        case relatedLinks = "related_links"
    }
}

struct BlogDetail: Decodable {
    let id: Int
    let title: String
    let summary: String
    let content: String
    let url: String
    let imageUrl: String
    let publishedAt: String
    let updatedAt: String
    let authors: [Author]
    let newsSite: String
}
