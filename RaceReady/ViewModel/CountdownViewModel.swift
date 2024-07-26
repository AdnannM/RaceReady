//
//  CountdownViewModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI
import Combine

class CountdownViewModel: ObservableObject {
    @Published var days: Int = 0
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    
    private var timer: AnyCancellable?
    private let centralEuropeanTimeZone = TimeZone(identifier: "Europe/Berlin")!
    
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
                    self.timer?.cancel()
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
