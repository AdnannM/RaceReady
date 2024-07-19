//
//  NewsView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        
            Section("LatestNews") {
                ScrollView(.horizontal) {
                    HStack {
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(.colorBlue)
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                            Text("News One")
                                .bold()
                            Text("AuthorOne")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        VStack(alignment: .leading) {
                            Rectangle()
                                .fill(.colorBlue)
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                            Text("News One")
                                .bold()
                            Text("AuthorOne")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
                Spacer()
                
                List {
                    Section("All News") {
                        Text("Article 1")
                            .frame(height: 100)
                        Text("Article 1")
                            .frame(height: 100)
                        Text("Article 1")
                            .frame(height: 100)
                        Text("Article 1")
                            .frame(height: 100)
                        Text("Article 1")
                            .frame(height: 100)
                        Text("Article 1")
                            .frame(height: 100)
                    }
                }
            }
    }
}

#Preview {
    NewsView()
}
