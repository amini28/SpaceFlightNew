//
//  NotificationManager.swift
//  SpaceFlightNew
//
//  Created by Amini on 29/04/25.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(granted)")
            }
        }
    }
}

extension NotificationManager {
    func scheduleLogoutNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Session Expired"
        content.body = "You have been logged out due to inactivity."
        content.sound = .default

        // Trigger notification immediately
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "logoutNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Logout notification scheduled.")
            }
        }
    }
}
