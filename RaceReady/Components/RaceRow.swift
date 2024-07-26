//
//  RaceRow.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 04.07.24.
//

import Foundation
import SwiftUI

struct RaceRow: View {
    @Environment(\.colorScheme) var colorScheme
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            
            RaceHeaderView(race: race, colorScheme: colorScheme)
            
            Divider().background(.purple)

            CircuitImageView(circuitImage: race.circuitImage)
            
            Divider().background(.purple)
            
            RaceInfoView(race: race)
            
            HStack {
                Text("\(race.firstPractice.date.formattedDate()) - \(race.date.formattedDate())")
                    .padding(3)
                    .foregroundStyle(.secondary)
                    .background(Color("ColorBlue").opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                Spacer()
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)).shadow(radius: 2))
        .padding(.vertical, 10)  // Add vertical padding
    }
}
