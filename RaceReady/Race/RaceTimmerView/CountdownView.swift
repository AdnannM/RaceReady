//
//  CountdownView.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 09.07.24.
//

import SwiftUI

struct CountdownView: View {
    @ObservedObject var viewModel: CountdownViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            TimeUnitView(value: viewModel.days, unit: "DAYS")
            
            Divider()
            
            TimeUnitView(value: viewModel.hours, unit: "HRS")
            
            Divider()
            
            TimeUnitView(value: viewModel.minutes, unit: "MINS")
        }
    }
}
