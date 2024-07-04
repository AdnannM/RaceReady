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
                        
            if seasonModel.isLoading || (seasonModel.races.isEmpty && !seasonModel.hasLoaded) {
                ShimmerView()
            } else {
                RaceCellView()
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


