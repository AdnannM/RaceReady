//
//  RaceDetailView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import SwiftUI

struct RaceDetailView: View {
    let race: Race
    
    var body: some View {
        VStack(spacing: 15) {
            Image(race.circuitImage ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 450, height: 300)
            
            if race.isUpcoming {
                RaceTimmerView(race: race)

            }
            
            CircuitInfoView(race: race)
                
            
            Spacer()
        }
        .padding()
        .navigationTitle(race.raceName)
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
    return RaceDetailView(race: sampleRace).environmentObject(SeasonModel(webservice: WebService()))
}


