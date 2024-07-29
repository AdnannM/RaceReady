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
        VStack {
            if driverStandingsModel.isLoading {
                DotLoader(loadingText: "Loading drivers...")
            } else if let errorMessage = driverStandingsModel.errorMessage {
                errorView(message: errorMessage)
            } else if driverStandingsModel.driverStandings.isEmpty {
                EmptyView()
            } else {
                driverList
            }
        }
        .navigationTitle("F1 Drivers 2024")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: loadDataIfNeeded)
    }
    
    private func errorView(message: String) -> some View {
        Group {
            if driverStandingsModel.isCacheAvailable {
                driverList
            } else {
                Text("No cached data available")
                    .foregroundColor(.orange)
            }
        }
    }
        
    private var driverList: some View {
        List(driverStandingsModel.driverStandings, id: \.driver.driverId) { driverStanding in
            DriverStandingView(driverStanding: driverStanding)
        }
    }
    
    private func loadDataIfNeeded() {
        if driverStandingsModel.driverStandings.isEmpty {
            Task {
                await driverStandingsModel.populateDriverStandings()
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
