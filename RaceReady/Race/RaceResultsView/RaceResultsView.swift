//
//  RaceResultsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 10.07.24.
//

import SwiftUI

/// TODO: - Refector this code and make it more readable

struct RaceResultsView: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: -25) {
            // Second place
            VStack() {
                VStack {
                    Spacer()
                    Text("VER")
                        .font(.system(size: 29))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .background(.link)
                        .clipShape(.rect(bottomLeadingRadius: 10))
                        .clipShape(.rect(bottomTrailingRadius: 10))
                }
                .frame(width: 110, height: 120)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.gray)
                }
                .padding()
                
                Image("image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 120)
                    .padding(.top, -180)
            }
            
            // First place
            VStack {
                VStack {
                    Spacer()
                    Text("VER")
                        .font(.system(size: 29))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .background(.link)
                        .clipShape(.rect(bottomLeadingRadius: 10))
                        .clipShape(.rect(bottomTrailingRadius: 10))
                }
                .frame(width: 110, height: 140)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.gray)
                }
                .padding()
                
                Image("image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 120)
                    .padding(.top, -180)
            }
            
            // Third place
            VStack {
                VStack {
                    Spacer()
                    Text("VER")
                        .font(.system(size: 29))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .background(.link)
                        .clipShape(.rect(bottomLeadingRadius: 10))
                        .clipShape(.rect(bottomTrailingRadius: 10))
                }
                .frame(width: 110, height: 110)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.gray)
                }
                .padding()
                
                Image("image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 120)
                    .padding(.top, -180)
            }
        }
    }
}

#Preview {
    RaceResultsView()
}

