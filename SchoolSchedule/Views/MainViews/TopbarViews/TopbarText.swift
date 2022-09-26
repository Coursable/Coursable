//
//  TopbarText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct TopbarText: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            if let todaysSchedule = periodViewModel.todaysSchedule {
                if let currentPeriodNumber = periodViewModel.currentPeriodNumber {
                    
                    
                    if let period = todaysSchedule.periods.first(where: {$0.periodNumber == currentPeriodNumber}) {
                        CurrentEventTopbarText(periodModel: period)

                            
                    }
                    else {
                        if let nextPeriodCheck = periodViewModel.nextPeriod {
                            NextEventTopbarText(periodModel: nextPeriodCheck)
                        }
                        else {
                            //Day Completed
                            NoMoreEventsTopbarText()
                        }

                    }
                }
                else {
                    if let nextPeriodCheck = periodViewModel.nextPeriod {
                        NextEventTopbarText(periodModel: nextPeriodCheck)
                    }
                    else {
                        //Day Completed
                        NoMoreEventsTopbarText()
                    }
                }
            }
            else {
                //Day Completed
                NoEventsTopbarText()
            }

        }
    }
}

struct TopbarText_Previews: PreviewProvider {
    static var previews: some View {
        TopbarText()
            .environmentObject(PeriodViewModel())
    }
}
