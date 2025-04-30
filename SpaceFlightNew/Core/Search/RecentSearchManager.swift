//
//  RecentSearchManager.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation

class RecentSearchManager {
    private static let key = "recentSearchKeywords"
    private static let maxKeywords = 10

    static func addKeyword(_ keyword: String) {
        var keywords = getKeywords()
        keywords.removeAll { $0.lowercased() == keyword.lowercased() }
        keywords.insert(keyword, at: 0)
        if keywords.count > maxKeywords {
            keywords = Array(keywords.prefix(maxKeywords)) 
        }
        UserDefaults.standard.set(keywords, forKey: key)
    }

    static func getKeywords() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    static func removeKeyword(_ keyword: String) {
        var keywords = getKeywords()
        keywords.removeAll { $0.lowercased() == keyword.lowercased() }
        UserDefaults.standard.set(keywords, forKey: key)
    }

    static func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
