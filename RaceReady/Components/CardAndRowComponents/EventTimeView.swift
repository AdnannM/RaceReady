//
//  EventTimeView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 26.07.24.
//

import SwiftUI

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

#Preview {
    EventTimeView(title: "Practice 1", session: Session.init(date: "25 Jun", time: "13:30"))
}
