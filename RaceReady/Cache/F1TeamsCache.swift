//
//  F1TeamsCache.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 30.07.24.
//

import Foundation

// F1TeamsCache using the new CacheManager
class F1TeamsCache {
    static let shared = F1TeamsCache()
    private let cacheManager: CacheManager<ConstructorStandingModel>
    
    private init() {
        cacheManager = CacheManager(cacheKey: Keys.teamsStandings, lastUpdateKey: Keys.lastTeamsUpdate)
    }
    
    func saveTeamsStandings(_ standings: [ConstructorStandingModel]) {
        cacheManager.save(standings)
    }
    
    func getTeamsStandings() -> [ConstructorStandingModel]? {
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
