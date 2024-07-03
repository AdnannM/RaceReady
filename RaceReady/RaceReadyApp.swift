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
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(seasonModel)
                .preferredColorScheme(.light)
        }
    }
}
