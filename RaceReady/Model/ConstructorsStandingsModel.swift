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
    
    @Published private(set) var constructorStanding: [ConstructorStandingModel] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    init(webservice: WebService) {
        self.webservice = webservice
    }
    
    func populateConstructorsStandings() {
        isLoading = true
        error = nil
        
        Task {
            do {
                self.constructorStanding = try await webservice.fetchConstructorsStandings()
                print("Fetched \(self.constructorStanding.count) standings")
            } catch {
                self.error = error
                print("Error fetching standings: \(error.localizedDescription)")
            }
            isLoading = false
        }
    }
}
