//
//  MainView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/24/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel

    @State var showAnimation: Bool = false
    @State var ringColor: Color = .accentColor
    
    var body: some View {
        VStack {
            ProgressRing(progress: periodViewModel.currentProgressInPeriod, ringColor: .accentColor, showAnimation: showAnimation)
                .frame(width: 300.0, height: 300.0)
                .padding()
            Spacer()
            
            Text(periodViewModel.currentTime, format: .dateTime.year().day().month().hour().minute().second())
                .onReceive(periodViewModel.timer) { input in
                    periodViewModel.updateTime(input: input)
                    showAnimation.toggle()
                }
            
            
            if let todaysSchedule = periodViewModel.todaysSchedule {
                if let currentPeriodNumber = periodViewModel.currentPeriodNumber {
                    
                    
                    if let period = todaysSchedule.periods.first(where: {$0.periodNumber == currentPeriodNumber}) {
                        Text(period.endTime)
                        Text(String(periodViewModel.currentTimeLeftInPeriod.asString(style: .positional)))
                    }
                    else {
                        if periodViewModel.nextPeriod != nil {
                            Text("No Periods Meeting Right Now")
                            Text("Next period starting in: " + String(periodViewModel.passingTime.asString(style: .positional)))
                        }
                        else {
                            Text("No More Periods Meeting Today")
                        }

                    }
                }
                else {
                    if periodViewModel.nextPeriod != nil {
                        Text("No Periods Meeting Right Now")
                        Text("Next period starting in: " + String(periodViewModel.passingTime.asString(style: .positional)))
                    }
                    else {
                        Text("No More Periods Meeting Today")
                    }
                }
            }
            else {
                Text("No Classes Today")
            }
        }
        
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PeriodViewModel())
    }
}
