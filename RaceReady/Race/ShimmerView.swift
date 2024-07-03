//
//  ShimmerView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 02.07.24.
//

import SwiftUI

struct ShimmerView: View {
    var body: some View {
        HStack {
            Text("Data is Loading")
                .modifier(Shimmer())
                .opacity(0.6)
                .padding(.trailing, 10)
            ProgressView()
        }
            List {
                ForEach(0..<3, id: \.self) { _ in
                    VStack(spacing: 10) {
                        // Circuit name and flag
                        HStack {
                            Rectangle()
                                .fill(Color.gray)
                                .opacity(0.3)
                                 .frame(width: 200, height: 40)
                                .cornerRadius(5)
                                .modifier(Shimmer())
                            Spacer()
                            Rectangle()
                                .fill(Color.gray)
                                .opacity(0.3)
                                .frame(width: 70, height: 40)
                                .cornerRadius(5)
                                .modifier(Shimmer())
                        }
                        .padding(.bottom, 5)
                        
                        // Divider
                        Divider()
                        
                        // Circuit image
                        Rectangle()
                            .fill(Color.gray)
                            .opacity(0.3)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .modifier(Shimmer())
                        
                        // Divider
                        Divider()
                        
                        // Race details
                        VStack(spacing: 10) {
                            HStack {
                                Rectangle()
                                    .fill(Color.gray)
                                    .opacity(0.3)
                                     .frame(width: 150, height: 20)
                                    .cornerRadius(5)
                                    .modifier(Shimmer())
                                Spacer()
                                Rectangle()
                                    .fill(Color.gray)
                                    .opacity(0.3)
                                     .frame(width: 70, height: 20)
                                    .cornerRadius(5)
                                    .modifier(Shimmer())
                            }
                            
                            HStack {
                                Rectangle()
                                    .fill(Color.gray)
                                    .opacity(0.3)
                                     .frame(width: 150, height: 20)
                                    .cornerRadius(5)
                                    .modifier(Shimmer())
                                Spacer()
                            }
                        }
                    }
                }
            }
    }
}



#Preview {
    ShimmerView()
}


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


