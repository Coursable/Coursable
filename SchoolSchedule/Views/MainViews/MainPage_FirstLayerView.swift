//
//  MainView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/24/22.
//

import SwiftUI

struct MainPage_FirstLayerView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        //NavigationView {
            VStack {
                
                HStack {
                    Spacer()
                    TopbarText()
                        .foregroundColor(.white)
                    Spacer()
                }

                
                ProgressRingView()
                    .onReceive(periodViewModel.timer) { input in
                        periodViewModel.updateTime(input: input)
                    }
                Spacer()
                
                

                
            }
            .foregroundColor(.white)
            .background(Color("Background"))
            
        //}

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage_FirstLayerView()
            .environmentObject(PeriodViewModel())
    }
}
