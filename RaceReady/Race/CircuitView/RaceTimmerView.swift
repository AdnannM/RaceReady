//
//  RaceTimmerView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI

struct RaceTimmerView: View {
    
    @StateObject private var viewModel = CountdownViewModel()
    var race: Race
    
    var body: some View {

        HStack {
            VStack(alignment: .leading) {
                Spacer()
                Text("GRAND PRIX WEEKEND")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                Divider()
                    .padding(.trailing, 15)
                Spacer()
                
                HStack(spacing: 20) {
                    VStack {
                        Text("\(viewModel.days)")
                            .font(.largeTitle)
                        Text("DAYS")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                    
                    Divider()
                    
                    VStack {
                        Text("\(viewModel.hours)")
                            .font(.largeTitle)
                        Text("HRS")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                    
                    Divider()
                    
                    VStack {
                        Text("\(viewModel.minutes)")
                            .font(.largeTitle)
                        Text("MINS")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                    
                }
                
                Spacer()
            }
            
            Image(systemName: "clock.circle")
                .font(.system(size: 70))
        }
        .padding()
        .frame(width: 350, height: 130)
        .overlay {
            BottomRightRoundedBorder()
                .stroke(Color.gray, lineWidth: 1)
        }
        .onAppear {
            if let raceDate = race.date.toDate() {
                viewModel.startCountdown(to: raceDate)
            }
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


import SwiftUI
import Combine

class CountdownViewModel: ObservableObject {
    @Published var days: Int = 0
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    
    private var timer: AnyCancellable?
    
    func startCountdown(to date: Date) {
        timer?.cancel()
        updateTimeRemaining(date.timeIntervalSinceNow)  // Update immediately
        
        timer = Timer.publish(every: 60, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                let timeInterval = date.timeIntervalSinceNow
                if timeInterval > 0 {
                    self.updateTimeRemaining(timeInterval)
                } else {
                    self.timer?.cancel()
                }
            }
    }
    
    private func updateTimeRemaining(_ timeInterval: TimeInterval) {
        let totalMinutes = Int(timeInterval / 60)
        let totalHours = totalMinutes / 60
        days = totalHours / 24
        hours = totalHours % 24
        minutes = totalMinutes % 60
    }
}
