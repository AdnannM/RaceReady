//
//  F1CacheManager.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 30.07.24.
//

import Foundation

// MARK: - CacheManager
class F1CacheManager {
    static let shared = F1CacheManager()
    private let teamsCache: CacheManager<ConstructorStandingModel>
    private let driversCache: CacheManager<DriverStanding>
    private let seasonCache: CacheManager<Race>
    
    private init() {
        teamsCache = CacheManager(cacheKey: Keys.teamsStandings, lastUpdateKey: Keys.lastTeamsUpdate)
        driversCache = CacheManager(cacheKey: Keys.driverStandings, lastUpdateKey: Keys.lastUpdate)
        seasonCache = CacheManager(cacheKey: Keys.season, lastUpdateKey: Keys.lastSeasonUpdate)
    }
    
    func saveTeamsStandings(_ standings: [ConstructorStandingModel]) {
        teamsCache.save(standings)
    }
    
    func getTeamsStandings() -> [ConstructorStandingModel]? {
        return teamsCache.retrieve()
    }
    
    func saveDriverStandings(_ standings: [DriverStanding]) {
        driversCache.save(standings)
    }
    
    func getDriverStandings() -> [DriverStanding]? {
        return driversCache.retrieve()
    }
    
    func saveSeasonRace(_ standings: [Race]) {
        seasonCache.save(standings)
    }
    
    func getSeasonRace() -> [Race]? {
        seasonCache.retrieve()
    }
    
    func getLastUpdatedDate(for type: StandingsType) -> Date? {
        switch type {
        case .teams:
            return teamsCache.getLastUpdatedDate()
        case .drivers:
            return driversCache.getLastUpdatedDate()
        case .season:
            return seasonCache.getLastUpdatedDate()
        }
    }
    
    func isCacheStale(for type: StandingsType) -> Bool {
        switch type {
        case .teams:
            return teamsCache.isCacheStale()
        case .drivers:
            return driversCache.isCacheStale()
        case .season:
            return seasonCache.isCacheStale()
        }
    }
    
    func clearCache(for type: StandingsType) {
        switch type {
        case .teams:
            teamsCache.clearCache()
        case .drivers:
            driversCache.clearCache()
        case .season:
            seasonCache.clearCache()
        }
    }
}
