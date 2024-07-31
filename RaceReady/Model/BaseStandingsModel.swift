//
//  BaseStandingsModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 30.07.24.
//

import Foundation

// MARK: - Base Model

enum StandingsType {
    case teams, drivers, season
}

@MainActor
class BaseStandingsModel<T: Codable>: ObservableObject {
    let webservice: WebService
    let standingsType: StandingsType
    
    @Published var standings: [T] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var lastUpdate: Date?
    @Published var dataSource: DataSource = .api
    @Published var isCacheAvailable: Bool = false
    
    init(webservice: WebService, standingsType: StandingsType) {
        self.webservice = webservice
        self.standingsType = standingsType
        checkCacheAvailability()
    }
    
    func populateStandings() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await fetchFromApi()
        } catch {
            print("API fetch failed: \(error.localizedDescription)")
            handleFetchError(error)
            loadFromCache()
        }
        
        isLoading = false
    }
    
    func fetchFromApi() async throws {
        fatalError("This method must be overridden")
    }
    
    func loadFromCache() {
        fatalError("This method must be overridden")
    }
    
    func refreshData() async {
        if F1CacheManager.shared.isCacheStale(for: standingsType) {
            F1CacheManager.shared.clearCache(for: standingsType)
        }
        await populateStandings()
    }
    
    func handleFetchError(_ error: Error) {
        errorMessage = createErrorMessage(for: error)
        print(errorMessage ?? "")
    }
    
    func checkCacheAvailability() {
        fatalError("This method must be overridden")
    }
    
    private func createErrorMessage(for error: Error) -> String {
        switch error {
        case let urlError as URLError:
            return urlErrorMessage(for: urlError)
        case let networkingError as NetworkingError:
            return networkingErrorMessage(for: networkingError)
        default:
            return "Unexpected error: \(error.localizedDescription)"
        }
    }
    
    private func urlErrorMessage(for error: URLError) -> String {
        switch error.code {
        case .timedOut:
            return "The request timed out. Please try again later."
        case .notConnectedToInternet:
            return "No internet connection. Please check your network settings."
        case .cannotFindHost:
            return "Cannot find host. Please check the URL."
        default:
            return "URLError: \(error.localizedDescription) (Code: \(error.code.rawValue))"
        }
    }
    
    private func networkingErrorMessage(for error: NetworkingError) -> String {
        switch error {
        case .requestFailed(let statusCode):
            return "The request failed with status code: \(statusCode)"
        default:
            return "Unexpected error: \(error.localizedDescription)"
        }
    }
}
