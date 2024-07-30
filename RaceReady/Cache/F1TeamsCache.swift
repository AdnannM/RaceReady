//
//  F1TeamsCache.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 30.07.24.
//

import Foundation

class F1TeamsCache {
    static let shared = F1TeamsCache()
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func saveTeamsStandings(_ standings: [ConstructorStandingModel]) {
        do {
            let encoded = try encoder.encode(standings)
            userDefaults.set(encoded, forKey: Keys.teamsStandings)
            userDefaults.set(encoded, forKey: Keys.lastTeamsUpdate)
        } catch {
            print("Error encoding teams standings: \(error.localizedDescription)")
        }
    }
    
    func getTeamsStandings() -> [ConstructorStandingModel]? {
        guard let savedStandings = userDefaults.data(forKey: Keys.teamsStandings) else {
            return nil
        }
        
        do {
            let decodedStandings = try decoder.decode([ConstructorStandingModel].self, from: savedStandings)
            return decodedStandings
        } catch {
            print("Error encoding teams standings: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getLastUpdatedDate() -> Date? {
        return userDefaults.object(forKey: Keys.lastTeamsUpdate) as? Date
    }
    
    
    func isCacheStale() -> Bool {
        guard let lastUpdate = getLastUpdatedDate() else {
            return true
        }
        
        let staleThreshold: TimeInterval = 3600 // 1 hour
        return Date().timeIntervalSince(lastUpdate) > staleThreshold
    }
 
    func clearCache() {
        userDefaults.removeObject(forKey: Keys.teamsStandings)
        userDefaults.removeObject(forKey: Keys.lastTeamsUpdate)
    }
}
