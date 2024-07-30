//
//  DriversImages.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 16.07.24.
//

import Foundation

struct DriversImages {
    var driverImage: String
    var driverCountryImage: String
}


class DriversInfoImages: ObservableObject {
    
    @Published var driversImages: [DriversImages] = [
        DriversImages(driverImage: "albon", driverCountryImage: "thailand"),
        DriversImages(driverImage: "alonso", driverCountryImage: "spain"),
        DriversImages(driverImage: "bottas", driverCountryImage: "finland"),
        DriversImages(driverImage: "gasly", driverCountryImage: "france"),
        DriversImages(driverImage: "russell", driverCountryImage: "uk"),
        DriversImages(driverImage: "kevin", driverCountryImage: "denmark"),
        DriversImages(driverImage: "hamilton", driverCountryImage: "uk"),
        DriversImages(driverImage: "sargeant", driverCountryImage: "usa"),
        DriversImages(driverImage: "max", driverCountryImage: "nedherlands"),
        DriversImages(driverImage: "leclerc", driverCountryImage: "monaco"),
        DriversImages(driverImage: "hülkenberg", driverCountryImage: "germany"),
        DriversImages(driverImage: "norris", driverCountryImage: "uk"),
        DriversImages(driverImage: "ocon", driverCountryImage: "france"),
        DriversImages(driverImage: "bearman", driverCountryImage: "uk"),
        DriversImages(driverImage: "piastri", driverCountryImage: "australia"),
        DriversImages(driverImage: "ricciardo", driverCountryImage: "australia"),
        DriversImages(driverImage: "sainz", driverCountryImage: "spain"),
        DriversImages(driverImage: "pérez", driverCountryImage: "mexico"),
        DriversImages(driverImage: "stroll", driverCountryImage: "canada"),
        DriversImages(driverImage: "tsunoda", driverCountryImage: "japan"),
        DriversImages(driverImage: "zhou", driverCountryImage: "china")
    ]
    
    /// Normalize the driver IDs and the images’ names to remove diacritics (accent marks). This can be done using the folding method in Swift to compare strings without considering diacritics.
    func normalize(_ string: String) -> String {
        return string.folding(options: .diacriticInsensitive, locale: .current).lowercased()
    }
    
    func findImages(for driverId: String) -> DriversImages? {
        let normalizedDriverId = normalize(driverId)
        return driversImages.first {
            normalize($0.driverImage).contains(normalizedDriverId) ||
            normalizedDriverId.contains(normalize($0.driverImage))
        }
    }
}
