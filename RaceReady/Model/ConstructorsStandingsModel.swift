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
            await fetchStandings()
            isLoading = false
        }
    }
    
    private func fetchStandings() async {
        do {
            var standings = try await webservice.fetchConstructorsStandings()
            updateTeamsStandigs(&standings)
            constructorStanding = standings
        } catch {
            self.error = error
            print("Error fetching standings: \(error.localizedDescription)")
        }
    }
    
    private func updateTeamsStandigs(_ standings: inout [ConstructorStandingModel]) {
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
}

extension ConstructorStandingModel {
    mutating func updateWithExtendedData(_ extendedData: ConstructorExtendedData) {
        self.teamLogoImage = extendedData.teamLogoImage
        self.teamCarImage = extendedData.teamCarImage
        self.teamDriverOne = extendedData.teamDriverOne
        self.teamDriverTwo = extendedData.teamDriverTwo
    }
}




