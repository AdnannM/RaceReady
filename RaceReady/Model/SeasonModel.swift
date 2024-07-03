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
    @Published var isLoading: Bool = false
    @Published var hasLoaded: Bool = false
    
    func populateSeason() async throws {
        
        guard !hasLoaded else { return }
        
        self.isLoading = true
        do {
            self.races = try await webservice.fetchSeason()
            self.hasLoaded = true
            print("Season data populated")
        } catch {
            print("Error populating season: \(error.localizedDescription)")
            throw error
        }
        self.isLoading = false
    }
}
