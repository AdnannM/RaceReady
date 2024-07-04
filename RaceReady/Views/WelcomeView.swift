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
            LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
              .ignoresSafeArea()
            VStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isPresented = true
                    }
                }) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: 250)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(16)
                }
            }
            .fullScreenCover(isPresented: $isPresented, content: {
                MainTabbedView()
                    .transition(.move(edge: .trailing))
            })
            
        .animation(.easeInOut(duration: 0.5), value: isPresented)
        }
    }
}

#Preview {
    WelcomeView().environmentObject(SeasonModel(webservice: WebService()))
}
