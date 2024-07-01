//
//  TabbedItems.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 29.06.24.
//

import Foundation

enum Tab: String, CaseIterable {
    case season = "Season"
    case driver = "Driver"
    case teams = "Teams"
    case news = "News"
    
    var systemImage: String {
        switch self {
        case .season:
            return "house"
        case .driver:
            return "envelope.open.badge.clock"
        case .teams:
            return "hand.raised"
        case .news:
            return "bell"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
