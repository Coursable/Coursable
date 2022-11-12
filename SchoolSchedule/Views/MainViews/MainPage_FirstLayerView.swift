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
        NavigationView {
            ZStack {
                
                Color("Background")
                    .ignoresSafeArea()
                
                VStack {
                    TopbarText()
                    
                    ProgressRingView()
                    
                    Spacer()

                    
                }
                .foregroundColor(.white)
            }
        
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage_FirstLayerView()
            .environmentObject(PeriodViewModel())
    }
}
