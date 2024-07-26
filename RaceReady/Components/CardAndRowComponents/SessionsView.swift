//
//  SessionsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 26.07.24.
//

import SwiftUI

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

