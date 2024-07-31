//
//  RaceCard.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 04.07.24.
//

import Foundation
import SwiftUI

import SwiftUI

struct RaceCard: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var notificationManager = NotificationManager.shared
    
    let race: Race
        
    var body: some View {
        VStack(spacing: 10) {
            RaceHeaderView(race: race, colorScheme: colorScheme)
            
            Divider().background(.purple)
            
            CircuitImageView(circuitImage: race.circuitImage)
            
            Divider().background(.purple)
            
            RaceInfoView(race: race)
            
            SessionsView(race: race)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)).shadow(radius: 2))
        .padding(.vertical, 10)
        .onAppear {
            notificationManager.requestNotification()
            scheduleAllNotifications()
        }
    }
    
    private func scheduleAllNotifications() {
        notificationManager.scheduleNotification(for: race.firstPractice, title: "Practice 1")
        race.secondPractice.map { notificationManager.scheduleNotification(for: $0, title: "Practice 2") }
        race.thirdPractice.map { notificationManager.scheduleNotification(for: $0, title: "Practice 3") }
        notificationManager.scheduleNotification(for: race.qualifying, title: "Qualifying")
        race.sprint.map { notificationManager.scheduleNotification(for: $0, title: "Sprint") }
        if let raceTime = race.time {
            let raceSession = Session(date: race.date, time: raceTime)
            notificationManager.scheduleNotification(for: raceSession, title: "Race")
        }
    }
}

func formatDateTime(date: String, time: String) -> String {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
    
    guard let dateTime = dateFormatter.date(from: "\(date)T\(time)") else {
        return "\(date) \(time)"
    }
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "MMM d HH:mm"
    outputFormatter.timeZone = TimeZone.current
    
    return outputFormatter.string(from: dateTime)
}
