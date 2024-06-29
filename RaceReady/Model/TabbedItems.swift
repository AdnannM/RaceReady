//
//  TabbedItems.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 29.06.24.
//

import Foundation

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
