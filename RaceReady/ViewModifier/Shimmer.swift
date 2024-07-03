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
                LinearGradient(
                    gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.6), Color.clear]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .mask(content)
                .rotationEffect(.degrees(0))
                .offset(x: phase * 2 * UIScreen.main.bounds.width, y: 0)
            )
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    self.phase = 1
                }
            }
    }
}



extension View {
    @ViewBuilder func shimmerIf(_ condition: Bool) -> some View {
        if condition {
            self.modifier(Shimmer())
        } else {
            self
        }
    }
}
