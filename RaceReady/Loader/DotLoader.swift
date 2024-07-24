//
//  DotLoader.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 24.07.24.
//

import SwiftUI

struct DotLoader: View {
    
    // MARK: - Properties
    let particleCount: Int = 8
    let radius: CGFloat = 20.0
    @State private var particles: [Particle] = []
    @State private var opacity: Double = 0.5
    
    var loadingText: String
    
    // MARK: - Body
    var body: some View {
        VStack {
            ZStack {
                ForEach(particles) { particle in
                    Circle()
                        .frame(width: 10, height: 20)
                        .offset(x: radius * CGFloat(cos(particle.angle * .pi/180)),
                                y: radius * CGFloat(sin(particle.angle * .pi/180)))
                        .foregroundStyle(Color.secondary.opacity(0.5))
                }
            }
            .frame(width: 100, height: 100)
            
            Text(loadingText)
                .foregroundStyle(.secondary)
                .opacity(opacity)
                .animation(
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true),
                    value: opacity
                )
                .onAppear {
                    opacity = 1.0
                }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .onAppear {
            initializeParticles()
            animateParticles()
        }
    }
    
    // MARK: - Helper Methods
    private func initializeParticles() {
        particles = (0..<particleCount).map { index in
            Particle(id: UUID(), angle: Double(index) * (360.0 / Double(particleCount)))
        }
    }
    
    private func animateParticles() {
        withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
            particles = particles.map { particle in
                Particle(id: particle.id, angle: particle.angle - 600.0)
            }
        }
    }
}

struct Particle: Identifiable {
    let id: UUID
    let angle: Double
}

#Preview {
    DotLoader(loadingText: "Loading Drivers ...")
}
