//
//  RaceCard.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 04.07.24.
//

import Foundation
import SwiftUI

struct RaceCard: View {
    @Environment(\.colorScheme) var colorScheme
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(race.circuit.circuitName)
                    .font(.system(size: 25))
                    .fontWidth(.compressed)
                    .fontWeight(.medium)
                Spacer()
                if let flag = race.countryFlag {
                    Image(flag)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35)
                    .shadow(color: colorScheme == .dark ? .white : .black, radius: 0.5)
                }
            }
            .padding(.bottom, 5)
            
            Divider()
            
            if let circuitImage = race.circuitImage {
                Image(circuitImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            }
            
            Divider()
            
            VStack(spacing: 10) {
                HStack {
                    Text(race.raceName)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("Round \(race.round)")
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("\(race.firstPractice.date.formattedDate()) - \(race.date.formattedDate())")
                        .padding(3)
                        .foregroundStyle(.secondary)
                        .background(Color("ColorBlue").opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    Spacer()
                }
            }
            .padding(.vertical, 5)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)).shadow(radius: 2))
        .padding(.vertical, 10)  // Add vertical padding
    }
}
