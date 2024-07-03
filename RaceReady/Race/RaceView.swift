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
            if seasonModel.isLoading || (seasonModel.races.isEmpty && !seasonModel.hasLoaded) {
                ShimmerView()
            } else {
                List(seasonModel.races, id: \.round) { race in
                    NavigationLink(destination: RaceDetailView()) {
                        RaceRow(race: race)
                    }
                }
                .navigationTitle("F1 Race")
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










