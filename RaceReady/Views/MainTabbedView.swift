//
//  MainView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

enum Tab1: String, CaseIterable {
    case season, driver, teams, news
}

struct MainTabbedView: View {
    @State private var activeTab: Tab = .season
    
    var body: some View {
        TabView(selection: $activeTab) {
            RaceView()
                .tabItem {
                    Label("Season", systemImage: "calendar")
                }
                .tag(Tab1.season)
            
            Text("Drivers")
                .tabItem {
                    Label("Drivers", systemImage: "person.2")
                }
                .tag(Tab1.driver)
            
            Text("Teams")
                .tabItem {
                    Label("Teams", systemImage: "car.rear.road.lane")
                }
                .tag(Tab1.teams)
            
            Text("News")
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
                .tag(Tab1.news)
        }
        .background(.primary)
    }
}



#Preview {
    MainTabbedView()
        .environmentObject(RaceResultModel(webService: WebService()))
        .environmentObject(SeasonModel(webservice: WebService()))
}




