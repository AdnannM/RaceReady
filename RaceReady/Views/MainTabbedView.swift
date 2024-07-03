//
//  MainView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

struct MainTabbedView: View {
    
    @State private var activeTab: Tab = .season
    @State private var tabShapePosition: CGPoint = .zero
    
    @Namespace private var animation
    
    
    init() {
        UITableView.appearance().isHidden = true
    }
    
    var body: some View {
        
        TabView(selection: $activeTab) {
            RaceView()
                .tag(Tab.season)
            Text("Drivers")
                .tag(Tab.driver)
            Text("Teams")
                .tag(Tab.teams)
            Text("News")
                .tag(Tab.news)
        }
        
        CustomTabBar()
        
        
    }
    
    // Custom TabBar
    
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color("ColorBlue"), _ inactiveTint: Color = .blue) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) {
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: $0,
                    animation: animation,
                    activeTab: $activeTab,
                    postion: $tabShapePosition
                )
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background {
            TabShape(midPoint: tabShapePosition.x)
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}



#Preview {
    MainTabbedView().environmentObject(SeasonModel(webservice: WebService()))
}





