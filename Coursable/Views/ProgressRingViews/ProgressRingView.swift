//
//  ProgressRingView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct ProgressRingView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    var screenWidth: CGFloat
    
    var body: some View {
        ProgressRing(progress: periodViewModel.currentProgressInPeriod, ringColor: .bluePink, showMoveAnimation: periodViewModel.showRingMoveAnimation)
            .frame(maxWidth: screenWidth*0.85)
                
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView(screenWidth: 1000)
            .environmentObject(PeriodViewModel())
    }
}

private struct ProgressRing: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var progress: Double
    var ringColor: LinearGradient = .bluePink
    var showMoveAnimation: Bool
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundStyle(.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(ringColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeOut, value: showMoveAnimation)
            
            VStack {
                ProgressText()
                    .multilineTextAlignment(.center)
            }
            
        }
    }
}
