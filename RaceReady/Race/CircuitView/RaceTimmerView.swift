//
//  RaceTimmerView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI

struct RaceTimmerView: View {
    @State private var isAnimating = false
    @StateObject private var viewModel = CountdownViewModel()
    var race: Race
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                
                HeaderView()
                
                Divider().padding(.trailing, 35)
                
                Spacer()
                
                CountdownView(viewModel: viewModel)
                
                Spacer()
            }
            
            RotatingClockView()
        }
        .padding()
        .frame(width: 350, height: 130)
        .overlay {
            BottomRightRoundedBorder()
                .stroke(Color.gray, lineWidth: 1)
        }
        .onAppear {
            viewModel.setRace(race)
        }
    }
}

#Preview {
    
    let sampleRace = Race(
        round: "1",
        raceName: "Sample Race",
        circuit: Circuit(circuitId: "sampleCircuit", circuitName: "Sample Circuit", location: Location(locality: "Sample City", country: "Sample Country")),
        date: "2024-07-31",
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
    
    return RaceTimmerView(race: sampleRace).environmentObject(SeasonModel(webservice: WebService()))
}





func formatDateTime1(date: String, time: String) -> String {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime]
    
    if let dateTime = dateFormatter.date(from: "\(date)T\(time)") {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d HH:mm"
        outputFormatter.timeZone = TimeZone(identifier: "Europe/Berlin")
        
        return outputFormatter.string(from: dateTime)
    }
    
    return "\(date) \(time)"
}
