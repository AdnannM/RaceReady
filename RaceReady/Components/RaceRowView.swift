//
//  RaceRowView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 03.07.24.
//

import SwiftUI

struct RaceRow: View {
    @Environment(\.colorScheme) var colorScheme
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            // Circuit name and flag
            HStack {
                Text(race.circuit.circuitName)
                    .font(.system(size: 25))
                    .fontWidth(.compressed)
                    .fontWeight(.medium)
                Spacer()
                Image("austria")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35)
                    .shadow(color: colorScheme == .dark ? .white : .black, radius: 0.5)
            }
            .padding(.bottom, 5)
            
            // Divider
            Divider()
            
            // Circuit image
            Image("austriaCircuit")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            // Divider
            Divider()
            
            // Race details
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
    }
}
