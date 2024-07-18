//
//  RaceReadyApp.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

@main
struct RaceReadyApp: App {
    
    @StateObject private var seasonModel = SeasonModel(webservice: WebService())
    @StateObject private var raceResultModel = RaceResultModel(webService: WebService())
    @StateObject private var driverStandingsModel = DriverStandingsModel(webservice: WebService())
    @StateObject private var constructorStandingsModel = ConstructorsStandingsModel(webservice: WebService(), constructorExtendedModel: ConstructorExtendedModel())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(seasonModel)
                .environmentObject(raceResultModel)
                .environmentObject(driverStandingsModel)
                .environmentObject(constructorStandingsModel)
                .preferredColorScheme(.light)
        }
    }
}
