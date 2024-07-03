//
//  ShimmerView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 02.07.24.
//

import SwiftUI

struct ShimmerView: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("Loading")
                .opacity(0.5)
                .padding(.trailing, 5)
            ProgressView()
        }
        List {
            ForEach(0..<3, id: \.self) { _ in
                ShimmerRowView()
            }
        }
    }
}



#Preview {
    ShimmerView()
}





