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
    
    @Published var isAuthorized: Bool = false
    
    private init() {}
    
    func requestNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                self.isAuthorized = granted
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
    
    func scheduleNotification(for session: Session, title: String) {
        guard isAuthorized else { return }
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        guard let date = dateFormatter.date(from: "\(session.date)T\(session.time ?? "00:00:00Z")") else {
            print("Failed to parse date for \(title)")
            return
        }
        
        scheduleNotificationAt(date: date, minutes: 30, title: title)
        scheduleNotificationAt(date: date, minutes: 15, title: title)
    }
    
    private func scheduleNotificationAt(date: Date, minutes: Int, title: String) {
        let content = UNMutableNotificationContent()
        content.title = "F1 Event Reminder"
        content.body = "\(title) starts in \(minutes) minutes"
        content.sound = .default
        
        let triggerDate = date.addingTimeInterval(-Double(minutes * 60))
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let identifier = "\(title.lowercased().replacingOccurrences(of: " ", with: "_"))_\(minutes)min"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification for \(title): \(error)")
            } else {
                print("Notification scheduled for \(title) at \(triggerDate)")
            }
        }
    }
}
