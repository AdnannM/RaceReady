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

struct RaceHeaderView: View {
    let race: Race
    let colorScheme: ColorScheme
    
    var body: some View {
        HStack {
            Text(race.circuit.circuitName)
                .font(.system(size: 25))
                .fontWidth(.compressed)
                .fontWeight(.medium)
            Spacer()
            FlagImageView(flag: race.countryFlag, colorScheme: colorScheme)
        }
        .padding(.bottom, 5)
    }
}

struct FlagImageView: View {
    let flag: String?
    let colorScheme: ColorScheme
    
    var body: some View {
        if let flag = flag {
            Image(flag)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35)
                .shadow(color: colorScheme == .dark ? .white : .black, radius: 0.5)
        }
    }
}

struct CircuitImageView: View {
    let circuitImage: String?
    
    var body: some View {
        if let circuitImage = circuitImage {
            Image(circuitImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
        }
    }
}

struct RaceInfoView: View {
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(race.raceName)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("Round \(race.round)")
                    .foregroundStyle(.secondary)
            }
//            HStack {
//                Text("\(race.firstPractice.date.formattedDate()) - \(race.date.formattedDate())")
//                    .padding(3)
//                    .foregroundStyle(.secondary)
//                    .background(Color("ColorBlue").opacity(0.8))
//                    .clipShape(RoundedRectangle(cornerRadius: 4))
//                Spacer()
//            }
        }
    }
}

struct SessionsView: View {
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            EventTimeView(title: "Practice 1", session: race.firstPractice)
            race.secondPractice.map { EventTimeView(title: "Practice 2", session: $0) }
            race.thirdPractice.map { EventTimeView(title: "Practice 3", session: $0) }
            EventTimeView(title: "Qualification", session: race.qualifying)
            race.sprint.map { EventTimeView(title: "Sprint", session: $0) }
            EventTimeView(title: "Race", date: race.date, time: race.time ?? "TBA")
        }
        .padding(.vertical, 5)
    }
}

struct EventTimeView: View {
    let title: String
    let date: String
    let time: String
    
    init(title: String, session: Session) {
        self.init(title: title, date: session.date, time: session.time ?? "TBA")
    }
    
    init(title: String, date: String, time: String) {
        self.title = title
        self.date = date
        self.time = time
    }
    
    var body: some View {
        GroupBox {
            HStack {
                Text(title)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(formatDateTime(date: date, time: time))
                    .foregroundStyle(.secondary)
            }
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
