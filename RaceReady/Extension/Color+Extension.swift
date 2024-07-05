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
