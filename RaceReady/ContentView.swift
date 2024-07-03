//
//  ContentView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            WelcomeView()
                .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
