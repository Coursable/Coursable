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
                    VStack {
                        Text("Event Ends In:")
                            .modifier(SubTextProgress())
                        Text(periodViewModel.currentTimeLeftInPeriod.asString())
                            .modifier(PeriodTextProgress(scaleEffect: 1.2))
                    }

                        
                }
                else {
                    if periodViewModel.nextPeriod != nil {
                        VStack {
                            Text("Next Event In:")
                                .modifier(SubTextProgress())
                            Text(periodViewModel.passingTime.asString())
                                .modifier(PeriodTextProgress(scaleEffect: 1.2))
                        }
                    }
                    else {
                        //Day Completed
                        Text("No More \nEvents Today")
                            .modifier(SubTextProgress(fontWeight: .heavy, font: .title))
                    }

                }
            }
            else {
                if periodViewModel.nextPeriod != nil {
                    VStack {
                        Text("Next Event In:")
                            .modifier(SubTextProgress())
                        Text(periodViewModel.passingTime.asString())
                            .modifier(PeriodTextProgress(scaleEffect: 1.2))
                    }
                    
                }
                else {
                    //Day Completed
                    Text("No More \nEvents Today")
                        .modifier(SubTextProgress(fontWeight: .heavy, font: .title))
                }
            }
        }
        else {
            //Day Completed
            Text("No Events \nToday")
                .modifier(SubTextProgress(fontWeight: .heavy, font: .title))
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
    
    var scaleEffect: Double = 1
    
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle))
            .scaleEffect(scaleEffect)
            .fontWeight(.heavy)
    }
}
struct SubTextProgress: ViewModifier {
    
    var fontWeight: Font.Weight = .semibold
    var font: Font = .title2
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
            
    }
}


