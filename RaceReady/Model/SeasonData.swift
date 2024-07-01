//
//  SeasonData.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import Foundation

struct SeasonData: Codable {
    let mrData: MRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct MRData: Codable {
    let raceTable: RaceTable

    enum CodingKeys: String, CodingKey {
        case raceTable = "RaceTable"
    }
}

struct RaceTable: Codable {
    let season: String
    let races: [Race]

    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}

struct Race: Codable {
    let round: String
    let raceName: String
    let circuit: Circuit
    let date: String
    let time: String?
    let firstPractice: Session
    let qualifying: Session
    let sprint: Session?
    let secondPractice: Session?
    let thirdPractice: Session?

    enum CodingKeys: String, CodingKey {
        case round
        case raceName
        case circuit = "Circuit"
        case date
        case time
        case firstPractice = "FirstPractice"
        case qualifying = "Qualifying"
        case sprint = "Sprint"
        case secondPractice = "SecondPractice"
        case thirdPractice = "ThirdPractice"
    }
}

struct Circuit: Codable {
    let circuitId: String
    let circuitName: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case circuitId
        case circuitName
        case location = "Location"
    }
}

struct Location: Codable {
    let locality: String
    let country: String
}

struct Session: Codable {
    let date: String
    let time: String?
}
