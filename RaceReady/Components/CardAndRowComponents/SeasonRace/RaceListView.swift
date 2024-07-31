//
//  RaceListView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 31.07.24.
//

import SwiftUI

struct RaceListView: View {
    let races: [Race]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                RaceSection(title: "Upcoming Races", races: races.filter(\.isUpcoming), rowType: .card)
                RaceSection(title: "Finished Races", races: races.filter { !$0.isUpcoming }.reversed(), rowType: .row)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        .navigationTitle("F1 Race")
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}
