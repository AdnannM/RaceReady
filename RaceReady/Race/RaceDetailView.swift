//
//  RaceDetailView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import SwiftUI

struct RaceDetailView: View {
    let race: Race
    @State private var raceResult: RaceResult?
    @State private var driverInfo = DriverInfo()
    @EnvironmentObject var raceResultModel: RaceResultModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Image(race.circuitImage ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 250)
                
                if race.isUpcoming {
                    RaceTimmerView(race: race)
                } else if let raceResult = raceResult {
                    RaceResultsView(raceResult: raceResult, driverInfo: driverInfo)
                } else {
                    ProgressView()
                }
                
                CircuitInfoView(race: race)
                
                Spacer()
            }
            .padding(.top, 20) // Adjust the top padding as needed
            .padding(.horizontal)
        }
        .navigationTitle(race.raceName)
        .task {
            do {
                // Fetch all race results
                try await raceResultModel.populateRaceResults()
                
                // Find the specific race result for the current race
                if let result = raceResultModel.raceResults.first(where: { $0.round == race.round && $0.raceName == race.raceName }) {
                    raceResult = result
                } else {
                    print("Race result not found")
                }
            } catch {
                print("Error fetching race results: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    let sampleRace = Race(
        round: "1",
        raceName: "Sample Race",
        circuit: Circuit(circuitId: "sampleCircuit", circuitName: "Sample Circuit", location: Location(locality: "Sample City", country: "Sample Country")),
        date: "2024-07-19",
        time: "12:00:00Z",
        firstPractice: Session(date: "2024-07-18", time: "10:00:00Z"),
        qualifying: Session(date: "2024-07-19", time: "14:00:00Z"),
        sprint: nil,
        secondPractice: nil,
        thirdPractice: nil,
        circuitId: nil,
        circuitImage: "hungaryCircuit",
        firstGp: 2021,
        numberOfLaps: 52,
        circuitLenght: 2.304,
        raceDistance: 306.55
    )

    let sampleDriver = Driver(driverId: "ver", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch", code: "VER")
    let sampleConstructor = Constructor(constructorId: "red_bull", name: "Red Bull", nationality: "Austrian")
    let sampleResult1 = Result(number: "1", position: "1", driver: sampleDriver, constructor: sampleConstructor, grid: "1", laps: "53", status: "Finished")
    let sampleResult2 = Result(number: "44", position: "2", driver: sampleDriver, constructor: sampleConstructor, grid: "2", laps: "53", status: "Finished")
    let sampleResult3 = Result(number: "16", position: "3", driver: sampleDriver, constructor: sampleConstructor, grid: "3", laps: "53", status: "Finished")
    let _ = RaceResult(round: "1", raceName: "Sample Race", circuit: RaceCircuit(circuitId: "suzuka", circuitName: "Suzuka Circuit"), date: "2024-07-19", time: "12:00:00Z", results: [sampleResult1, sampleResult2, sampleResult3])

    return RaceDetailView(race: sampleRace).environmentObject(RaceResultModel(webService: WebService()))
}
