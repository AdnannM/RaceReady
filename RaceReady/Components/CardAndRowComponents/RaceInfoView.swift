//
//  RaceInfoView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 26.07.24.
//

import SwiftUI

struct RaceInfoView: View {
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(race.raceName)
                    .font(.title2)
                    .fontWidth(.compressed)
                    .fontWeight(.medium)
                Spacer()
                Text("Round \(race.round)")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

