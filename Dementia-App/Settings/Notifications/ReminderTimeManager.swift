//
//  ReminderTimeManager.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 09/09/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import Foundation

private let notificationsOnKey = "notificationsOn"

class ReminderTimeManager {
    
    private static let reminderKeyPrefix = "reminder"
    private static let morningReminderDefault = Date(timeIntervalSince1970: 8 * 60 * 60)
    private static let afternoonReminderDefault = Date(timeIntervalSince1970: 12 * 60 * 60)
    private static let eveningReminderDefault = Date(timeIntervalSince1970: 18 * 60 * 60)
    private let reminderNotificationManager = ReminderNotificationManager()
    
    var notificationsOn: Bool {
        get {
            UserDefaults.standard.bool(forKey: notificationsOnKey)
        }
        set {
            if newValue {
                UserDefaults.standard.set(true, forKey: notificationsOnKey)
                reminderNotificationManager.scheduleNotifications(dates: reminderTimes)
                return
            }
            UserDefaults.standard.removeObject(forKey: notificationsOnKey)
            reminderNotificationManager.cancelNotifications()
        }
    }
    
    var reminderTimes: [Date] {
        set {
            newValue.enumerated().forEach { index, date in
                UserDefaults.standard.set(date, forKey: "\(ReminderTimeManager.reminderKeyPrefix)\(index)")
            }
            reminderNotificationManager.scheduleNotifications(dates: reminderTimes)
        }
        get {
            [
                reminderTime(at: 0) ?? ReminderTimeManager.morningReminderDefault,
                reminderTime(at: 1) ?? ReminderTimeManager.afternoonReminderDefault,
                reminderTime(at: 2) ?? ReminderTimeManager.eveningReminderDefault,
            ]
        }
    }
    
    private func reminderTime(at index: Int) -> Date? {
        UserDefaults.standard.value(forKey: "\(ReminderTimeManager.reminderKeyPrefix)\(index)") as? Date
    }
}
