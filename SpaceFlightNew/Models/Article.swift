//
//  Article.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//
import Foundation

struct ArticleResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Article]?
}

struct Article: Codable, Hashable {
    let id: Int?
    let title: String?
    let authors: [Author]?
    let url: String?
    let imageURL: URL?
    let newsSite: String?
    let summary: String?
    let publishedAt: String?
    let updatedAt: String?
    let featured: Bool?
    let launches: [Launches]?
    let events: [Events]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case authors
        case url
        case imageURL = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
        case featured
        case launches
        case events
    }
}

struct Launches: Codable, Hashable {
    let launchedID: String?
    let provider: String?
    
    enum CodingKeys: String, CodingKey {
        case launchedID = "launch_id"
        case provider
    }

}

struct Events: Codable, Hashable {
    let eventID: Int?
    let provider: String?
    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case provider
    }
}
