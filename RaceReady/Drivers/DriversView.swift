//
//  DriversView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

/// TODO:
/// - Update: all color for all teams
/// - Refactor: Clean some code and make it more readable
/// - Color: Move that into new extension file


let driverTeamColors: [String: Color] = [
    "verstappen": .blue,
    "perez": .blue,
    "hamilton": .mercedes,
    "russell": .mercedes,
    "leclerc": .red,
    "sainz": .red,
    "norris": .orange,
    "piastri": .orange,
    "bottas": .green,
    "guanyu": .green,
    "gasly": .blue,
    "ocon": .blue,
    "magnussen": .gray,
    "hulkenberg": .gray,
    "alonso": .green,
    "stroll": .green,
    "albon": .lightBlue,
    "sargeant": .lightBlue,
    "ricciardo": .blue,
    "tsunoda" : .blue,
    "bearman" : .red
]

extension Color {
    static let lightBlue = Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255)
    static let mercedes = Color(red: 39/255.0, green: 244/255.0, blue: 210/255.0)
}

struct DriversView: View {
    @EnvironmentObject var driverStandingsModel: DriverStandingsModel
    
    var body: some View {
        List {
            ForEach(driverStandingsModel.driverStandings, id: \.driver.driverId) { driverStanding in
                DriverStandingView(driverStanding: driverStanding)
            }
        }
        .navigationTitle("F1 Drivers 2024")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            Task {
                await driverStandingsModel.populateDriverStandings()
            }
        }
    }
}

#Preview {
    NavigationStack {
        DriversView()
            .environmentObject(DriverStandingsModel(webservice: WebService()))
    }
}

struct DriverStandingView: View {
    let driverStanding: DriverStanding
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Rectangle()
                    .fill(driverTeamColors[driverStanding.driver.driverId] ?? .blue)
                    .frame(width: 5)
                
                VStack(alignment: .leading) {
                    Text(driverStanding.driver.givenName)
                        .bold()
                        .font(.title3)
                        .foregroundStyle(.secondary)
                    Text(driverStanding.driver.familyName)
                        .bold()
                        .font(.title2)
                }
                
                Spacer()
                
                Image(driverStanding.driverCountryImage ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 50)
            }
            .padding(.top)
            
            Divider()
            
            HStack(alignment: .center) {
                Text(driverStanding.position)
                    .font(.custom("MarkerFelt", size: 50))
                    .frame(width: 60)
                    .bold()
                
                Image(driverStanding.driverImage ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 200)
                Spacer()
                
                VStack(alignment: .center, spacing: 0) {
                    Text(driverStanding.points)
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
            .padding(.bottom, 10)
        }
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
