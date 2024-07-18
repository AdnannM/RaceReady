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
    
    @EnvironmentObject var constructorsStandingsModel: ConstructorsStandingsModel
    
    var body: some View {
        
        List {
            ForEach(constructorsStandingsModel.constructorStanding, id: \.constructor.name) { constructorStanding in
                ConstructorStaindingView(constructorStandigs: constructorStanding)
            }
        }
        
        .navigationTitle("F1 Teams 2024")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: {
            Task {
                constructorsStandingsModel.populateConstructorsStandings()
            }
        })
    }
}


#Preview {
    NavigationStack {
        TeamsView()
            .environmentObject(ConstructorsStandingsModel(webservice: WebService()))
    }
}


struct ConstructorStaindingView: View {
    
    let constructorStandigs: ConstructorStandingModel
    
    var body: some View {
        VStack {
            HStack {
                Text(constructorStandigs.position)
                    .font(.custom("MarkerFelt", size: 50))
                    .frame(width: 60)
                    .bold()
                
                Spacer()
                
                VStack(alignment: .center, spacing: 0) {
                    Text(constructorStandigs.points)
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
                    .fill(driverTeamColors[constructorStandigs.constructor.name.lowercased()] ?? .blue)
                    .frame(width: 5)
                
                Text(constructorStandigs.constructor.name)
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
}
