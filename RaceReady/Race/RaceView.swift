//
//  RaceTastView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 04.07.24.
//

import SwiftUI

struct RaceView: View {
    @EnvironmentObject var seasonModel: SeasonModel
    @EnvironmentObject var raceResultModel: RaceResultModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            
            if seasonModel.isLoading || (seasonModel.races.isEmpty && !seasonModel.hasLoaded) {
                ShimmerView()
            } else {
                RaceCellView()
            }
        }.task {
            do {
                try await raceResultModel.populateRaceResults()
                
                // Create a dictionary to store unique races
                var uniqueRaces: [String: RaceResult] = [:]
                
                // Populate the dictionary with unique races 
                for race in raceResultModel.raceResults {
                    let key = "\(race.round)-\(race.raceName)"
                    if uniqueRaces[key] == nil {
                        uniqueRaces[key] = race
                    }
                }
                
                // Sort the unique races by round number
                let sortedRaces = uniqueRaces.values.sorted { Int($0.round) ?? 0 < Int($1.round) ?? 0 }
                
                for race in sortedRaces {
                    print("--------------------------------------")
                    print("Round \(race.round) - \(race.raceName)")
                    print("Circuit: \(race.circuit.circuitName)")
                    print("--------------------------------------")
                    print("Top 3 Results:")
                    
                    // Sort results by position
                    let sortedResults = race.results.sorted { Int($0.position) ?? Int.max < Int($1.position) ?? Int.max }
                    
                    // Display up to 3 positions
                    for i in 0..<min(3, sortedResults.count) {
                        let result = sortedResults[i]
                        print("  Position \(result.position): \(result.driver.code)")
                        print("    Number: \(result.number)")
                        print("    Constructor: \(result.constructor.name)")
                        print("    Grid: \(result.grid)")
                        print("    Laps: \(result.laps)")
                        print("    Status: \(result.status)")
                        print("") // Empty line between positions
                    }
                    
                    // If there are fewer than 3 results, print a message
                    if sortedResults.count < 3 {
                        print("  Note: Only \(sortedResults.count) position(s) available for this race.")
                    }
                }
                
                print("Season data populated")
            } catch {
                print("Error fetching race results: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    RaceView()
        .environmentObject(SeasonModel(webservice: WebService()))
        .environmentObject(RaceResultModel(webService: WebService()))
}


