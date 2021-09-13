//
//  ReminderNotificationManager.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 09/09/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import Foundation
import UserNotifications

class ReminderNotificationManager {
    enum Constants {
        static let notificationIdentifier = "TrackSymptomsReminder"
        static let maxNotificationsCount = 3
    }
    
    private lazy var notificationCenter = UNUserNotificationCenter.current()
    
    private var allIdentifiers: [String] {
        (0 ..< 3).map { notificationIdentifier(forIndex: $0) }
    }
    
    func scheduleNotifications(dates: [Date]) {
        dates.enumerated().forEach { index, date in
            let request = makeNotificationRequest(date: date, index: index)
            notificationCenter.add(request) { (error: Error?) in
                 if let error = error {
                    print("Scheduling notifications failed: ", error)
                 }
            }
        }
    }
    
    func cancelNotifications() {
        notificationCenter.removeDeliveredNotifications(withIdentifiers: allIdentifiers)
        notificationCenter.removePendingNotificationRequests(
            withIdentifiers: allIdentifiers
        )
    }
    
    private func makeNotificationRequest(date: Date, index: Int) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Dementia: track symptoms"
        content.body = "It's time to track your symptoms"
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: date), repeats: true)
        return UNNotificationRequest(identifier: notificationIdentifier(forIndex: index),
                                     content: content,
                                     trigger: trigger)
    }
    
    private func notificationIdentifier(forIndex index: Int) -> String {
        "\(Constants.notificationIdentifier)\(index)"
    }
    
    private func dateComponents(for date: Date) -> DateComponents {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.dateComponents([.hour, .minute], from: date)
    }
}
