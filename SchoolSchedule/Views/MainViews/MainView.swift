//
//  MainView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/24/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel

    @State var showRingMoveAnimation: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VStack {
                    TopbarText()
                    
                    ProgressRing(progress: periodViewModel.currentProgressInPeriod, ringColor: .bluePink, showMoveAnimation: showRingMoveAnimation)
                            .frame(width: 300.0, height: 300.0)
                            .padding()
                            .padding(.top)
                            .onReceive(periodViewModel.timer) { input in
                                periodViewModel.updateTime(input: input)
                                showRingMoveAnimation.toggle()
                            }
                    
                    Spacer()
                }
                .foregroundColor(.white)
                
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
