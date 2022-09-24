//
//  ProgressText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/24/22.
//

import SwiftUI

struct ProgressText: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        if let todaysSchedule = periodViewModel.todaysSchedule {
            if let currentPeriodNumber = periodViewModel.currentPeriodNumber {
                
                
                if let period = todaysSchedule.periods.first(where: {$0.periodNumber == currentPeriodNumber}) {
                    Text("Class Ends In: \n" + periodViewModel.currentTimeLeftInPeriod.asString())
                        .modifier(PeriodTextProgress())
                }
                else {
                    if periodViewModel.nextPeriod != nil {
                        Text("Next Class In: \n" + periodViewModel.passingTime.asString())
                            .modifier(PeriodTextProgress())
                    }
                    else {
                        Text("Day Finished!")
                            .modifier(PeriodTextProgress())
                    }

                }
            }
            else {
                if periodViewModel.nextPeriod != nil {
                    Text("Next Class In: \n" + periodViewModel.passingTime.asString())
                        .modifier(PeriodTextProgress())
                }
                else {
                    Text("Day Finished!")
                        .modifier(PeriodTextProgress())
                }
            }
        }
        else {
            Text("No Classes Today!")
                .modifier(PeriodTextProgress())
        }
    }
}

struct ProgressText_Previews: PreviewProvider {
    static var previews: some View {
        ProgressText()
            .environmentObject(PeriodViewModel())
    }
}

struct PeriodTextProgress: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .rounded))
            .fontWeight(.semibold)
    }
}
