//
//  SchoolScheduleApp.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/23/22.
//

import SwiftUI

@main
struct SchoolScheduleApp: App {
    @StateObject var periodViewModel = PeriodViewModel()
    
    var body: some Scene {
        
        
        WindowGroup {
            MainView()
                .environmentObject(periodViewModel)
                .preferredColorScheme(.dark)
        }
    }
}
