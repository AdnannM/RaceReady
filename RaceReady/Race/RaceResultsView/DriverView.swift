//
//  DriversView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 12.07.24.
//

import SwiftUI

struct DriverView: View {
    let driverCode: String
    let constructorName: String
    let driverImageName: String?
    let backgroundColor: Color
    let frameHeight: CGFloat
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text(driverCode)
                    .font(.system(size: 29))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .background(backgroundColor)
                    .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
            .frame(width: 110, height: frameHeight)
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Color.gray)
            }
            .padding()
            
            if let imageName = driverImageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 120)
                    .padding(.top, -180)
            }
        }
    }
}
