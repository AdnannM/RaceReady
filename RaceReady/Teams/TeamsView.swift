//
//  TeamsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

/// TODO:
/// - Fetch data from Api and display postion points and team name
/// - Combine stored data with api and display  drivers name team logo and f1 team car
/// - Refactor the code and make it more readable

struct TeamsView: View {
    @EnvironmentObject var constructorsStandingsModel: ConstructorsStandingsModel
    
    var body: some View {
        Group {
            if constructorsStandingsModel.isLoading {
                ProgressView("Loading teams...")
            } else if let error = constructorsStandingsModel.error {
                ErrorView(errorMessage: error.localizedDescription) {
                    Task {
                         constructorsStandingsModel.populateConstructorsStandings()
                    }
                }
            } else if constructorsStandingsModel.constructorStanding.isEmpty {
                Text("No team standings available")
                    .foregroundColor(.secondary)
            } else {
                List {
                    ForEach(constructorsStandingsModel.constructorStanding, id: \.constructor.name) { constructorStanding in
                        ConstructorStaindingView(constructorStandigs: constructorStanding)
                    }
                }
            }
        }
        .navigationTitle("F1 Teams 2024")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            if constructorsStandingsModel.constructorStanding.isEmpty {
                Task {
                     constructorsStandingsModel.populateConstructorsStandings()
                }
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

