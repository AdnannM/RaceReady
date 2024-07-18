//
//  ConstructorStaindingView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 18.07.24.
//

import SwiftUI

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
                
                if let logoImage = constructorStandigs.teamLogoImage {
                    Image(logoImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
            }
            
            .padding(.top)
            .padding(.bottom)
            
            Divider()
            
            if let teamCarImage = constructorStandigs.teamCarImage {
                Image(teamCarImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            HStack {
                Text(constructorStandigs.teamDriverOne ?? "")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(constructorStandigs.teamDriverTwo ?? "")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
