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
        VStack {
            
            Spacer()
            Button(action: {
                isPresented = true
            }) {
                Text("Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 250)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(16)
            }
            .fullScreenCover(isPresented: $isPresented) {
                MainView()
            }
        }
        .padding()
        
    }
}

#Preview {
    WelcomeView()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
}
