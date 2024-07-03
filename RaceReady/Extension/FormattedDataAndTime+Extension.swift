//
//  FormattedDataAndTime+Extension.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 03.07.24.
//

import Foundation
import SwiftUI

extension String {
    func formattedDate(from format: String = "yyyy-MM-dd", to outputFormat: String = "dd MMM") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        }
        return self
    }
    
    func formattedTime(from format: String = "HH:mm:ssZ", to outputFormat: String = "h:mm a", use24HourFormat: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let time = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            dateFormatter.locale = Locale(identifier: use24HourFormat ? "en_GB" : "en_US_POSIX")
            return dateFormatter.string(from: time)
        }
        return self
    }
}
