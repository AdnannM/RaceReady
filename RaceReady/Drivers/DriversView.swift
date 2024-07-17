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
    "verstappen": .redBull,
    "perez": .redBull,
    "hamilton": .mercedes,
    "russell": .mercedes,
    "leclerc": .ferrari,
    "sainz": .ferrari,
    "norris": .mclaren,
    "piastri": .mclaren,
    "bottas": .sauber,
    "guanyu": .sauber,
    "gasly": .alpine,
    "ocon": .alpine,
    "magnussen": .haas,
    "hulkenberg": .haas,
    "alonso": .astonMartin,
    "stroll": .astonMartin,
    "albon": .williams,
    "sargeant": .williams,
    "ricciardo": .rb,
    "tsunoda" : .rb,
    "bearman" : .ferrari
]

extension Color {
    static let williams = Color(red: 0.39, green: 0.77, blue: 1.00)
    static let mercedes = Color(red: 39/255.0, green: 244/255.0, blue: 210/255.0)
    static let astonMartin = Color(red: 0.13, green: 0.60, blue: 0.44)
    static let haas = Color(red: 0.71, green: 0.73, blue: 0.74)
    static let rb = Color(red: 0.40, green: 0.57, blue: 1.00)
    static let alpine = Color(red: 0.00, green: 0.58, blue: 0.80)
    static let sauber = Color(red: 0.32, green: 0.89, blue: 0.32)
    static let mclaren = Color(red: 1.00, green: 0.50, blue: 0.00)
    static let ferrari = Color(red: 0.91, green: 0.00, blue: 0.13)
    static let redBull = Color(red: 0.21, green: 0.44, blue: 0.78)
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
                    .shadow(color: Color.gray.opacity(0.3), radius: 1, x: 0, y: 0)
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
