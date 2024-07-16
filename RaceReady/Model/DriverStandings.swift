//
//  DriverStandingsData.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 16.07.24.
//

import Foundation

struct DriverStandings: Codable {
    let driverMRdata: DriverMRData
}

struct DriverMRData: Codable {
    let StandingsTable: StandingsTable
}

struct StandingsTable: Codable {
    let StandingsLists: [StandingsList]
}

struct StandingsList: Codable {
    let DriverStandings: [DriverStanding]
}

struct DriverStanding: Codable {
    let position: String
    let points: String
    let wins: String
    let Driver: DriverData
    let Constructors: [ConstructorData]
}

struct DriverData: Codable {
    let permanentNumber: String
    let givenName: String
    let familyName: String
}

struct ConstructorData: Codable {
    let constructorId: String
    let name: String
}
