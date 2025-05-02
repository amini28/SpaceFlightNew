//
//  Blog.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation

struct BlogDetail: Codable {
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
