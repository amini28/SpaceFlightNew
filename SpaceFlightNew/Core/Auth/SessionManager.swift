//
//  SessionManager.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import Foundation

class SessionManager {
    private static let loginDateKey = "lastLoginDate"

    static var lastLoginDate: Date? {
        get {
            UserDefaults.standard.object(forKey: loginDateKey) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: loginDateKey)
        }
    }

    static func clearSession() {
        UserDefaults.standard.removeObject(forKey: loginDateKey)
    }

    static func isSessionExpired(timeout: TimeInterval = 600) -> Bool {
        guard let lastLogin = lastLoginDate else {
            return true
        }
        return Date().timeIntervalSince(lastLogin) > timeout
    }
}
