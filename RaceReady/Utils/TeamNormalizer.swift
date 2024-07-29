//
//  TeamNormalizer.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 29.07.24.
//

import Foundation

struct TeamNormalizer {
    
    static func normalizeTeamName(_ name: String) -> String {
        let teamNameMap: [String: String] = [
            "Red Bull": "Red Bull Racing",
            "Red Bull Racing": "Red Bull Racing",
            "Ferrari": "Ferrari",
            "Scuderia Ferrari": "Ferrari",
            "Mercedes": "Mercedes",
            "Mercedes AMG Petronas": "Mercedes",
            "Mercedes-AMG Petronas F1 Team": "Mercedes",
            "McLaren": "McLaren",
            "McLaren F1 Team": "McLaren",
            "Aston Martin": "Aston Martin",
            "Aston Martin Aramco Cognizant F1 Team": "Aston Martin",
            "Alpine": "Alpine",
            "Alpine F1 Team": "Alpine",
            "BWT Alpine F1 Team": "Alpine",
            "Williams": "Williams",
            "Williams Racing": "Williams",
            "AlphaTauri": "RB",
            "Scuderia AlphaTauri": "RB",
            "RB": "RB",
            "Racing Bulls": "RB",
            "Visa Cash App RB": "RB",
            "Alfa Romeo": "Kick Sauber",
            "Kick Sauber": "Kick Sauber",
            "Stake F1 Team Kick Sauber": "Kick Sauber",
            "Haas": "Haas",
            "Haas F1 Team": "Haas",
            "MoneyGram Haas F1 Team": "Haas"
        ]
        
        return teamNameMap[name] ?? name
    }
}
