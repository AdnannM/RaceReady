//
//  TeamsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

struct TeamsView: View {
    @EnvironmentObject var constructorsStandingsModel: ConstructorsStandingsModel
    @State private var isRefreshing = false
    
    var body: some View {
        VStack {
            if constructorsStandingsModel.isLoading {
                DotLoader(loadingText: "Teams loading...")
            } else if let errorMessage = constructorsStandingsModel.errorMessage {
                errorView(message: errorMessage)
            } else if constructorsStandingsModel.standings.isEmpty {
                EmptyView()
            } else {
                teamsList
            }
        }
        .navigationTitle("F1 Teams Standings")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: { loadDataIfNeeded() })
        .refreshable {
            guard !isRefreshing else { return }
            isRefreshing = true
            await constructorsStandingsModel.refreshData()
            isRefreshing = false
        }
    }
    
    
    private func errorView(message: String) -> some View {
        Group {
            if constructorsStandingsModel.isCacheAvailable {
                teamsList
            } else {
                Text("No cached data available")
                    .foregroundColor(.orange)
            }
        }
    }
    
    private var teamsList: some View {
        List(constructorsStandingsModel.standings, id: \.constructor.name) { constructorStandigs in
            ConstructorStaindingView(constructorStandigs: constructorStandigs)
        }
    }
    
    private func loadDataIfNeeded() {
        if constructorsStandingsModel.standings.isEmpty {
            Task {
                await constructorsStandingsModel.populateStandings()
            }
        }
    }
}


#Preview {
    NavigationStack {
        TeamsView()
            .environmentObject(ConstructorsStandingsModel(webservice: WebService(), constructorExtendedModel: ConstructorExtendedModel()))
    }
}

