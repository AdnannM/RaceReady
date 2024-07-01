//
//  SeasonModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import Foundation

@MainActor
class SeasonModel: ObservableObject {
    
    let webservice: WebService
    
    init(webservice: WebService) {
        self.webservice = webservice
    }
    
    @Published private(set) var races: [Race] = []
    
    func populateSeason() async throws {
        do {
            self.races = try await webservice.fetchSeason()
            print("Season data populated")
        } catch {
            print("Error populating season: \(error.localizedDescription)")
            throw error
        }
    }
}
