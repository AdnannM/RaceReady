//
//  MainTabbedView+Extension.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 29.06.24.
//

import Foundation
import SwiftUI

extension MainTabbedView{
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View{
        HStack(spacing: 10){
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
                
            if isActive{
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? .indigo.opacity(0.4) : .clear)
        .cornerRadius(30)
    }
}
