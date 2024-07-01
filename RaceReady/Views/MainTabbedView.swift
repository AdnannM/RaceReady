//
//  MainView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

struct MainTabbedView: View {
    
    @State private var activeTab: Tab = .season
    
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
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
//                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                .blur(radius: 2)
                .padding(.top, 25)
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var postion: CGPoint
    
    @State private var tabShapePosition: CGPoint = .zero
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundStyle(activeTab == tab ? .white : inactiveTint)
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            
            Text(tab.rawValue)
                .font(.caption)
                .foregroundStyle(activeTab == tab ? tint : .gray)
        }
        
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPostion(completion: { rect in
            tabShapePosition.x = rect.midX
            
            if activeTab == tab {
                postion.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                postion.x = tabShapePosition.x
            }
        }
    }
}

#Preview {
    MainTabbedView().environmentObject(SeasonModel(webservice: WebService()))
}





