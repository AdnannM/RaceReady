//
//  TimeUnitView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI

struct TimeUnitView: View {
    let value: Int
    let unit: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.largeTitle)
            Text(unit)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}
