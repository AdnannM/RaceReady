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
            List(seasonModel.races, id: \.round) { race in
                NavigationLink(destination: RaceDetailView()) {
                    VStack {
                        HStack {
                            Text(race.circuit.circuitName)
                                .font(.system(size: 26))
                                .fontWidth(.condensed)
                                .foregroundColor(.primary) // Explicitly set the text color
                            Spacer()
                            Image("flag")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        }
                        
                        Image("test")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        VStack(spacing: 10) {
                            HStack {
                                Text(race.raceName)
                                    .foregroundColor(.primary) // Explicitly set the text color
                                Spacer()
                                Text("Round \(race.round)")
                                    .foregroundColor(.primary) // Explicitly set the text color
                            }
                            
                            HStack {
                                Text(race.firstPractice.date.formattedDate())
                                    .foregroundColor(.primary) // Explicitly set the text color
                                Spacer()
                                Text(race.date.formattedDate())
                                    .foregroundColor(.primary) // Explicitly set the text color
                            }
                        }
                    }
                }
            }
            .navigationTitle("F1 Races")
            .onAppear {
                Task {
                    do {
                        try await seasonModel.populateSeason()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
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


