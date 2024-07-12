//
//  DriversData.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 12.07.24.
//

import Foundation
import SwiftUI

struct DriversData {
    
    var driverImage: String
}

class DriverInfo: ObservableObject {
    
    @Published var driverInfo: [DriversData] = [
        DriversData(driverImage: "carlos"),
        DriversData(driverImage: "ham"),
        DriversData(driverImage: "image"),
        DriversData(driverImage: "lando"),
        DriversData(driverImage: "lec"),
        DriversData(driverImage: "oskar"),
        DriversData(driverImage: "perez"),
        DriversData(driverImage: "rusel")
    ]
}
