//
//  ShimmerComponents.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 03.07.24.
//

import Foundation
import SwiftUI

struct ShimmerRectangle: View {
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color.gray)
            .opacity(0.3)
            .frame(width: width, height: height)
            .cornerRadius(5)
            .modifier(Shimmer())
    }
}

struct ShimmerTextRow: View {
    var body: some View {
        HStack {
            ShimmerRectangle(width: 150, height: 20)
            Spacer()
            ShimmerRectangle(width: 70, height: 20)
        }
    }
}

struct ShimmerRaceDetail: View {
    var body: some View {
        VStack(spacing: 10) {
            ShimmerTextRow()
            HStack {
                ShimmerRectangle(width: 150, height: 20)
                Spacer()
            }
        }
    }
}

struct ShimmerRaceItem: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                ShimmerRectangle(width: 200, height: 40)
                Spacer()
                ShimmerRectangle(width: 70, height: 40)
            }
            .padding(.bottom, 5)
            
            Divider()
            
            ShimmerRectangle(width: .infinity, height: 200)
            
            Divider()
            
            ShimmerRaceDetail()
        }
    }
}
