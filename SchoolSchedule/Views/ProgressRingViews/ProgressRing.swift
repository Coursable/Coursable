//
//  ProgressRing.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/24/22.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var progress: Double
    var ringColor: LinearGradient
    var showAnimation: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundStyle(ringColor)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(ringColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeOut, value: showAnimation)
            
            VStack {
                ProgressText()
                    .multilineTextAlignment(.center)
            }
            
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing(progress: 0.05, ringColor: .linearGradient(colors: [.blue, .pink], startPoint: .topLeading, endPoint: .bottomTrailing), showAnimation: false)
            .environmentObject(PeriodViewModel())
    }
}
