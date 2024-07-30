//
//  DriverStandingsModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 16.07.24.
//

import Foundation

enum DataSource {
    case api, cache
}

// MARK: - DriverStandingsModel

class DriverStandingsModel: BaseStandingsModel<DriverStanding> {
    let driversInfoImages: DriversInfoImages
    
    init(webservice: WebService, driversInfoImages: DriversInfoImages = DriversInfoImages()) {
        self.driversInfoImages = driversInfoImages
        super.init(webservice: webservice, standingsType: .drivers)
        Task {
            await populateStandings()
        }
    }
    
    override func fetchFromApi() async throws {
        let fetchedDriverStandings = try await webservice.fetchDriversStandings()
        updateDriverStandings(fetchedDriverStandings)
        F1CacheManager.shared.saveDriverStandings(self.standings)
        lastUpdate = Date()
        dataSource = .api
        checkCacheAvailability()
        print("Data fetched from API and cached")
    }
    
    override func loadFromCache() {
        if let cachedStandings = F1CacheManager.shared.getDriverStandings() {
            updateDriverStandings(cachedStandings)
            lastUpdate = F1CacheManager.shared.getLastUpdatedDate(for: .drivers)
            dataSource = .cache
            print("Data loaded from cache")
        } else {
            print("No cached data available")
        }
        checkCacheAvailability()
    }
    
    override func checkCacheAvailability() {
        isCacheAvailable = F1CacheManager.shared.getDriverStandings() != nil
    }
    
    private func updateDriverStandings(_ standings: [DriverStanding]) {
        self.standings = standings.map { driverStanding in
            var mutableDriverStanding = driverStanding
            if let images = driversInfoImages.findImages(for: driverStanding.driver.driverId) {
                mutableDriverStanding.driverImage = images.driverImage
                mutableDriverStanding.driverCountryImage = images.driverCountryImage
            }
            return mutableDriverStanding
        }
    }
}
