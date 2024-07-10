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
    
    func startCountdown(to date: Date) {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                let timeInterval = date.timeIntervalSinceNow
                if timeInterval > 0 {
                    self.updateTimeRemaining(timeInterval)
                } else {
                    self.timer?.cancel()
                }
            }
        // Initial update
        let timeInterval = date.timeIntervalSinceNow
        if timeInterval > 0 {
            self.updateTimeRemaining(timeInterval)
        }
    }
    
    private func updateTimeRemaining(_ timeInterval: TimeInterval) {
        let totalMinutes = Int(timeInterval / 60)
        let totalHours = totalMinutes / 60
        days = totalHours / 24
        hours = totalHours % 24
        minutes = totalMinutes % 60
    }
}
