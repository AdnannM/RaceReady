//
//  ConstructorModel.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 18.07.24.
//

import Foundation

struct ConstructorStandings: Codable {
    let mrData: ConstructorMRData
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct ConstructorMRData: Codable {
    let standingsTable: StandingsConstructorTable
    
    enum CodingKeys: String, CodingKey {
        case standingsTable = "StandingsTable"
    }
}

struct StandingsConstructorTable: Codable {
    let standingsLists: [StandingsConstructorList]
    
    enum CodingKeys: String, CodingKey {
        case standingsLists = "StandingsLists"
    }
}

struct StandingsConstructorList: Codable {
    let constructorStandings: [ConstructorStandingModel]
    
    enum CodingKeys: String, CodingKey {
        case constructorStandings = "ConstructorStandings"
    }
}

struct ConstructorStandingModel: Codable, Identifiable {
    let id = UUID()
    let position: String
    let points: String
    let constructor: ConstructorInfo
    var teamLogoImage: String?
    var teamCarImage: String?
    var teamDriverOne: String?
    var teamDriverTwo: String?
    
    enum CodingKeys: String, CodingKey {
        case position
        case points
        case constructor = "Constructor"
    }
}

struct ConstructorInfo: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
