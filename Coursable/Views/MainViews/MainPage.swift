//
//  SecondaryMain.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        ZStack {
            MainPage_FirstLayerView()
            SlideUpView()
                .ignoresSafeArea() //remove the extra space from navigation bar
        }

        

    }
}

struct SecondaryMain_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
            .environmentObject(PeriodViewModel())
    }
}
