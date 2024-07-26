//
//  FinnisedRaceView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 26.07.24.
//

import SwiftUI

struct FinnisedRaceView: View {
    var body: some View {
        NavigationStack {
            GroupBox {
                HStack {
                    Text("Pos")
                    Text("Driver")
                    Spacer()
                    Text("Time/Ret")
                    Text("Pts")
                }
            }
            .padding(.horizontal)
            Spacer()
        }.navigationTitle("Race Results")
    }
}

#Preview {
    NavigationStack {
        FinnisedRaceView()
    }
}
