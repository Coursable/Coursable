//
//  NextEventProgressText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct NextEventProgressText: View {
    
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        VStack {
            Text("Next Event In:")
                .modifier(SubTextProgress())
            Text(periodViewModel.passingTime.asString())
                .modifier(PeriodTextProgress(scaleEffect: 1.2))
        }
    }
}

struct NextEventProgressText_Previews: PreviewProvider {
    static var previews: some View {
        NextEventProgressText()
            .environmentObject(PeriodViewModel())
    }
}
