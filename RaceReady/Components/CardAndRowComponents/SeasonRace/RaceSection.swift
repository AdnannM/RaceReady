//
//  RaceSection.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 31.07.24.
//

import SwiftUI

enum RaceRowType {
    case card
    case row
}

struct RaceSection: View {
    let title: String
    let races: [Race]
    let rowType: RaceRowType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.leading)
                .opacity(0.6)
            
            if rowType == .card {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(races, id: \.round) { race in
                            NavigationLink(destination: RaceDetailView(race: race)) {
                                RaceCard(race: race)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                LazyVStack(alignment: .leading, spacing: 15) {
                    ForEach(races, id: \.round) { race in
                        NavigationLink(destination: RaceDetailView(race: race)) {
                            RaceRow(race: race)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
