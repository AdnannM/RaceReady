//
//  RaceView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 29.06.24.
//

import SwiftUI

struct RaceView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var seasonModel: SeasonModel
        
    var body: some View {
        NavigationStack {
            if seasonModel.isLoading || (seasonModel.races.isEmpty && !seasonModel.hasLoaded ) {
                ShimmerView()
            } else {
                List(seasonModel.races, id: \.round) { race in
                    NavigationLink(destination: RaceDetailView()) {
                        VStack(spacing: 10) {
                            // Circuit name and flag
                            HStack {
                                Text(race.circuit.circuitName)
                                    .font(.system(size: 25))
                                    .fontWidth(.compressed)
                                    .fontWeight(.medium)
                                    
                                Spacer()
                                Image("austria")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35)
                                    .shadow(color: colorScheme == .dark ? .white : .black, radius: 0.5)
                                    
                            }
                            .padding(.bottom, 5)
                            
                            // Divider
                            Divider()
                            
                            // Circuit image
                            Image("austriaCircuit")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            // Divider
                            Divider()
                            
                            // Race details
                            Section {
                                VStack(spacing: 10) {
                                    HStack {
                                        Text(race.raceName)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        Text("Round \(race.round)")
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    HStack {
                                        Text("\(race.firstPractice.date.formattedDate()) - \(race.date.formattedDate())")
                                            .padding(3)
                                            .foregroundStyle(.secondary)
                                            .background(Color("ColorBlue").opacity(0.8))
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                        Spacer()
                                    }
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }.navigationTitle("F1 Race")
            }
        }
        .task {
            do {
                try await seasonModel.populateSeason()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


#Preview {
    RaceView().environmentObject(SeasonModel(webservice: WebService()))
}



import SwiftUI

extension String {
    func formattedDate(from format: String = "yyyy-MM-dd", to outputFormat: String = "dd MMM") -> String {
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





