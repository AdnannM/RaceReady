//
//  RaceCellView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 04.07.24.
//

import Foundation
import SwiftUI

struct RaceCellView: View {
    @EnvironmentObject var seasonModel: SeasonModel
    
    var body: some View {
        Group {
            if seasonModel.isLoading {
                DotLoader(loadingText: "Loading...")
            } else if let errorMessage = seasonModel.errorMessage {
                RaceErrorView(message: errorMessage, retryAction: seasonModel.refreshData)
            } else {
                RaceListView(races: seasonModel.races)
            }
        }
        .onAppear(perform: loadDataIfNeeded)
        .refreshable { await seasonModel.refreshData() }
    }
    
    private func loadDataIfNeeded() {
        guard !seasonModel.hasLoaded else { return }
        Task { await seasonModel.populateSeason() }
    }
}

struct RaceErrorView: View {
    let message: String
    let retryAction: () async -> Void
    
    var body: some View {
        VStack {
            Text(message)
            Button("Retry") {
                Task { await retryAction() }
            }
        }
    }
}

struct RaceListView: View {
    let races: [Race]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                RaceSection(title: "Upcoming Races", races: races.filter(\.isUpcoming), rowType: .card)
                RaceSection(title: "Finished Races", races: races.filter { !$0.isUpcoming }.reversed(), rowType: .row)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        .navigationTitle("F1 Race")
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

struct RaceSection: View {
    let title: String
    let races: [Race]
    let rowType: RaceRowType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.leading)
                .opacity(0.6)
            
            if rowType == .card {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 15) {
                        ForEach(races, id: \.round) { race in
                            NavigationLink(destination: RaceDetailView(race: race)) {
                                RaceCard(race: race)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            } else {
                LazyVStack(alignment: .leading, spacing: 15) {
                    ForEach(races, id: \.round) { race in
                        NavigationLink(destination: RaceDetailView(race: race)) {
                            RaceRow(race: race)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

enum RaceRowType {
    case card
    case row
}

extension Race {
    var isUpcoming: Bool {
        guard let raceDate = date.toDate() else { return false }
        return raceDate >= Date()
    }
}

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}
