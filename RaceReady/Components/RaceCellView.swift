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
                
                // Horizontal stack for all races
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(seasonModel.races, id: \.round) { race in
                            NavigationLink(destination: RaceDetailView()) {
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
                
                // Vertical stack for all races
                LazyVStack(alignment: .leading, spacing: 15) {
                    ForEach(seasonModel.races, id: \.round) { race in
                        NavigationLink(destination: RaceDetailView()) {
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
