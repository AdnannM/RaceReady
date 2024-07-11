//
//  RaceData.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 11.07.24.
//

import Foundation

struct RaceResultData: Codable {
    let raceMRData: RaceMRData
    
    enum CodingKeys: String, CodingKey {
        case raceMRData = "MRData"
    }
}

struct RaceMRData: Codable {
    let raceResultTable: RaceResultTable
    
    enum CodingKeys: String, CodingKey {
        case raceResultTable = "RaceTable"
    }
}

struct RaceResultTable: Codable {
    let season: String
    let races: [RaceResult]
    
    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}


struct RaceResult: Codable {
    let round: String
    let raceName: String
    let circuit: RaceCircuit
    let date: String
    let time: String?
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case round
        case raceName
        case circuit = "Circuit"
        case date
        case time
        case results = "Results"
    }
}

struct RaceCircuit: Codable {
    let circuitId: String
    let circuitName: String

    enum CodingKeys: String, CodingKey {
        case circuitId
        case circuitName
    }
}


struct Result: Codable {
    let number: String
    let position: String
    let driver: Driver
    let constructor: Constructor
    let grid: String
    let laps: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case number
        case position
        case driver = "Driver"
        case constructor = "Constructor"
        case grid
        case laps
        case status
    }
}

struct Driver: Codable {
    let driverId: String
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String
    let code: String
    
    enum CodingKeys: String, CodingKey {
        case driverId
        case givenName
        case familyName
        case dateOfBirth
        case nationality
        case code
    }
}

struct Constructor: Codable {
    let constructorId: String
    let name: String
    let nationality: String
    
    enum CodingKeys: String, CodingKey {
        case constructorId
        case name
        case nationality
    }
}
