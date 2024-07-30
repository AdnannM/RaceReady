//
//  ConstructorsStandingsModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 18.07.24.
//

import Foundation

@MainActor
class ConstructorsStandingsModel: ObservableObject {
    let webservice: WebService
    let constructorExtendedModel: ConstructorExtendedModel
    
    @Published private(set) var constructorStanding: [ConstructorStandingModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var lastUpdate: Date?
    @Published var dataSource: DataSource = .api
    @Published var isCacheAvailable: Bool = false
    
    init(webservice: WebService, constructorExtendedModel: ConstructorExtendedModel) {
        self.webservice = webservice
        self.constructorExtendedModel = constructorExtendedModel
        checkCacheAvailability()
        Task {
            await populateConstructorsStandings()
        }
    }
    
    func populateConstructorsStandings() async {
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
    
    
    private func fetchFromApi() async throws {
        var fetchTeamsStandings = try await webservice.fetchConstructorsStandings()
        updateTeamsStandings(&fetchTeamsStandings)  // Note the '&' here
        self.constructorStanding = fetchTeamsStandings  // Assuming you want to update the class property
        F1TeamsCache.shared.saveTeamsStandings(self.constructorStanding)
        lastUpdate = Date()
        dataSource = .api
        checkCacheAvailability()
        print("Data Fetched from API - constructors - and cache")
    }

    private func loadFromCache() {
        if var cachedTeamStandings = F1TeamsCache.shared.getTeamsStandings() {
            updateTeamsStandings(&cachedTeamStandings)  // Note the '&' here
            self.constructorStanding = cachedTeamStandings  // Assuming you want to update the class property
            lastUpdate = F1TeamsCache.shared.getLastUpdatedDate()
            dataSource = .cache
            print("Data load from cache")
        } else {
            print("No cache data available")
        }
        
        checkCacheAvailability()
    }
    
    func refreshData() async {
        if F1TeamsCache.shared.isCacheStale() {
            F1TeamsCache.shared.clearCache()
        }
        await populateConstructorsStandings()
    }
    
    private func updateTeamsStandings(_ standings: inout [ConstructorStandingModel]) {
        for index in standings.indices {
            let name = standings[index].constructor.name
            let normalizedName = TeamNormalizer.normalizeTeamName(name)
            if let extendedData = constructorExtendedModel.constructorExtendedData[normalizedName] {
                standings[index].updateWithExtendedData(extendedData)
            } else {
                print("No extended data found for team: \(name) (normalized: \(normalizedName))")
            }
        }
    }
    
    private func handleFetchError(_ error: Error) {
        errorMessage = createErrorMessage(for: error)
        print(errorMessage ?? "")
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
    
    private func checkCacheAvailability() {
        isCacheAvailable = F1TeamsCache.shared.getTeamsStandings() != nil
    }
}

extension ConstructorStandingModel {
    mutating func updateWithExtendedData(_ extendedData: ConstructorExtendedData) {
        self.teamLogoImage = extendedData.teamLogoImage
        self.teamCarImage = extendedData.teamCarImage
        self.teamDriverOne = extendedData.teamDriverOne
        self.teamDriverTwo = extendedData.teamDriverTwo
    }
}




