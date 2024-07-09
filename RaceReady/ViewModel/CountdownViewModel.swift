//
//  CountdownViewModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI

// Your CountdownViewModel should also be present here
class CountdownViewModel: ObservableObject {
    @Published var days: Int = 0
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    
    private var timer: Timer?
    
    func startCountdown(to date: Date) {
        stopCountdown()
        
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.updateCountdown(to: date)
        }
        
        updateCountdown(to: date)
    }
    
    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateCountdown(to date: Date) {
        let now = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.day, .hour, .minute], from: now, to: date)
        
        days = components.day ?? 0
        hours = components.hour ?? 0
        minutes = components.minute ?? 0
    }
    
    deinit {
        stopCountdown()
    }
}
