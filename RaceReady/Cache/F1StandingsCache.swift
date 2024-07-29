//
//  F1StandingsCache.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 29.07.24.
//

import Foundation

class F1StandingsCache {
    static let shared = F1StandingsCache()
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private enum Keys {
        static let driverStandings = "cacheDriverStandings"
        static let lastUpdate = "driverStandingsLastUpdate"
    }
    
    func saveDriverStandings(_ standings: [DriverStanding]) {
        do {
            let encoded = try encoder.encode(standings)
            userDefaults.set(encoded, forKey: Keys.driverStandings)
            userDefaults.set(Date(), forKey: Keys.lastUpdate)
        } catch {
            print("Error encoding driver standings: \(error.localizedDescription)")
        }
    }
    
    func getDriverStandings() -> [DriverStanding]? {
        guard let savedStandings = userDefaults.data(forKey: Keys.driverStandings) else {
            return nil
        }
        
        do {
            let decodedStandings = try decoder.decode([DriverStanding].self, from: savedStandings)
            return decodedStandings
        } catch {
            print("Error decoding driver standings: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getLastUpdatedDate() -> Date? {
        return userDefaults.object(forKey: Keys.lastUpdate) as? Date
    }
    
    func isCacheStale() -> Bool {
        guard let lastUpdate = getLastUpdatedDate() else {
            return true
        }
        let staleThreshold: TimeInterval = 3600 // 1 hour
        return Date().timeIntervalSince(lastUpdate) > staleThreshold
    }
    
    func clearCache() {
        userDefaults.removeObject(forKey: Keys.driverStandings)
        userDefaults.removeObject(forKey: Keys.lastUpdate)
    }
}
