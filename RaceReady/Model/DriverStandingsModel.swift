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

@MainActor
class DriverStandingsModel: ObservableObject {
    let webservice: WebService
    let driversInfoImages: DriversInfoImages
    
    @Published private(set) var driverStandings: [DriverStanding] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var lastUpdate: Date?
    @Published var dataSource: DataSource = .api
    @Published var isCacheAvailable: Bool = false
    
    init(webservice: WebService, driversInfoImages: DriversInfoImages = DriversInfoImages()) {
        self.webservice = webservice
        self.driversInfoImages = driversInfoImages
        checkCacheAvailability()
        Task { await populateDriverStandings() }
    }
    
    func populateDriverStandings() async {
        isLoading = true
        errorMessage = nil
        do {
            try await fetchFromAPI()
        } catch {
            print("API fetch failed: \(error.localizedDescription)")
            handleFetchError(error)
            loadFromCache()
        }
        isLoading = false
    }
    
  
    private func fetchFromAPI() async throws {
        let fetchedDriverStandings = try await webservice.fetchDriversStandings()
        updateDriverStandings(fetchedDriverStandings)
        F1StandingsCache.shared.saveDriverStandings(self.driverStandings)
        lastUpdate = Date()
        dataSource = .api
        checkCacheAvailability()
        print("Data fetched from API and cached")
    }
    
    private func loadFromCache() {
        if let cachedStandings = F1StandingsCache.shared.getDriverStandings() {
            updateDriverStandings(cachedStandings)
            lastUpdate = F1StandingsCache.shared.getLastUpdatedDate()
            dataSource = .cache
            print("Data loaded from cache")
        } else {
            print("No cached data available")
        }
        checkCacheAvailability()
    }
    
    private func updateDriverStandings(_ standings: [DriverStanding]) {
        self.driverStandings = standings.map { driverStanding in
            var mutableDriverStanding = driverStanding
            if let images = driversInfoImages.findImages(for: driverStanding.driver.driverId) {
                mutableDriverStanding.driverImage = images.driverImage
                mutableDriverStanding.driverCountryImage = images.driverCountryImage
            }
            return mutableDriverStanding
        }
    }
    
    func refreshData() async {
        if F1StandingsCache.shared.isCacheStale() {
            F1StandingsCache.shared.clearCache()
        }
        await populateDriverStandings()
    }
    
    private func handleFetchError(_ error: Error) {
        errorMessage = createErrorMessage(for: error)
        print(errorMessage ?? "")
    }
    
    private func checkCacheAvailability() {
        isCacheAvailable = F1StandingsCache.shared.getDriverStandings() != nil
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
