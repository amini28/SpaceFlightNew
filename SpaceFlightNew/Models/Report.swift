//
//  Report.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//
import Foundation

struct Report: Codable {
    let id: Int
    let title: String
    let authors: [Author]
    let url: String
    let imageURL: URL
    let newsSite: String
    let summary: String
    let publishedAt: Date
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id, title, authors, url
        case imageURL = "image_url"
        case newsSite = "news_site"
        case summary
        case publishedAt = "published_at"
        case updatedAt = "updated_at"
    }
}
