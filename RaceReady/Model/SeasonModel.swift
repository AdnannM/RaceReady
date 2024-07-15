//
//  SeasonModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import SwiftUI

@MainActor
class SeasonModel: ObservableObject {
    let webservice: WebService
    @Published private(set) var races: [Race] = []
    @Published var isLoading: Bool = false
    @Published var hasLoaded: Bool = false
    @Published var errorMessage: String?
    var circuitInfo = CircuitInfo()

    init(webservice: WebService) {
        self.webservice = webservice
        Task {
            await populateSeason()
        }
    }

    func populateSeason() async {
        guard !hasLoaded else { return }

        isLoading = true
        errorMessage = nil

        do {
            races = try await webservice.fetchSeason()
            hasLoaded = true
            for i in 0..<races.count {
                if let circuitData = circuitInfo.circuitInfo.first(where: { $0.id == i + 1 }) {
                    races[i].circuitImage = circuitData.circuitImage
                    races[i].countryFlag = circuitData.countryFlag
                    races[i].firstGp = circuitData.firstGp
                    races[i].numberOfLaps = circuitData.numberOfLaps
                    races[i].circuitLenght = circuitData.circuitLenght
                    races[i].raceDistance = circuitData.raceDistance
                }
            }
            print("Season data populated")
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
                if statusCode == 503 {
                    errorMessage = "Service is currently unavailable. Please try again later."
                } else {
                    errorMessage = "The request failed with status code: \(statusCode)"
                }
            default:
                errorMessage = "Unexpected error: \(error.localizedDescription)"
            }
        } else {
            errorMessage = "Unexpected error: \(error.localizedDescription)"
        }
        print(errorMessage ?? "")
    }
}
