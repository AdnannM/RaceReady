//
//  RaceDetailView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 01.07.24.
//

import SwiftUI

struct RaceDetailView: View {
    let race: Race
    
    var body: some View {
        VStack(spacing: 25) {
            Image(race.circuitImage ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 450)
            
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("First Grand")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        
                    Text("1996")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                }
                .padding()
                .frame(width: 170, alignment: .topLeading)
                .overlay (
                    BottomRightRoundedBorder()
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                .overlay (
                    BottomRightRoundedBorder()
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Number of Laps")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("55")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()
                .frame(width: 170, alignment: .topLeading)
                .overlay (
                    BottomRightRoundedBorder()
                        .stroke(Color.gray, lineWidth: 1)
                )
                .overlay (
                    BottomRightRoundedBorder()
                        .stroke(Color.gray, lineWidth: 1)
                )
                
            }
            
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("First Grand")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        
                    Text("1996")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                }
                .padding()
                .frame(width: 170, alignment: .topLeading)
                .overlay (
                    BottomRightRoundedBorder()
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                .overlay (
                    BottomRightRoundedBorder()
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Number of Laps")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("55")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .padding()
                .frame(width: 170, alignment: .topLeading)
                .overlay (
                    BottomRightRoundedBorder()
                        .stroke(Color.gray, lineWidth: 1)
                )
                .overlay (
                    BottomRightRoundedBorder()
                        .stroke(Color.gray, lineWidth: 1)
                )
                
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(race.raceName)
    }
}

#Preview {
    let sampleRace = Race(
        round: "1",
        raceName: "Sample Race",
        circuit: Circuit(circuitId: "sampleCircuit", circuitName: "Sample Circuit", location: Location(locality: "Sample City", country: "Sample Country")),
        date: "2024-07-19",
        time: "12:00:00Z",
        firstPractice: Session(date: "2024-07-18", time: "10:00:00Z"),
        qualifying: Session(date: "2024-07-19", time: "14:00:00Z"),
        sprint: nil,
        secondPractice: nil,
        thirdPractice: nil,
        circuitId: nil,
        circuitImage: "hungaryCircuit"
    )
    return RaceDetailView(race: sampleRace).environmentObject(SeasonModel(webservice: WebService()))
}


struct BottomRightRoundedBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 8
        path.move(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - radius))
        path.addArc(center: CGPoint(x: rect.width - radius, y: rect.height - radius), radius: radius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: radius, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}
