//
//  DriversView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 13.07.24.
//

import SwiftUI

struct DriversView: View {
    
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 5)
                    
                    VStack(alignment: .leading) {
                        Text("Max")
                            .bold()
                            .font(.title3)
                            .foregroundStyle(.secondary)
                        Text("Verstappen")
                            .bold()
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Image("austria")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 50)
                }
                
                .padding(.top)
                
                Divider()
                
                HStack() {
                    Text("1")
                        .font(.custom("MarkerFelt", size: 50))
                        .bold()
                    
                    Image("lec")
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 0) {
                              Text("239")
                                  .font(.custom("MarkerFelt-Wide", size: 25))
                                  .bold()
                                  .background(
                                      GeometryReader { geometry in
                                          Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                                      }
                                  )
                              Text("PTS")
                                  .padding(3)
                                  .font(.custom("MarkerFelt-Wide", size: 13))
                                  .foregroundStyle(.secondary)
                                  .bold()
                                  .frame(minWidth: 0, maxWidth: .infinity)
                                  .background(Color("ColorBlue").opacity(0.8))
                                  .clipShape(RoundedRectangle(cornerRadius: 10))
                          }
                          .frame(width: 50) // Set a fixed width for demonstration
                          .onPreferenceChange(WidthPreferenceKey.self) { width in
                              print("Width of '239' text: \(width)")
                          }
                }
                .padding(.bottom, 10)
            }
        }
        .navigationTitle("Drivers")
        .navigationBarTitleDisplayMode(.large)
    }
}
#Preview {
    NavigationStack {
        DriversView()
    }
}
struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
