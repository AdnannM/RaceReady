//
//  DriverStandingsModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 16.07.24.
//

import Foundation

@MainActor
class DriverStandingsModel: ObservableObject {
    let webservice: WebService
    
    @Published private(set) var driverStandings: [DriverStanding] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(webservice: WebService) {
        self.webservice = webservice
        Task {
            await self.populateDriverStandings()
        }
    }
    
    func populateDriverStandings() async {
        isLoading = true
        errorMessage = nil
        
        do {
            self.driverStandings = try await webservice.fetchDriversStandings()
        } catch {
            handleFetchError(error)
        }
        
        isLoading = false
    }
    
    private func handleFetchError(_ error: Error) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                errorMessage = "The request timed out. Please try again later."
            case .notConnectedToInternet:
                errorMessage = "No internet connection. Please check your network settings."
            case .cannotFindHost:
                errorMessage = "Cannot find host. Please check the URL."
            default:
                errorMessage = "URLError: \(urlError.localizedDescription) (Code: \(urlError.code.rawValue))"
            }
        } else if let networkingError = error as? NetworkingError {
            switch networkingError {
            case .requestFailed(let statusCode):
                errorMessage = "The request failed with status code: \(statusCode)"
            default:
                errorMessage = "Unexpected error: \(error.localizedDescription)"
            }
        } else {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }
        print(errorMessage ?? "")
    }
}
