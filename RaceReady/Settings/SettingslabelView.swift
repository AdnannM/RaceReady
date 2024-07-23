//
//  SettingslabelView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 23.07.24.
//

import SwiftUI

struct SettingslabelView: View {
    
    var labelText: String
    var image: String
    
    var body: some View {
        HStack {
            Text(labelText.uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: image)
        }
    }
}

#Preview {
    SettingslabelView(labelText: "RaceReady", image: "info.circle")
}
