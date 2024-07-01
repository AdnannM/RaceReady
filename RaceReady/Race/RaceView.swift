//
//  RaceView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 29.06.24.
//

import SwiftUI

struct RaceView: View {
    
    @EnvironmentObject private var seasonModel: SeasonModel
    
    var body: some View {
        NavigationView {
            HStack {
                List(seasonModel.races, id: \.round) { race in
                    VStack(alignment: .leading) {
                        Image("test")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                        Divider()
                        VStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(race.raceName)
                                        .font(.headline)
                                    Text("\(race.circuit.location.locality), \(race.circuit.location.country)")
                                        .font(.subheadline)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(race.date.formattedDate())
                                    Text((race.time ?? "15:00:00Z").formattedTime(use24HourFormat:is24HourFormat()))
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    Task {
                        do {
                            try await seasonModel.populateSeason()
                            print("View appeared and data fetched")
                        } catch {
                            print("Error in view onAppear: \(error.localizedDescription)")
                        }
                    }
                }
                .navigationTitle("F1 Races")
            }
        }
    }
}

#Preview {
    RaceView().environmentObject(SeasonModel(webservice: WebService()))
}



import SwiftUI

extension String {
    func formattedDate(from format: String = "yyyy-MM-dd", to outputFormat: String = "MMM dd, yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        return self
    }
    
    func formattedTime(from format: String = "HH:mm:ssZ", to outputFormat: String = "h:mm a", use24HourFormat: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let time = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            dateFormatter.locale = Locale(identifier: use24HourFormat ? "en_GB" : "en_US_POSIX")
            return dateFormatter.string(from: time)
        }
        return self
    }
}

func is24HourFormat() -> Bool {
    let locale = Locale.current
    let dateFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale) ?? ""
    return dateFormat.contains("H")
}


