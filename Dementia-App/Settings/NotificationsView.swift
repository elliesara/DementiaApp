//
//  NotificationsView.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 09/09/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI
import Combine

private let notificationsOnKey = "notificationsOn"

struct NotificationsView: View {
    @State private var notificationsOn = false
    @State private var notificationsDenied = false
    @State private var morningReminder = Date()
    @State private var afternoonReminder = Date()
    @State private var eveningReminder = Date()
    
    private let notificationManager = NotificationManager()
    private let reminderTimeManager = ReminderTimeManager()
    @State private var notificationsSettingsPublisher: AnyCancellable?
    
    private var notificationsStored: Bool {
        UserDefaults.standard.bool(forKey: notificationsOnKey)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Notifications")
                .font(.headline)
                .alignmentGuide(.leading, computeValue: { dimension in
                    dimension[.leading]
                })
            if notificationsDenied {
                Group {
                    Text("Notifications are disabled within iPhone Settings.")
                    Button("Go to settings") {
                        goToSettings()
                    }
                }.font(.footnote)
            } else {
                Toggle("I would like to receive reminders to track my symptoms:", isOn: $notificationsOn.onChange({ isOn in
                    handleNotificationsOnChange(isOn: isOn)
                }))
                    .font(.footnote)
                    .fixedSize()
                
                if notificationsOn {
                    VStack(alignment: .leading, spacing: 5) {
                        DatePicker("Morning Reminder:", selection: $morningReminder.onChange({ _ in
                            saveReminders()
                        }), displayedComponents: .hourAndMinute)
                            .timePickerStyle()
                        DatePicker("Afternoon Reminder:", selection: $afternoonReminder.onChange({ _ in
                            saveReminders()
                        }), displayedComponents: .hourAndMinute)
                            .timePickerStyle()
                        DatePicker("Evening Reminder:", selection: $eveningReminder.onChange({ _ in
                            saveReminders()
                        }), displayedComponents: .hourAndMinute)
                            .timePickerStyle()
                    }.fixedSize()
                }
            }
        }.onAppear {
            readReminderTimes()
            readNotificationSettings()
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            readNotificationSettings()
        }
    }
    
    private func handleNotificationsOnChange(isOn: Bool) {
        if isOn {
            requestPermissions()
            return
        }
        UserDefaults.standard.removeObject(forKey: notificationsOnKey)
        readNotificationSettings()
    }
    
    private func readNotificationSettings() {
        notificationsSettingsPublisher?.cancel()
        notificationsSettingsPublisher = notificationManager.notificationsSettingsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: {
                switch $0 {
                case .authorized where notificationsStored:
                    notificationsOn = true
                    notificationsDenied = false
                case .denied:
                    notificationsDenied = true
                    notificationsOn = false
                default:
                    notificationsOn = false
                    notificationsDenied = false
                }
            })
    }
    
    private func requestPermissions() {
        notificationManager.requestPermissions { granted in
            DispatchQueue.main.async {
                if granted {
                    UserDefaults.standard.set(true, forKey: notificationsOnKey)
                }
                readNotificationSettings()
            }
        }
    }
    
    private func goToSettings() {
        guard let bundleIdentifier = Bundle.main.bundleIdentifier,
              let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier),
              UIApplication.shared.canOpenURL(appSettings) else {
            return
        }
        UIApplication.shared.open(appSettings)
    }
    
    private func saveReminders() {
        reminderTimeManager.reminderTimes = [morningReminder, afternoonReminder, eveningReminder]
    }
    
    private func readReminderTimes() {
        let reminderTimes = reminderTimeManager.reminderTimes
        morningReminder = reminderTimes[0]
        afternoonReminder = reminderTimes[1]
        eveningReminder = reminderTimes[2]
    }
}

private extension View {
    func timePickerStyle() -> some View {
        self.environment(\.timeZone, TimeZone(secondsFromGMT: 0)!)
            .font(.footnote.weight(.bold))
            .frame(maxWidth: .infinity)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
