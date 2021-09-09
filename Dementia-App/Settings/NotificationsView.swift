//
//  NotificationsView.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 09/09/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct NotificationsView: View {
    @State private var notifications: Bool = false
    @State private var morningReminder: Date = Date(timeIntervalSince1970: 8 * 60 * 60)
    @State private var afternoonReminder: Date = Date(timeIntervalSince1970: 12 * 60 * 60)
    @State private var eveningReminder: Date = Date(timeIntervalSince1970: 18 * 60 * 60)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Notifications")
                .font(.headline)
                .alignmentGuide(.leading, computeValue: { dimension in
                    dimension[.leading]
                })
            Toggle("I would like to receive reminders to track my symptoms:", isOn: $notifications)
                .font(.footnote)
                .fixedSize()
            
            if notifications {
                VStack(alignment: .leading, spacing: 5) {
                    DatePicker("Morning Reminder:", selection: $morningReminder, displayedComponents: .hourAndMinute)
                        .timePickerStyle()
                    DatePicker("Afternoon Reminder:", selection: $afternoonReminder, displayedComponents: .hourAndMinute)
                        .timePickerStyle()
                    DatePicker("Evening Reminder:", selection: $eveningReminder, displayedComponents: .hourAndMinute)
                        .timePickerStyle()
                }.fixedSize()
            }
        }
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
