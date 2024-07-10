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
        
        // MARK: - BUG with the time add +4h and need to be +2h when time is converted
        .onAppear {
            if let time = race.firstPractice.time {
                let combinedDateTimeString = "\(race.firstPractice.date)T\(time)"
                print("Combined date and time string: \(combinedDateTimeString)")
                if let raceDate = combinedDateTimeString.toISO8601Date() {
                    let localRaceDate = raceDate.toTimeZone(7200) // Explicitly set to +2 hours (7200 seconds)
                    print("First practice local date: \(localRaceDate.formattedLocalDateTime())")
                    viewModel.startCountdown(to: localRaceDate)
                } else {
                    print("Failed to parse date string: \(combinedDateTimeString)")
                }
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


/*
 TODO:
         - Convert time from Z to Central Eu Time
         - With this code it works but add +4h time
           Insted of +2h and in this case first practice
           start and 15:30 insted of 13:30
 */

extension String {
    func toISO8601Date() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: self)
    }
}

extension Date {
    func toTimeZone(_: Int) -> Date {
        let timeZone = TimeZone.current
        let seconds = TimeInterval(timeZone.secondsFromGMT(for: self))
        return self.addingTimeInterval(seconds)
    }
    
    func formattedLocalDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}
