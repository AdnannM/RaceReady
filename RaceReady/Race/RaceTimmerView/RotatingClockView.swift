//
//  RotatingClockView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI

struct RotatingClockView: View {
    @State private var currentTime = Date()

    var body: some View {
        Image(systemName: "clock.circle")
            .font(.system(size: 70))
            .rotationEffect(.degrees(secondHandAngle))
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    currentTime = Date()
                }
            }
    }

    private var secondHandAngle: Double {
        let calendar = Calendar.current
        let seconds = calendar.component(.second, from: currentTime)
        return Double(seconds) * 6.0
    }
}
