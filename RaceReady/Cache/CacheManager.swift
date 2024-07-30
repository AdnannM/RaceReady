//
//  CacheManager.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 30.07.24.
//

import Foundation

// Protocol for cache operations
protocol CacheOperations {
    associatedtype T: Codable
    func save(_ items: [T])
    func retrieve() -> [T]?
    func getLastUpdatedDate() -> Date?
    func isCacheStale() -> Bool
    func clearCache()
}

// Generic cache manager
class CacheManager<T: Codable>: CacheOperations {
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let cacheKey: String
    private let lastUpdateKey: String
    
    init(cacheKey: String, lastUpdateKey: String) {
        self.userDefaults = UserDefaults.standard
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
        self.cacheKey = cacheKey
        self.lastUpdateKey = lastUpdateKey
    }
    
    func save(_ items: [T]) {
        do {
            let encoded = try encoder.encode(items)
            userDefaults.set(encoded, forKey: cacheKey)
            userDefaults.set(Date(), forKey: lastUpdateKey)
        } catch {
            print("Error encoding items: \(error.localizedDescription)")
        }
    }
    
    func retrieve() -> [T]? {
        guard let savedItems = userDefaults.data(forKey: cacheKey) else {
            return nil
        }
        
        do {
            let decodedItems = try decoder.decode([T].self, from: savedItems)
            return decodedItems
        } catch {
            print("Error decoding items: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getLastUpdatedDate() -> Date? {
        return userDefaults.object(forKey: lastUpdateKey) as? Date
    }
    
    func isCacheStale() -> Bool {
        guard let lastUpdate = getLastUpdatedDate() else {
            return true
        }
        let staleThreshold: TimeInterval = 3600 // 1 hour
        return Date().timeIntervalSince(lastUpdate) > staleThreshold
    }
    
    func clearCache() {
        userDefaults.removeObject(forKey: cacheKey)
        userDefaults.removeObject(forKey: lastUpdateKey)
    }
}
