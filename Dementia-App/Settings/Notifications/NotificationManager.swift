//
//  NotificationManager.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 09/09/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import Foundation
import Combine
import UserNotifications

class NotificationManager {
    lazy var notificationCenter = UNUserNotificationCenter.current()
    private var printNotificationsCancellable: AnyCancellable?
    
    func printNotifications() {
        printNotificationsCancellable = pendingNotificationRequestsPublisher.sink { requests in
            print("--- notifications ---")
            requests.forEach { request in
                print(request)
            }
            print("--- end: notifications ---")
        }
    }
    
    func requestPermissions(completion: @escaping (_ granted: Bool) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Error \(error)")
            }
            completion(granted)
        }
    }
    
    var notificationsSettingsPublisher: Publishers.Share<AnyPublisher<UNAuthorizationStatus, Never>> {
        getNotificationSettings()
            .map { $0.authorizationStatus }
            .eraseToAnyPublisher()
            .share()
    }
    
    private func getNotificationSettings() -> Future<UNNotificationSettings, Never> {
        Future { resolve in
            self.notificationCenter.getNotificationSettings { (settings) in
                resolve(.success(settings))
            }
        }
    }
    
    var pendingNotificationRequestsPublisher: Publishers.Share<AnyPublisher<[UNNotificationRequest], Never>> {
        Future { resolve in
            self.notificationCenter.getPendingNotificationRequests { (settings) in
                resolve(.success(settings))
            }
        }.eraseToAnyPublisher().share()
    }
}
