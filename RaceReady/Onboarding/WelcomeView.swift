//
//  WelcomeView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 28.06.24.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 20) {
                    HStack() {
                        Spacer()
                        Text("Race Ready")
                            .fontWeight(.bold)
                            .font(.system(size: 45)).fontWeight(.heavy).gradientForeground(colors: [.red, .yellow])
                        
                        Spacer()
                    }
                    .padding(.top)
                    
                    // Use AsyncImage to load the image from a URL
                    AsyncImage(url: URL(string: "https://iraceready.com/wp-content/uploads/2023/06/scoringimageipad_White-1-1024x429.png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                       ProgressView()
                    }
                    .frame(width: 500, height: 200)
                    .clipped()
                    .padding(.horizontal, -20)
                    .padding(.top, 30)

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
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isPresented = true
                        }
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 280, height: 60)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(17)
                    }
                }
                .background(Color(UIColor.systemBackground))
                .cornerRadius(16)
                .padding()
            }
            .fullScreenCover(isPresented: $isPresented, content: {
                MainTabbedView()
                    .transition(.move(edge: .trailing))
            })
        }
        .animation(.easeInOut(duration: 0.5), value: isPresented)
    }
}

#Preview {
    WelcomeView().environmentObject(SeasonModel(webservice: WebService()))
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors), startPoint: .topLeading, endPoint: .topTrailing))
            .mask(self)
    }
}
