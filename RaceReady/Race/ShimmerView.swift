//
//  ShimmerView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 02.07.24.
//

import SwiftUI

struct ShimmerView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Data is Loading")
                    .modifier(Shimmer())
                    .opacity(0.6)
                    .padding(.trailing, 10)
                ProgressView()
            }
            List {
                ForEach(0..<3, id: \.self) { _ in
                    ShimmerRaceItem()
                }
            }
        }
    }
}

#Preview {
    ShimmerView()
}



