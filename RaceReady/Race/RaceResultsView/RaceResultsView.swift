//
//  RaceResultsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 10.07.24.
//

import SwiftUI


struct RaceResultsView: View {
    let raceResult: RaceResult
    
    var body: some View {
        let sortedResults = raceResult.results.sorted { Int($0.position) ?? Int.max < Int($1.position) ?? Int.max }
        
        HStack(alignment: .lastTextBaseline, spacing: -25) {
            // Second place
            if sortedResults.count > 1 {
                VStack() {
                    VStack {
                        Spacer()
                        
                        Text(sortedResults[1].driver.code)
                            .font(.system(size: 29))
                            .bold()
                            .frame(maxWidth: .infinity)
                            .background(colorForConstructor(sortedResults[1].constructor.name))
                            .clipShape(.rect(bottomLeadingRadius: 10))
                            .clipShape(.rect(bottomTrailingRadius: 10))
                    }
                    .frame(width: 110, height: 120)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.gray)
                    }
                    .padding()
                    
                    Image("image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 120)
                        .padding(.top, -180)
                }
            }
            
            if sortedResults.count > 0 {
                // First place
                VStack {
                    VStack {
                        Spacer()
                        Text(sortedResults[0].driver.code)
                            .font(.system(size: 29))
                            .bold()
                            .frame(maxWidth: .infinity)
                            .background(colorForConstructor(sortedResults[0].constructor.name))
                            .clipShape(.rect(bottomLeadingRadius: 10))
                            .clipShape(.rect(bottomTrailingRadius: 10))
                    }
                    .frame(width: 110, height: 140)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.gray)
                    }
                    .padding()
                    
                    Image("image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 120)
                        .padding(.top, -180)
                }
            }
            
            if sortedResults.count > 2 {
                VStack {
                    VStack {
                        Spacer()
                        Text(sortedResults[2].driver.code)
                            .font(.system(size: 29))
                            .bold()
                            .frame(maxWidth: .infinity)
                            .background(colorForConstructor(sortedResults[2].constructor.name))
                            .clipShape(.rect(bottomLeadingRadius: 10))
                            .clipShape(.rect(bottomTrailingRadius: 10))
                    }
                    .frame(width: 110, height: 110)
                    .background {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.gray)
                    }
                    .padding()
                    
                    Image("image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 120)
                        .padding(.top, -180)
                }
            }
        }
    }
    
    func colorForConstructor(_ constructorName: String) -> Color {
        switch constructorName.lowercased() {
        case "red bull":
            return .blue
        case "mclaren":
            return .orange
        case "ferrari":
            return .red
        case "mercedes":
            return .gray
        default:
            return .clear
        }
    }
}

#Preview {
    RaceResultsView(raceResult: sampleRaceResult)
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




//
///// TODO: - Refector this code and make it more readable
//
//struct RaceResultsView: View {
//    let raceResult: RaceResult
//    
//    var body: some View {
//        HStack(alignment: .lastTextBaseline, spacing: -25) {
//            // Ensure there are at least 3 results, otherwise handle gracefully
//            if raceResult.results.count >= 3 {
//                // Second place
//                driverView(for: raceResult.results[1])
//                // First place
//                driverView(for: raceResult.results[0])
//                // Third place
//                driverView(for: raceResult.results[2])
//            } else {
//                Text("Not enough data")
//            }
//        }
//    }
//    
//    private func driverView(for result: Result) -> some View {
//        VStack {
//            VStack {
//                Spacer()
//                Text(result.driver.code)
//                    .font(.system(size: 29))
//                    .bold()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.orange)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//            }
//            .frame(width: 110, height: 140)
//            .background {
//                RoundedRectangle(cornerRadius: 15, style: .continuous)
//                    .fill(Color.gray)
//            }
//            .padding()
//            
//            Image("image") // Replace with actual image if available
//                .resizable()
//                .scaledToFit()
//                .frame(width: 150, height: 120)
//                .padding(.top, -180)
//        }
//    }
//}
//
//#Preview {
//    RaceResultsView(raceResult: sampleRaceResult)
//}
//
//// Sample data for preview
//let sampleDriver = Driver(driverId: "ver", givenName: "Max", familyName: "Verstappen", dateOfBirth: "1997-09-30", nationality: "Dutch", code: "VER")
//let sampleConstructor = Constructor(constructorId: "red_bull", name: "Red Bull", nationality: "Austrian")
//let sampleResult1 = Result(number: "1", position: "1", driver: sampleDriver, constructor: sampleConstructor, grid: "1", laps: "53", status: "Finished")
//let sampleResult2 = Result(number: "44", position: "2", driver: sampleDriver, constructor: sampleConstructor, grid: "2", laps: "53", status: "Finished")
//let sampleResult3 = Result(number: "16", position: "3", driver: sampleDriver, constructor: sampleConstructor, grid: "3", laps: "53", status: "Finished")
//
//let sampleRaceResult = RaceResult(round: "4", raceName: "Japanese Grand Prix", circuit: RaceCircuit(circuitId: "suzuka", circuitName: "Suzuka Circuit"), date: "2023-04-23", time: "14:00:00Z", results: [sampleResult1, sampleResult2, sampleResult3])
