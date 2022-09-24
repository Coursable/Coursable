//
//  MainView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/24/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel

    var body: some View {
        Text(periodViewModel.currentTime, format: .dateTime.year().day().month().hour().minute().second())
            .onReceive(periodViewModel.timer) { input in
                periodViewModel.updateTime(input: input)
            }
        
        
        if let todaysSchedule = periodViewModel.todaysSchedule {
            if let currentPeriodNumber = periodViewModel.currentPeriodNumber {
                
                
                if let period = todaysSchedule.periods.first(where: {$0.periodNumber == currentPeriodNumber}) {
                    Text(period.endTime)
                }
                else {
                    Text("No Periods Meeting Right Now")
                }

                //
            }
            else {
                Text("No Periods Meeting Right Now")
            }
        }
        else {
            Text("No Classes Today")
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PeriodViewModel())
    }
}
