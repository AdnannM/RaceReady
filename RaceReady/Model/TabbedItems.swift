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
    case settings = "Settings"
    
    var systemImage: String {
        switch self {
        case .season:
            return "calendar"
        case .driver:
            return "person.3.fill"
        case .teams:
            return "car.rear.road.lane"
        case .settings:
            return "slider.horizontal.3"
        }
    }
}
