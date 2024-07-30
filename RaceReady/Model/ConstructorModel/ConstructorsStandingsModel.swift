//
//  ConstructorsStandingsModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 18.07.24.
//

import Foundation

// MARK: - ConstructorsStandingsModel
class ConstructorsStandingsModel: BaseStandingsModel<ConstructorStandingModel> {
    let constructorExtendedModel: ConstructorExtendedModel
    
    init(webservice: WebService, constructorExtendedModel: ConstructorExtendedModel) {
        self.constructorExtendedModel = constructorExtendedModel
        super.init(webservice: webservice, standingsType: .teams)
        Task {
            await populateStandings()
        }
    }
    
    override func fetchFromApi() async throws {
        var fetchTeamsStandings = try await webservice.fetchConstructorsStandings()
        updateTeamsStandings(&fetchTeamsStandings)
        self.standings = fetchTeamsStandings
        F1CacheManager.shared.saveTeamsStandings(self.standings)
        lastUpdate = Date()
        dataSource = .api
        checkCacheAvailability()
        print("Data Fetched from API - constructors - and cache")
    }
    
    override func loadFromCache() {
        if var cachedTeamStandings = F1CacheManager.shared.getTeamsStandings() {
            updateTeamsStandings(&cachedTeamStandings)
            self.standings = cachedTeamStandings
            lastUpdate = F1CacheManager.shared.getLastUpdatedDate(for: .teams)
            dataSource = .cache
            print("Data load from cache")
        } else {
            print("No cache data available")
        }
        
        checkCacheAvailability()
    }
    
    override func checkCacheAvailability() {
        isCacheAvailable = F1CacheManager.shared.getTeamsStandings() != nil
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
}


// MARK: - Helper Extensions

extension ConstructorStandingModel {
    mutating func updateWithExtendedData(_ extendedData: ConstructorExtendedData) {
        self.teamLogoImage = extendedData.teamLogoImage
        self.teamCarImage = extendedData.teamCarImage
        self.teamDriverOne = extendedData.teamDriverOne
        self.teamDriverTwo = extendedData.teamDriverTwo
    }
}



