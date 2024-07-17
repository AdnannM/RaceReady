//
//  TeamsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

/// TODO:
/// - Fetch data from Api and display postion points and team name
/// - Combine stored data with api and display  drivers name team logo and f1 team car
/// - Refactor the code and make it more readable

struct TeamsView: View {
    var body: some View {
        List {
            VStack {
                HStack {
                    Text("1")
                        .font(.custom("MarkerFelt", size: 50))
                        .frame(width: 60)
                        .bold()
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 0) {
                        Text("244")
                            .font(.custom("MarkerFelt-Wide", size: 25))
                            .bold()
                            .background(
                                GeometryReader { geometry in
                                    Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                                }
                            )
                        Text("PTS")
                            .padding(3)
                            .font(.custom("MarkerFelt-Wide", size: 13))
                            .foregroundStyle(.secondary)
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorBlue").opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .frame(width: 50)
                    .onPreferenceChange(WidthPreferenceKey.self) { width in
                        print("Width of '239' text: \(width)")
                    }
                }
                .padding(.leading, -25)
                .padding(.top)
                .padding(.bottom)
                
                Divider()
                
                HStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 5)
                    
                    Text("Red Bull Racing")
                        .bold()
                        .font(.title)
                    
                    Spacer()
                    
                    Image("redBullLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    
                }
                
                .padding(.top)
                .padding(.bottom)
                
                Divider()
                
                Image("redBull")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    Text("Max Verstaphen")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("Sergio Perez")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
                
            }
            
        }
        .navigationTitle("F1 Teams 2024")
        .navigationBarTitleDisplayMode(.large)
    }
}


#Preview {
    NavigationStack {
        TeamsView()
    }
}
