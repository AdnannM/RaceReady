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
