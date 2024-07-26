//
//  FlagImageView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 26.07.24.
//

import SwiftUI

struct FlagImageView: View {
    let flag: String?
    let colorScheme: ColorScheme
    
    var body: some View {
        if let flag = flag {
            Image(flag)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35)
                .shadow(color: colorScheme == .dark ? .white : .black, radius: 0.5)
        }
    }
}

