//
//  SecondaryMain.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                MainPage_FirstLayerView()
                SlideUpView()
            }
        }
    }
}

struct SecondaryMain_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(PeriodViewModel())
    }
}
