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
            if periodViewModel.completedClassesToday.count == 0 && periodViewModel.numberOfClassesToday == 0 {
                DayProgressBarView(value: 0).frame(height: 20)
                Text("No Classes Today")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            else {
                DayProgressBarView(value: Float(Double(periodViewModel.completedClassesToday.count)/Double(periodViewModel.numberOfClassesToday))).frame(height: 20)
                Text(String(format: "%g", floor(Float(Double(periodViewModel.completedClassesToday.count)/Double(periodViewModel.numberOfClassesToday))*100)) + "% Done With The Day")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
                
        }
    }
}

struct ProgressBarStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarStatsView()
            .environmentObject(PeriodViewModel())
    }
}
