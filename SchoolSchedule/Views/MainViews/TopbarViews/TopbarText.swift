//
//  TopbarTextNew.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/27/22.
//

import SwiftUI

struct TopbarText: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            switch(periodViewModel.getScheduleInfo()) {
            case .CurrentEvent:
                if let period =  try? periodViewModel.getCurrentPeriod() {
                    CurrentEventTopbarText(periodModel: period)
                }
                
            case .NextEvent:
                if let nextPeriod = periodViewModel.nextPeriod {
                    NextEventTopbarText(periodModel: nextPeriod)
                }
            case .NoEventsToday:
                NoEventsTopbarText()
            default:
                NoMoreEventsTopbarText()
                
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
