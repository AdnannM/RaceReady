//
//  WelcomeView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            WelcomeComponentsView()
        }
        .animation(.easeInOut(duration: 0.5), value: isPresented)
    }
}

#Preview {
    WelcomeView().environmentObject(SeasonModel(webservice: WebService()))
}



