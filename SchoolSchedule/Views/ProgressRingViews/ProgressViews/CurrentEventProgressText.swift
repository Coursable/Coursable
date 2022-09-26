//
//  CurrentEventProgressText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct CurrentEventProgressText: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        VStack {
            Text("Event Ends In:")
                .modifier(SubTextProgress())
            Text(periodViewModel.currentTimeLeftInPeriod.asString())
                .modifier(PeriodTextProgress(scaleEffect: 1.2))
        }

    }
}

struct CurrentEventProgressText_Previews: PreviewProvider {
    static var previews: some View {
        CurrentEventProgressText()
            .environmentObject(PeriodViewModel())
    }
}
