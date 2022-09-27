//
//  ProgressTextNew.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/27/22.
//

import SwiftUI

struct ProgressText: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        switch(periodViewModel.getScheduleInfo()) {
        case .CurrentEvent:
            CurrentEventProgressText()
        case .NextEvent:
            NextEventProgressText()
        case .NoEventsToday:
            NoEventsProgressText()
        default:
            NoMoreEventsProgressText()
            
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
