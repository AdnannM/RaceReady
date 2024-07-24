//
//  ErrorView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 18.07.24.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text("Oops! Something went wrong")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(errorMessage)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: retryAction) {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Try Again")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .padding(.all)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

#Preview("Error View") {
    ErrorView(errorMessage: "The server is currently unavailable. Please try again later.") {}
}
