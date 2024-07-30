//
//  RaceResultModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 11.07.24.
//

import Foundation

@MainActor
class RaceResultModel: ObservableObject {
    
    let webService: WebService
    
    @Published private(set) var raceResults: [RaceResult] = []
    @Published var driverInfo = DriverInfo()
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func populateRaceResults() async throws {
        do {
            self.raceResults = try await webService.fetchRaceResults()
            self.assignDriverImages()
        } catch {  
            throw error
        }
    }
    
    private func assignDriverImages() {
        for index in raceResults.indices {
            for resultIndex in raceResults[index].results.indices {
                let driverCode = raceResults[index].results[resultIndex].driver.code
                if let driverData = driverInfo.driverInfo.first(where: { $0.driverCode == driverCode }) {
                    raceResults[index].results[resultIndex].driver.driverImage = driverData.driverImage
                }
                print("Driver Code: \(driverCode), Assigned Image: \(raceResults[index].results[resultIndex].driver.driverImage ?? "None")")
            }
        }
    }
}
