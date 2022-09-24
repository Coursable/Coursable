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
        }
        
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PeriodViewModel())
    }
}
