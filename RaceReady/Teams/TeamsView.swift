//
//  TeamsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

struct TeamsView: View {
    @EnvironmentObject var constructorsStandingsModel: ConstructorsStandingsModel
    
    var body: some View {
        VStack {
            if constructorsStandingsModel.isLoading {
                DotLoader(loadingText: "Teams loading...")
            } else if let errorMessage = constructorsStandingsModel.errorMessage {
                errorView(message: errorMessage)
            } else if constructorsStandingsModel.constructorStanding.isEmpty {
                EmptyView()
            } else {
                teamsList
            }
        }
        .navigationTitle("F1 Teams Standings")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(perform: {
            loadDataIfNeeded()
        })
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
        List(constructorsStandingsModel.constructorStanding, id: \.constructor.name) { constructorStandigs in
            ConstructorStaindingView(constructorStandigs: constructorStandigs)
        }
    }
    
    private func loadDataIfNeeded() {
        if constructorsStandingsModel.constructorStanding.isEmpty {
            Task {
                await constructorsStandingsModel.populateConstructorsStandings()
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

