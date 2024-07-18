//
//  MainView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

struct MainTabbedView: View {
    @State private var activeTab: Tab = .season
    
    var body: some View {
        TabView(selection: $activeTab) {
            NavigationStack {
                RaceView()
            }
            .tabItem {
                Label(Tab.season.rawValue, systemImage: Tab.season.systemImage)
            }
            .tag(Tab.season)
            
            NavigationStack {
                DriversView()
            }
            .tabItem {
                Label(Tab.driver.rawValue, systemImage: Tab.driver.systemImage)
            }
            .tag(Tab.driver)
            
            NavigationStack {
                TeamsView()
            }
            .tabItem {
                Label(Tab.teams.rawValue, systemImage: Tab.teams.systemImage)
            }
            .tag(Tab.teams)
            
            NavigationStack {
                NewsView()
            }
            .tabItem {
                Label(Tab.news.rawValue, systemImage: Tab.news.systemImage)
            }
            .tag(Tab.news)
        }
    }
}



#Preview {
    MainTabbedView()
        .environmentObject(RaceResultModel(webService: WebService()))
        .environmentObject(SeasonModel(webservice: WebService()))
        .environmentObject(DriverStandingsModel(webservice: WebService()))
        .environmentObject(ConstructorsStandingsModel(webservice: WebService(), constructorExtendedModel: ConstructorExtendedModel()))
}




