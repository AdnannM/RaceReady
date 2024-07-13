//
//  DriversView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

struct DriversView: View {
    var body: some View {
        List {
            ForEach(0..<5) { _ in
                Text("Drivers")
                    .font(.title3)
                    .padding(.vertical, 40)
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
        }
        .navigationTitle("Drivers")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    DriversView()
}
