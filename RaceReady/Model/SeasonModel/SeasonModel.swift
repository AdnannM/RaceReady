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
    @Published var errorMessage: String?
    @Published var dataSource: DataSource = .api
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
        errorMessage = nil

        if F1CacheManager.shared.isCacheStale(for: .season) {
            await fetchFromApi()
        } else {
            loadFromCache()
        }

        isLoading = false
    }

    private func fetchFromApi() async {
        do {
            races = try await webservice.fetchSeason()
            updateRacesWithCircuitInfo()
            F1CacheManager.shared.saveSeasonRace(races)
            hasLoaded = true
            dataSource = .api
            print("Season data populated from API - season")
        } catch {
            handleFetchError(error)
        }
    }

    private func loadFromCache() {
        if let cachedRaces = F1CacheManager.shared.getSeasonRace() {
            races = cachedRaces
            updateRacesWithCircuitInfo()
            hasLoaded = true
            dataSource = .cache
            print("Season data loaded from cache - season")
        } else {
            print("No cache data available")
            Task {
                await fetchFromApi()
            }
        }
    }

    private func updateRacesWithCircuitInfo() {
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
    }

    private func handleFetchError(_ error: Error) {
        // ... (keep your existing error handling code here)
    }

    func refreshData() async {
        await fetchFromApi()
    }
}
