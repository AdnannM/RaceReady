//
//  DriversView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

struct DriversView: View {
    @EnvironmentObject var driverStandingsModel: DriverStandingsModel
    
    var body: some View {
        List {
            ForEach(driverStandingsModel.driverStandings, id: \.driver.driverId) { driverStanding in
                DriverStandingView(driverStanding: driverStanding)
            }
        }
        .navigationTitle("Drivers")
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
                    .fill(.blue)
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
