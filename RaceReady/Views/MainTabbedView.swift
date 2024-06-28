//
//  MainView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable{
    case race = 0
    case drivers
    case teams
    case news
    
    var title: String{
        switch self {
        case .race:
            return "Race"
        case .drivers:
            return "Driver"
        case .teams:
            return "Teams"
        case .news:
            return "News"
        }
    }
    
    var iconName: String{
        switch self {
        case .race:
            return "house"
        case .drivers:
            return "envelope.open.badge.clock"
        case .teams:
            return "chart.bar.xaxis.ascending"
        case .news:
            return "figure.run"
        }
    }
}

struct MainTabbedView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $selectedTab) {
                Text("Race")
                    .tag(0)

                Text("Drivers")
                    .tag(1)

                Text("Teams")
                    .tag(2)

                Text("News")
                    .tag(3)
            }

            ZStack{
                HStack{
                    ForEach((TabbedItems.allCases), id: \.self){ item in
                        Button{
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .background(.indigo.opacity(0.2))
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
    }
}

extension MainTabbedView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()                
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
                
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? .indigo.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}
#Preview {
    MainTabbedView()
}





