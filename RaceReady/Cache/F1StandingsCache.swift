//
//  F1StandingsCache.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 29.07.24.
//

import Foundation

// F1StandingsCache using the new CacheManager
class F1StandingsCache {
    static let shared = F1StandingsCache()
    private let cacheManager: CacheManager<DriverStanding>
    
    private init() {
        cacheManager = CacheManager(cacheKey: Keys.driverStandings, lastUpdateKey: Keys.lastUpdate)
    }
    
    func saveDriverStandings(_ standings: [DriverStanding]) {
        cacheManager.save(standings)
    }
    
    func getDriverStandings() -> [DriverStanding]? {
        return cacheManager.retrieve()
    }
    
    func getLastUpdatedDate() -> Date? {
        return cacheManager.getLastUpdatedDate()
    }
    
    func isCacheStale() -> Bool {
        return cacheManager.isCacheStale()
    }
    
    func clearCache() {
        cacheManager.clearCache()
    }
}


