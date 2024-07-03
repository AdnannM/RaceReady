//
//  ShimmerComponents.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 03.07.24.
//

import Foundation
import SwiftUI

struct ShimmerRowView: View {
    var body: some View {
        VStack(spacing: 8) {
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
            VStack {
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.3)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .modifier(Shimmer())
            }
            
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
