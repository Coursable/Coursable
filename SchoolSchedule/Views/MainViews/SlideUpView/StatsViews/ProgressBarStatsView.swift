//
//  ProgressBarStatsView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/17/22.
//

import SwiftUI

struct ProgressBarStatsView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            DayProgressBarView(value: Float(periodViewModel.currentDayCompletedPercentage)).frame(height: 20)
            Text(String(format: "%g", floor(periodViewModel.currentDayCompletedPercentage*100)) + "% Done With The Day")
                .fontWeight(.bold)
                .font(.headline)
                .foregroundColor(.secondary)
                
        }
    }
}

struct ProgressBarStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarStatsView()
            .environmentObject(PeriodViewModel())
    }
}
