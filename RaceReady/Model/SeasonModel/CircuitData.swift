//
//  CircuitData.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 02.07.24.
//

import Foundation
import SwiftUI

struct CircuitData {
    
    var id: Int
    var circuitImage: String
    var countryFlag: String
    var firstGp: Int
    var numberOfLaps: Int
    var circuitLenght: Double
    var raceDistance: Double
    
}

class CircuitInfo: ObservableObject {
    
    @Published var circuitInfo: [CircuitData] = [
        
        CircuitData(id: 1, circuitImage: "bahreinCircuit", countryFlag: "bahrein", firstGp: 2024, numberOfLaps: 57, circuitLenght: 5.412, raceDistance: 308.238),
        CircuitData(id: 2, circuitImage: "saudiCircuit", countryFlag: "saudi", firstGp: 2021, numberOfLaps: 50, circuitLenght: 6.174, raceDistance: 308.45),
        CircuitData(id: 3, circuitImage: "austriaCircuit", countryFlag: "australia", firstGp: 1996, numberOfLaps: 58, circuitLenght: 5.278, raceDistance: 306.124),
        CircuitData(id: 4, circuitImage: "japanCircuit", countryFlag: "japan", firstGp: 1987, numberOfLaps: 53, circuitLenght: 5.807, raceDistance: 307.471),
        CircuitData(id: 5, circuitImage: "chinaCircuit", countryFlag: "china", firstGp: 2004, numberOfLaps: 56, circuitLenght: 5.451, raceDistance: 305.066),
        CircuitData(id: 6, circuitImage: "miamiCircuit", countryFlag: "usa", firstGp: 2022, numberOfLaps: 57, circuitLenght: 5.412, raceDistance: 308.326),
        CircuitData(id: 7, circuitImage: "emiliaRomagnaCircuit", countryFlag: "italy", firstGp: 1980, numberOfLaps: 63, circuitLenght: 4.909, raceDistance: 309.049),
        CircuitData(id: 8, circuitImage: "monacoCircuit", countryFlag: "monaco", firstGp: 1950, numberOfLaps: 78, circuitLenght: 3.337, raceDistance: 260.286),
        CircuitData(id: 9, circuitImage: "canadaCircuit", countryFlag: "canada", firstGp: 1978, numberOfLaps: 70, circuitLenght: 4.361, raceDistance: 305.27),
        CircuitData(id: 10, circuitImage: "spainCircuit", countryFlag: "spain", firstGp: 1991, numberOfLaps: 66, circuitLenght: 4.657, raceDistance: 307.236),
        CircuitData(id: 11, circuitImage: "austriaCircuit", countryFlag: "austria", firstGp: 1970, numberOfLaps: 71, circuitLenght: 4.318, raceDistance: 306.452),
        CircuitData(id: 12, circuitImage: "silverstonCircuit", countryFlag: "uk", firstGp: 1950, numberOfLaps: 52, circuitLenght: 5.891, raceDistance: 306.198),
        CircuitData(id: 13, circuitImage: "hungaryCircuit", countryFlag: "hungary", firstGp: 1986, numberOfLaps: 70, circuitLenght: 4.381, raceDistance: 306.63),
        CircuitData(id: 14, circuitImage: "spaCircuit", countryFlag: "belgium", firstGp: 1950, numberOfLaps: 44, circuitLenght: 7.004, raceDistance: 308.052),
        CircuitData(id: 15, circuitImage: "dutchCircuit", countryFlag: "nedherlands", firstGp: 1952, numberOfLaps: 72, circuitLenght: 4.259, raceDistance: 306.587),
        CircuitData(id: 16, circuitImage: "italyCircuit", countryFlag: "italy", firstGp: 1950, numberOfLaps: 53, circuitLenght: 5.793, raceDistance: 306.72),
        CircuitData(id: 17, circuitImage: "azerbaijanCircuit", countryFlag: "azarbaijan", firstGp: 2016, numberOfLaps: 51, circuitLenght: 6.003, raceDistance: 306.049),
        CircuitData(id: 18, circuitImage: "singaporeCircuit", countryFlag: "singapore", firstGp: 2008, numberOfLaps: 62, circuitLenght: 4.94, raceDistance: 306.143),
        CircuitData(id: 19, circuitImage: "usaCircuit", countryFlag: "usa", firstGp: 2012, numberOfLaps: 56, circuitLenght: 5.513, raceDistance: 308.405),
        CircuitData(id: 20, circuitImage: "mexicoCircuit", countryFlag: "mexico", firstGp: 1963, numberOfLaps: 71, circuitLenght: 4.304, raceDistance: 305.354),
        CircuitData(id: 21, circuitImage: "brazilCircuit", countryFlag: "brazil", firstGp: 1973, numberOfLaps: 71, circuitLenght: 4.309, raceDistance: 305.879),
        CircuitData(id: 22, circuitImage: "lasVegasCircuit", countryFlag: "usa", firstGp: 2023, numberOfLaps: 50, circuitLenght: 6.201, raceDistance: 309.958),
        CircuitData(id: 23, circuitImage: "quatarCircuit", countryFlag: "qatar", firstGp: 2021, numberOfLaps: 57, circuitLenght: 5.419, raceDistance: 308.611),
        CircuitData(id: 24, circuitImage: "abuDhabiCircuit", countryFlag: "uae", firstGp: 2009, numberOfLaps: 58, circuitLenght: 5.281, raceDistance: 306.183)
    ]
    
    func getCircuitInfo(by id: Int) -> CircuitData? {
        return circuitInfo.first { $0.id == id }
    }
}
