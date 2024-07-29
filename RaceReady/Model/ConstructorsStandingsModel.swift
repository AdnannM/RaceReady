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
    @Published var error: Error?
    
    init(webservice: WebService, constructorExtendedModel: ConstructorExtendedModel) {
        self.webservice = webservice
        self.constructorExtendedModel = constructorExtendedModel
    }
    
    func populateConstructorsStandings() {
        isLoading = true
        error = nil
        
        Task {
            do {
                var standings = try await webservice.fetchConstructorsStandings()
                for index in standings.indices {
                    let name = standings[index].constructor.name
                    let normalizedName = normalizeTeamName(name)
                    if let extendedData = constructorExtendedModel.constructorExtendedData[normalizedName] {
                        standings[index].teamLogoImage = extendedData.teamLogoImage
                        standings[index].teamCarImage = extendedData.teamCarImage
                        standings[index].teamDriverOne = extendedData.teamDriverOne
                        standings[index].teamDriverTwo = extendedData.teamDriverTwo
                    } else {
                        print("No extended data found for team: \(name) (normalized: \(normalizedName))")
                    }
                }
                self.constructorStanding = standings
            } catch {
                self.error = error
                print("Error fetching standings: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
    
    func normalizeTeamName(_ name: String) -> String {
        switch name {
        case "Red Bull", "Red Bull Racing":
            return "Red Bull Racing"
        case "Ferrari", "Scuderia Ferrari":
            return "Ferrari"
        case "Mercedes", "Mercedes AMG Petronas", "Mercedes-AMG Petronas F1 Team":
            return "Mercedes"
        case "McLaren", "McLaren F1 Team":
            return "McLaren"
        case "Aston Martin", "Aston Martin Aramco Cognizant F1 Team":
            return "Aston Martin"
        case "Alpine", "Alpine F1 Team", "BWT Alpine F1 Team":
            return "Alpine"
        case "Williams", "Williams Racing":
            return "Williams"
        case "AlphaTauri", "Scuderia AlphaTauri", "RB", "Racing Bulls", "Visa Cash App RB":
            return "RB"
        case "Alfa Romeo", "Kick Sauber", "Stake F1 Team Kick Sauber":
            return "Kick Sauber"
        case "Haas", "Haas F1 Team", "MoneyGram Haas F1 Team":
            return "Haas"
        default:
            return name
        }
    }
}
