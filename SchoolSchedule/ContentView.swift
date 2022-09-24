//
//  ContentView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        VStack {
            Text(periodViewModel.currentPeriodModel.startTime)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PeriodViewModel())
    }
}
