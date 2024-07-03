//
//  Shimmer.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 03.07.24.
//

import Foundation
import SwiftUI

struct Shimmer: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.6), Color.clear]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: width, height: height)
                        .rotationEffect(.degrees(180))
                        .offset(x: -width + phase * (width * 2), y: 0)
                    }
                    .mask(content)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                            self.phase = 1
                        }
                    }
                }
            )
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(Shimmer())
    }
}
