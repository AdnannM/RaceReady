//
//  CircuitInfoRow.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI

struct CircuitInfoRow: View {
    let title: String
    let value: String
    let km: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            HStack(alignment: .lastTextBaseline) {
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                if let km = km {
                    Text(km)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding()
        .frame(width: 170, alignment: .topLeading)
        .overlay (
            BottomRightRoundedBorder()
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
