//
//  RaceResultModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 11.07.24.
//

import Foundation

@MainActor
class RaceResultModel: ObservableObject {

    let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    @Published private(set) var raceResults: [RaceResult] = []

    
    func populateRaceResults() async throws {
        do {
            self.raceResults = try await webService.fetchRaceResults() 
        } catch {
            throw error
        }
    }
}
