//
//  RaceResultsViewModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 12.07.24.
//

import SwiftUI

class RaceResultsViewModel: ObservableObject {
    @Published var sortedResults: [Result] = []
    
    init(raceResult: RaceResult) {
        self.sortedResults = raceResult.results.sorted { Int($0.position) ?? Int.max < Int($1.position) ?? Int.max }
    }
    
    func colorForConstructor(_ constructorName: String) -> Color {
        switch constructorName.lowercased() {
        case "red bull":
            return .blue
        case "mclaren":
            return .orange
        case "ferrari":
            return .red
        case "mercedes":
            return .gray
        default:
            return .clear
        }
    }
}
