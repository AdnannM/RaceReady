//
//  RaceTastView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 04.07.24.
//

import SwiftUI

struct TestRaceView: View {
    @EnvironmentObject var seasonModel: SeasonModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
                        
            if seasonModel.isLoading || (seasonModel.races.isEmpty && !seasonModel.hasLoaded) {
                ShimmerView()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Upcoming Races")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                            .opacity(0.6)
                        
                        // Horizontal stack for all races
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                ForEach(seasonModel.races, id: \.round) { race in
                                    NavigationLink(destination: RaceDetailView()) {
                                        TestRaceCard(race: race)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        Text("Finished Races")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                            .opacity(0.6)
                        
                        // Vertical stack for all races
                        LazyVStack(alignment: .leading, spacing: 15) {
                            ForEach(seasonModel.races, id: \.round) { race in
                                NavigationLink(destination: RaceDetailView()) {
                                    TestRaceRow(race: race)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                }
                .navigationTitle("F1 Race")
                .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
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

struct TestRaceCard: View {
    @Environment(\.colorScheme) var colorScheme
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(race.circuit.circuitName)
                    .font(.system(size: 25))
                    .fontWidth(.compressed)
                    .fontWeight(.medium)
                Spacer()
                Image("austria")  // Replace with race-specific flag image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35)
                    .shadow(color: colorScheme == .dark ? .white : .black, radius: 0.5)
            }
            .padding(.bottom, 5)
            
            Divider()
            
            Image("austriaCircuit")  // Replace with race-specific image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            
            Divider()
            
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
            .padding(.vertical, 5)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)).shadow(radius: 2))
        .padding(.vertical, 10)  // Add vertical padding
    }
}


struct TestRaceRow: View {
    @Environment(\.colorScheme) var colorScheme
    let race: Race
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text(race.circuit.circuitName)
                    .font(.system(size: 25))
                    .fontWidth(.compressed)
                    .fontWeight(.medium)
                Spacer()
                Image("austria")  // Replace with race-specific flag image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35)
                    .shadow(color: colorScheme == .dark ? .white : .black, radius: 0.5)
            }
            .padding(.bottom, 5)
            
            Divider()
            
            Image("austriaCircuit")  // Replace with race-specific image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            
            Divider()
            
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
            .padding(.vertical, 5)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)).shadow(radius: 2))
        .padding(.vertical, 10)  // Add vertical padding
    }
}
#Preview {
    TestRaceView().environmentObject(SeasonModel(webservice: WebService()))
}
