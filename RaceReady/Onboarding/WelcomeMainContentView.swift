//
//  WelcomeMainContentView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 05.07.24.
//

import SwiftUI

struct MainContentView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            TitleView()
            
            WelcomeImageView()
            
            FeatureListView()
            
            Spacer()
            
            ContinueButtonView(isPresented: $isPresented)
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .padding()
    }
}

struct TitleView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Race Ready")
                .fontWeight(.bold)
                .font(.system(size: 45)).fontWeight(.heavy).gradientForeground(colors: [.red, .yellow])
            Spacer()
        }
        .padding(.top)
    }
}

struct WelcomeImageView: View {
    var body: some View {
        Image("welcome")
            .resizable()
            .scaledToFit()
            .frame(width: 500, height: 200)
            .clipped()
            .padding(.horizontal, -20)
            .padding(.top, 30)
    }
}

struct FeatureListView: View {
    var body: some View {
        WelcomeSectionView()
    }
}

struct ContinueButtonView: View {
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                isPresented = true
            }
        }) {
            Text("Continue")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 280, height: 60)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(17)
        }
    }
}
