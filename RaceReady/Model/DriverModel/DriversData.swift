//
//  DriversData.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 12.07.24.
//

import Foundation
import SwiftUI

struct DriversData {
    var driverCode: String
    var driverImage: String
}

class DriverInfo: ObservableObject {
    @Published var driverInfo: [DriversData] = [
        DriversData(driverCode: "VER", driverImage: "image"),
        DriversData(driverCode: "SAI", driverImage: "carlos"),
        DriversData(driverCode: "HAM", driverImage: "ham"),
        DriversData(driverCode: "NOR", driverImage: "lando"),
        DriversData(driverCode: "LEC", driverImage: "lec"),
        DriversData(driverCode: "PIA", driverImage: "oskar"),
        DriversData(driverCode: "PER", driverImage: "perez"),
        DriversData(driverCode: "RUS", driverImage: "rusel")
    ]
}
