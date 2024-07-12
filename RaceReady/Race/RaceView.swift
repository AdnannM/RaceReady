//
//  RaceTastView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 04.07.24.
//

import SwiftUI

struct RaceView: View {
    @EnvironmentObject var seasonModel: SeasonModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                if seasonModel.isLoading || (!seasonModel.hasLoaded && seasonModel.races.isEmpty) {
                    ShimmerView()
                } else if !seasonModel.races.isEmpty {
                    RaceCellView()
                } else {
                    Text("No races found")
                }
            }
        }
        .task {
            if !seasonModel.hasLoaded {
                await seasonModel.populateSeason()
            }
        }
    }
}

#Preview {
    RaceView()
        .environmentObject(SeasonModel(webservice: WebService()))
        .environmentObject(RaceResultModel(webService: WebService()))
}


