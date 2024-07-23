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
                    
                    GroupBox(
                        label: SettingslabelView(labelText: "Social Media", image: "apps.iphone")
                    ){
                        SettingsRowView(name: "Insagram", linkLabel: "@RaceReady", linkDestination: "https://www.google.com")
                        SettingsRowView(name: "Twitter", linkLabel: "@RaceReady", linkDestination: "https://www.google.com")
                        SettingsRowView(name: "YouTube", linkLabel: "@RaceReady", linkDestination: "https://www.google.com")
                        SettingsRowView(name: "Facebook", linkLabel: "@RaceReady", linkDestination: "https://www.google.com")
                    }
                    
                    GroupBox(
                        label: SettingslabelView(labelText: "Application", image: "iphone")
                    ) {
                        SettingsRowView(name: "Developer", content: "Adnan Muratovic")
                        SettingsRowView(name: "Compatibility", content: "iOS 15")
                        SettingsRowView(name: "Webiste", linkLabel: "Race Ready", linkDestination: "https://www.google.com")
                        SettingsRowView(name: "Privacy Policy", linkLabel: "Race Ready", linkDestination: "https://www.google.com")
                        SettingsRowView(name: "Terms and Conditions", linkLabel: "Race Ready", linkDestination: "https://www.google.com")
                        SettingsRowView(name: "SwiftUI", content: "2.0")
                        SettingsRowView(name: "Version", content: "1.0.1")
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
