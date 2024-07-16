//
//  DriverStandingsData.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 16.07.24.
//

import Foundation

struct DriverStandings: Codable {
    let mrData: DriverMRData
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct DriverMRData: Codable {
    let standingsTable: StandingsTable
    
    enum CodingKeys: String, CodingKey {
        case standingsTable = "StandingsTable"
    }
}

struct StandingsTable: Codable {
    let standingsLists: [StandingsList]
    
    enum CodingKeys: String, CodingKey {
        case standingsLists = "StandingsLists"
    }
}

struct StandingsList: Codable {
    let driverStandings: [DriverStanding]
    
    enum CodingKeys: String, CodingKey {
        case driverStandings = "DriverStandings"
    }
}

struct DriverStanding: Codable {
    let position: String
    let positionText: String
    let points: String
    let wins: String
    let driver: DriverData
    let constructors: [ConstructorData]
    
    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}

struct DriverData: Codable {
    let driverId: String
    let permanentNumber: String
    let code: String
    let url: String
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String
}

struct ConstructorData: Codable {
    let constructorId: String
    let url: String
    let name: String
    let nationality: String
}
