//
//  RaceErrorView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 31.07.24.
//

import SwiftUI

struct RaceErrorView: View {
    let message: String
    let retryAction: () async -> Void
    
    var body: some View {
        VStack {
            Text(message)
            Button("Retry") {
                Task { await retryAction() }
            }
        }
    }
}
