//
//  SeasonModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import SwiftUI

@MainActor
class SeasonModel: ObservableObject {
    let webservice: WebService
    
    @Published private(set) var races: [Race] = []
    @Published var isLoading: Bool = false
    @Published var hasLoaded: Bool = false
    var circuitInfo = CircuitInfo()
    
    init(webservice: WebService) {
        self.webservice = webservice
        Task {
            await populateSeason()
        }
    }
    
    func populateSeason() async {
        guard !hasLoaded else { return }
        
        isLoading = true
        do {
            races = try await webservice.fetchSeason()
            hasLoaded = true
            
            for i in 0..<races.count {
                if let circuitData = circuitInfo.circuitInfo.first(where: { $0.id == i + 1 }) {
                    races[i].circuitImage = circuitData.circuitImage
                    races[i].countryFlag = circuitData.countryFlag
                    races[i].firstGp = circuitData.firstGp
                    races[i].numberOfLaps = circuitData.numberOfLaps
                    races[i].circuitLenght = circuitData.circuitLenght
                    races[i].raceDistance = circuitData.raceDistance
                }
            }
            
            print("Season data populated")
        } catch {
            print("Error populating season: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
