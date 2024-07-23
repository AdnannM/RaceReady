//
//  SettingsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 23.07.24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    GroupBox(
                        label:
                           SettingslabelView(labelText: "ReceReady", image: "info.circle")
                    ) {
                        Divider().padding(.vertical, 4)
                        
                        HStack(alignment: .center, spacing: 10) {
                            Image("lunchScreen")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90, height: 90)
                                .clipShape(.buttonBorder)
                            
                            Text("Welcome to the F1 Companion App! Stay updated with the latest driver standings, race results, and team details.Dive into the world of F1 with ease and stay connected to the action!")
                                .font(.footnote)
                        }
                    }
                }
                .navigationBarTitle(Text("Settings"), displayMode: .large)
                .padding()
            }
        }
    }
}

#Preview {
    SettingsView()
}
