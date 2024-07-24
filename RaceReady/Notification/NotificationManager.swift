//
//  NotificationManager.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 24.07.24.
//

import SwiftUI
import UserNotifications

class NotificationManager: ObservableObject {
    
    static let shared = NotificationManager()
    
    @Published var isAutorized: Bool = false
    
    private init() {}
    
    func requestNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                self.isAutorized = granted
            }
            
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            } else if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
    }
}
