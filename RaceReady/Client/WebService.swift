//
//  WebService.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import Foundation


enum NetworkingError: Error {
    case badURL
    case invalidResponse
    case decodingError
}

/// TODO: - Clear this and make Api-Endpoint and Constants for URLs 
struct WebService {
    
    func fetchSeason() async throws -> [Race] {
        
        guard let baseURL = URL(string: "https://ergast.com/api/f1/current.json") else {
            throw NetworkingError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: baseURL)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidResponse
        }
        
        do {
            let seasonData = try JSONDecoder().decode(SeasonData.self, from: data)
            print("Fetched and decoded data successfully")
            return seasonData.mrData.raceTable.races
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw NetworkingError.decodingError
        }
    }
}
