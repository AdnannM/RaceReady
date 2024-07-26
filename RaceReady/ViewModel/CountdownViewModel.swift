//
//  CountdownViewModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//
import SwiftUI
import Combine


struct RaceEvent: Identifiable {
    let id = UUID()
    let name: String
    let date: Date
}

class CountdownViewModel: ObservableObject {
    @Published var days: Int = 0
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var currentEventName: String = ""
    
    private var timer: AnyCancellable?
    private let centralEuropeanTimeZone = TimeZone(identifier: "Europe/Berlin")!
    private var events: [RaceEvent] = []
    private var currentEventIndex: Int = 0
    
    func setRace(_ race: Race) {
        let events = createEvents(from: race)
        setEvents(events)
    }
    
    private func setEvents(_ newEvents: [RaceEvent]) {
        self.events = newEvents.sorted { $0.date < $1.date }
        updateToNextEvent()
    }
    
    private func updateToNextEvent() {
        let now = Date()
        if let nextEventIndex = events.firstIndex(where: { $0.date > now }) {
            currentEventIndex = nextEventIndex
            startCountdown(to: events[currentEventIndex].date)
            currentEventName = events[currentEventIndex].name
        } else {
            // All events have passed
            timer?.cancel()
            currentEventName = "All events completed"
            days = 0
            hours = 0
            minutes = 0
        }
    }
    
    private func createEvents(from race: Race) -> [RaceEvent] {
        let dateFormatter = ISO8601DateFormatter()
        var events: [RaceEvent] = []
        
        if let fp1Time = race.firstPractice.time,
           let fp1Date = dateFormatter.date(from: "\(race.firstPractice.date)T\(fp1Time)") {
            events.append(RaceEvent(name: "First Practice", date: fp1Date))
        }
        
        if let fp2 = race.secondPractice,
           let fp2Time = fp2.time,
           let fp2Date = dateFormatter.date(from: "\(fp2.date)T\(fp2Time)") {
            events.append(RaceEvent(name: "Second Practice", date: fp2Date))
        }
        
        if let fp3 = race.thirdPractice,
           let fp3Time = fp3.time,
           let fp3Date = dateFormatter.date(from: "\(fp3.date)T\(fp3Time)") {
            events.append(RaceEvent(name: "Third Practice", date: fp3Date))
        }
        
        if let qualTime = race.qualifying.time,
           let qualDate = dateFormatter.date(from: "\(race.qualifying.date)T\(qualTime)") {
            events.append(RaceEvent(name: "Qualifying", date: qualDate))
        }
        
        if let sprint = race.sprint,
           let sprintTime = sprint.time,
           let sprintDate = dateFormatter.date(from: "\(sprint.date)T\(sprintTime)") {
            events.append(RaceEvent(name: "Sprint", date: sprintDate))
        }
        
        if let raceTime = race.time,
           let raceDate = dateFormatter.date(from: "\(race.date)T\(raceTime)") {
            events.append(RaceEvent(name: "Race", date: raceDate))
        }
        
        return events
    }
    
    func startCountdown(to date: Date) {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                let timeInterval = self.getTimeIntervalToCentralEuropeanTime(date: date)
                if timeInterval > 0 {
                    self.updateTimeRemaining(timeInterval)
                } else {
                    self.updateToNextEvent()
                }
            }
        // Initial update
        let timeInterval = getTimeIntervalToCentralEuropeanTime(date: date)
        if timeInterval > 0 {
            self.updateTimeRemaining(timeInterval)
        }
    }
    
    private func getTimeIntervalToCentralEuropeanTime(date: Date) -> TimeInterval {
        let currentDate = Date()
        let centralEuropeanOffset = centralEuropeanTimeZone.secondsFromGMT(for: currentDate)
        let localOffset = TimeZone.current.secondsFromGMT(for: currentDate)
        let offsetDifference = TimeInterval(centralEuropeanOffset - localOffset)
        return date.timeIntervalSinceNow + offsetDifference
    }
    
    private func updateTimeRemaining(_ timeInterval: TimeInterval) {
        let totalMinutes = Int(timeInterval / 60)
        let totalHours = totalMinutes / 60
        days = totalHours / 24
        hours = totalHours % 24
        minutes = totalMinutes % 60
    }
}
