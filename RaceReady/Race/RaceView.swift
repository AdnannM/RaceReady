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
    @StateObject private var notificationManager = NotificationManager.shared

    var body: some View {
        NavigationStack {
            Group {
                if seasonModel.isLoading {
                    ShimmerView()
                } else if let errorMessage = seasonModel.errorMessage {
                    ErrorView(errorMessage: errorMessage) {
                        Task {
                            await seasonModel.populateSeason()
                        }
                    }
                } else if !seasonModel.races.isEmpty {
                    RaceCellView()
                } else {
                    Text("No races found")
                        .foregroundColor(.secondary)
                }
            }
        }
        .task {
            if !seasonModel.hasLoaded {
                await seasonModel.populateSeason()
                notificationManager.requestNotification()
            }
        }
    }
}


#Preview {
    RaceView()
        .environmentObject(SeasonModel(webservice: WebService()))
        .environmentObject(RaceResultModel(webService: WebService()))
}


