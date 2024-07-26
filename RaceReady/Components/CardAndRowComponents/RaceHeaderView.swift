//
//  RaceHeaderView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 26.07.24.
//

import SwiftUI

struct RaceHeaderView: View {
    let race: Race
    let colorScheme: ColorScheme
    
    var body: some View {
        HStack {
            Text(race.circuit.circuitName)
                .font(.system(size: 25))
                .fontWidth(.compressed)
                .fontWeight(.medium)
            Spacer()
            FlagImageView(flag: race.countryFlag, colorScheme: colorScheme)
        }
        .padding(.bottom, 5)
    }
}
