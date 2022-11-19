//
//  ProgressRingView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct ProgressRingView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        ProgressRing(progress: periodViewModel.currentProgressInPeriod, ringColor: .bluePink, showMoveAnimation: periodViewModel.showRingMoveAnimation)
            .frame(width: UIScreen.main.bounds.width*0.85)
                .padding()
                .padding(.top)

    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView()
            .environmentObject(PeriodViewModel())
    }
}
