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

