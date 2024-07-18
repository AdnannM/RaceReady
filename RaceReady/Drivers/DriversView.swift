//
//  DriversView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct DriversView: View {
    @EnvironmentObject var driverStandingsModel: DriverStandingsModel
    
    var body: some View {
        Group {
            if driverStandingsModel.isLoading {
                ProgressView("Loading drivers...")
            } else if let errorMessage = driverStandingsModel.errorMessage {
                ErrorView(errorMessage: errorMessage) {
                    Task {
                        await driverStandingsModel.populateDriverStandings()
                    }
                }
            } else if driverStandingsModel.driverStandings.isEmpty {
                Text("No driver standings available")
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(driverStandingsModel.driverStandings, id: \.driver.driverId) { driverStanding in
                        DriverStandingView(driverStanding: driverStanding)
                    }
                }
            }
        }
        .navigationTitle("F1 Drivers 2024")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            if driverStandingsModel.driverStandings.isEmpty {
                Task {
                    await driverStandingsModel.populateDriverStandings()
                }
            }
        }
    }
}


#Preview("Drivers View") {
    NavigationStack {
        DriversView()
            .environmentObject(DriverStandingsModel(webservice: WebService()))
    }
}

