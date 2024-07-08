//
//  RaceCellView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 04.07.24.
//

import Foundation
import SwiftUI

struct RaceCellView: View {
    
    @EnvironmentObject var seasonModel: SeasonModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                
                Text("Upcoming Races")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .opacity(0.6)
                
                // Horizontal stack for all upcoming races
                   ScrollView(.horizontal, showsIndicators: false) {
                       LazyHStack(spacing: 15) {
                           ForEach(seasonModel.races.filter { $0.isUpcoming }, id: \.round) { race in
                               NavigationLink(destination: RaceDetailView(race: race)) {
                                   RaceCard(race: race)
                                       .foregroundColor(.primary)
                               }
                           }
                       }
                       .padding(.horizontal)
                   }
                
                Text("Finished Races")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.leading)
                    .opacity(0.6)
                    
                // Vertical stack for all finished races
                LazyVStack(alignment: .leading, spacing: 15) {
                    ForEach(seasonModel.races.filter { !$0.isUpcoming }.reversed(), id: \.round) { race in
                        NavigationLink(destination: RaceDetailView(race: race)) {
                            RaceRow(race: race)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        .navigationTitle("F1 Race")
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}


extension Race {
    var isUpcoming: Bool {
        guard let raceDate = date.toDate() else { return false }
        return raceDate >= Date()
    }
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}
