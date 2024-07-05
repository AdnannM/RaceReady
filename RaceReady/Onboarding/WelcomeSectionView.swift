//
//  WelcomeSectionView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 05.07.24.
//

import SwiftUI

struct WelcomeSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: "calendar").resizable().frame(width: 50, height: 40).gradientForeground(colors: [.red, .orange])
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Season Overview").bold().font(.system(size: 22)).padding(.top, 10.0)
                    
                    Text("Details about each race in the season").font(.subheadline).padding(.bottom, 10.0)
                }
            }
            
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: "person.3.fill").resizable().frame(width: 50, height: 40).gradientForeground(colors: [.red, .orange])
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Driver & Team Standings").bold().font(.system(size: 22))
                    
                    Text("Track standings of drivers and teams").font(.subheadline).padding(.bottom, 10.0)
                }
            }
            
            HStack(alignment: .center, spacing: 20) {
                Image(systemName: "bell.fill").resizable().frame(width: 50, height: 50).gradientForeground(colors: [.red, .orange])
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Notifications & Widgets").bold().font(.system(size: 22))
                    
                    Text("Receive notifications and add widgets").font(.subheadline)
                }
            }
        }
    }
}
