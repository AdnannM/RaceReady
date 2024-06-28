//
//  AnimatedTabbar.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable  {
    case race = "Race"
    case drivers = "Drivers"
    case teams = "Teams"
    case news = "News"

    var systemImage: String {
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
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
