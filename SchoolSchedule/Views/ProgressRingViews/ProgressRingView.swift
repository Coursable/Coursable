//
//  ProgressRingView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct ProgressRingView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    @State var showRingMoveAnimation: Bool = false
    
    var body: some View {
        ProgressRing(progress: periodViewModel.currentProgressInPeriod, ringColor: .bluePink, showMoveAnimation: showRingMoveAnimation)
                .frame(width: 300.0, height: 300.0)
                .padding()
                .padding(.top)
                .onReceive(periodViewModel.timer) { input in
                    periodViewModel.updateTime(input: input)
                    showRingMoveAnimation.toggle()
                }
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView()
            .environmentObject(PeriodViewModel())
    }
}
