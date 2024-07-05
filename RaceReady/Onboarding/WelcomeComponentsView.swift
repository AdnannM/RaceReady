//
//  WelcomeComponentsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 05.07.24.
//

import SwiftUI

struct WelcomeComponentsView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            MainContentView()
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            MainTabbedView()
                .transition(.move(edge: .trailing))
        })
    }
}
