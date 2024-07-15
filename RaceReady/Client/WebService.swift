//
//  WebService.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import Foundation

/// Constants used for API requests.
struct APIConstants {
    /// The base URL for the Ergast F1 API.
    static let baseURL = URL(string: "https://ergast.com/api/f1")!
    
    /// The path component for the current season's data.
    static let currentSeason = "current.json"
    
    /// The path component for the current season's race results.
    static let currentResults = "current/results.json"
    
    /// The maximum number of results to fetch per request.
    static let limit = 30
}

///// Networking errors that may occur during API requests.
enum NetworkingError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError(Error)
    case unknownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .requestFailed(let statusCode):
            return "The request failed with status code: \(statusCode)"
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}

/// A service responsible for fetching data from the Ergast API.
struct WebService {
    
    /// The URL session used for network requests.
    private let session: URLSession
    
    /// Initializes a new WebService instance.
    /// - Parameter session: The URL session to use for network requests. Defaults to `URLSession.shared`.
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Fetches all races for the current season.
    /// - Returns: An array of `Race` objects representing the races in the current season.
    /// - Throws: A `NetworkingError` if there is an issue with the network request or decoding the response.
    func fetchSeason() async throws -> [Race] {
        let url = APIConstants.baseURL.appendingPathComponent(APIConstants.currentSeason)
        return try await fetchData(from: url, decodingTo: SeasonData.self).mrData.raceTable.races
    }
    
    /// Fetches the race results for the current season.
    /// - Returns: An array of `RaceResult` objects representing the results of all finished races in the current season.
    /// - Throws: A `NetworkingError` if there is an issue with the network request or decoding the response.
    func fetchRaceResults() async throws -> [RaceResult] {
        var allRaceResults: [RaceResult] = []
        var currentOffset = 0
        
        while true {
            let url = APIConstants.baseURL
                .appendingPathComponent(APIConstants.currentResults)
                .appending(queryItems: [
                    URLQueryItem(name: "limit", value: "\(APIConstants.limit)"),
                    URLQueryItem(name: "offset", value: "\(currentOffset)")
                ])
            
            let raceResultData = try await fetchData(from: url, decodingTo: RaceResultData.self)
            let fetchedRaces = raceResultData.raceMRData.raceResultTable.races
            
            guard !fetchedRaces.isEmpty else { break }
            
            allRaceResults.append(contentsOf: fetchedRaces)
            currentOffset += APIConstants.limit
        }
        
        return allRaceResults
    }
    
    /// Fetches and decodes data from a given URL.
    /// - Parameters:
    ///   - url: The URL to fetch data from.
    ///   - type: The type to decode the data into.
    /// - Returns: The decoded data of type `T`.
    /// - Throws: A `NetworkingError` if there is an issue with the network request or decoding the response.
    private func fetchData<T: Decodable>(from url: URL, decodingTo type: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkingError.unknownError(NSError(domain: "HTTPResponse", code: 0))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkingError.requestFailed(statusCode: httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw NetworkingError.decodingError(decodingError)
        } catch {
            throw NetworkingError.unknownError(error)
        }
    }
}
