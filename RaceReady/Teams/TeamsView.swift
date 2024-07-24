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
        Group {
            if constructorsStandingsModel.isLoading {
                DotLoader(loadingText: "Loading teams...")
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

