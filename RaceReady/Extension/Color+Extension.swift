//
//  Color+Extension.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 05.07.24.
//

import Foundation
import SwiftUI

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: .topLeading, endPoint: .topTrailing))
            .mask(self)
    }
}


extension Color {
    static let williams = Color(red: 0.39, green: 0.77, blue: 1.00)
    static let mercedes = Color(red: 39/255.0, green: 244/255.0, blue: 210/255.0)
    static let astonMartin = Color(red: 0.13, green: 0.60, blue: 0.44)
    static let haas = Color(red: 0.71, green: 0.73, blue: 0.74)
    static let rb = Color(red: 0.40, green: 0.57, blue: 1.00)
    static let alpine = Color(red: 0.00, green: 0.58, blue: 0.80)
    static let sauber = Color(red: 0.32, green: 0.89, blue: 0.32)
    static let mclaren = Color(red: 1.00, green: 0.50, blue: 0.00)
    static let ferrari = Color(red: 0.91, green: 0.00, blue: 0.13)
    static let redBull = Color(red: 0.21, green: 0.44, blue: 0.78)
}
