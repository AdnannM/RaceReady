//
//  CircuitInfo.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI

struct CircuitInfoView: View {
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                CircuitInfoRow(title: "First Grand Prix", value: race.firstGp.map(String.init) ?? "", km: "")
                CircuitInfoRow(title: "Number of Laps", value: race.numberOfLaps.map(String.init) ?? "", km: "")
            }
            HStack {
                CircuitInfoRow(title: "Circuit Length", value: "\(race.circuitLenght ?? 0)", km: "km")
                CircuitInfoRow(title: "Race Distance", value: "\(race.raceDistance ?? 0)", km: "km")
            }
        }
    }
}

struct CircuitInfoRow: View {
    let title: String
    let value: String
    let km: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            HStack(alignment: .lastTextBaseline) {
                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
                if let km = km {
                    Text(km)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding()
        .frame(width: 170, alignment: .topLeading)
        .overlay (
            BottomRightRoundedBorder()
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

// Sample data for preview
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
    return CircuitInfoView(race: sampleRace)
        .environmentObject(SeasonModel(webservice: WebService()))
}
