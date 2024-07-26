//
//  CircuitImageView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 26.07.24.
//

import SwiftUI

struct CircuitImageView: View {
    let circuitImage: String?
    
    var body: some View {
        if let circuitImage = circuitImage {
            Image(circuitImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
        }
    }
}

#Preview {
    CircuitImageView(circuitImage: "austria")
}
