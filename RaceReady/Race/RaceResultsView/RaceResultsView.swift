//
//  RaceResultsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 10.07.24.
//

import SwiftUI

struct RaceResultsView: View {
    @StateObject private var viewModel: RaceResultsViewModel
    
    init(raceResult: RaceResult, driverInfo: DriverInfo) {
        _viewModel = StateObject(wrappedValue: RaceResultsViewModel(raceResult: raceResult))
    }
    
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: -25) {
            if viewModel.sortedResults.count > 1 {
                DriverView(
                    driverCode: viewModel.sortedResults[1].driver.code,
                    constructorName: viewModel.sortedResults[1].constructor.name,
                    driverImageName: viewModel.sortedResults[1].driver.driverImage,
                    backgroundColor: viewModel.colorForConstructor(viewModel.sortedResults[1].constructor.name),
                    frameHeight: 120
                )
            }
            
            if viewModel.sortedResults.count > 0 {
                DriverView(
                    driverCode: viewModel.sortedResults[0].driver.code,
                    constructorName: viewModel.sortedResults[0].constructor.name,
                    driverImageName: viewModel.sortedResults[0].driver.driverImage,
                    backgroundColor: viewModel.colorForConstructor(viewModel.sortedResults[0].constructor.name),
                    frameHeight: 140
                )
            }
            
            if viewModel.sortedResults.count > 2 {
                DriverView(
                    driverCode: viewModel.sortedResults[2].driver.code,
                    constructorName: viewModel.sortedResults[2].constructor.name,
                    driverImageName: viewModel.sortedResults[2].driver.driverImage,
                    backgroundColor: viewModel.colorForConstructor(viewModel.sortedResults[2].constructor.name),
                    frameHeight: 110
                )
            }
        }
    }
}

#Preview {
    RaceResultsView(raceResult: sampleRaceResult, driverInfo: DriverInfo())
}

// Sample data for preview
let sampleDriver = Driver(driverId: "ver", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch", code: "VER")
let sampleConstructor1 = Constructor(constructorId: "red_bull", name: "Red Bull", nationality: "Austrian")
let sampleConstructor2 = Constructor(constructorId: "mercedes", name: "Mercedes", nationality: "German")
let sampleConstructor3 = Constructor(constructorId: "ferrari", name: "Ferrari", nationality: "Italian")

let sampleResult1 = Result(number: "1", position: "1", driver: sampleDriver, constructor: sampleConstructor1, grid: "1", laps: "53", status: "Finished")
let sampleResult2 = Result(number: "44", position: "2", driver: sampleDriver, constructor: sampleConstructor2, grid: "2", laps: "53", status: "Finished")
let sampleResult3 = Result(number: "16", position: "3", driver: sampleDriver, constructor: sampleConstructor3, grid: "3", laps: "53", status: "Finished")

let sampleRaceResult = RaceResult(round: "4", raceName: "Japanese Grand Prix", circuit: RaceCircuit(circuitId: "suzuka", circuitName: "Suzuka Circuit"), date: "2023-04-23", time: "14:00:00Z", results: [sampleResult1, sampleResult2, sampleResult3])





