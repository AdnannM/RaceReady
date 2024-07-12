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
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: geometry.size.height * 0.02) {
                    TitleView()
                    
                    WelcomeImageView(screenHeight: geometry.size.height)
                    
                    FeatureListView()
                    
                    Spacer(minLength: geometry.size.height * 0.05)
                    
                    ContinueButtonView(isPresented: $isPresented, screenWidth: geometry.size.width)
                }
                .padding(.vertical, geometry.size.height * 0.03)
            }
            .background(Color(UIColor.systemBackground))
            .cornerRadius(16)
            .padding(.horizontal, geometry.size.width * 0.05)
        }
    }
}

struct TitleView: View {
    var body: some View {
        Text("Race Ready")
            .fontWeight(.heavy)
            .font(.system(size: UIScreen.main.bounds.width * 0.1))
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .gradientForeground(colors: [.red, .yellow])
            .padding(.top)
    }
}

struct WelcomeImageView: View {
    let screenHeight: CGFloat
    
    var body: some View {
        Image("welcome")
            .resizable()
            .scaledToFit()
            .frame(height: screenHeight * 0.25)
            .clipped()
            .padding(.horizontal, -20)
            .padding(.top, screenHeight * 0.03)
    }
}

struct FeatureListView: View {
    var body: some View {
        WelcomeSectionView()
    }
}

struct ContinueButtonView: View {
    @Binding var isPresented: Bool
    let screenWidth: CGFloat
    
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
                .frame(width: min(280, screenWidth * 0.8), height: 55)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(17)
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            MainTabbedView()
                .transition(.move(edge: .trailing))
        })
        .animation(.easeInOut(duration: 0.5), value: isPresented)
    }
}
