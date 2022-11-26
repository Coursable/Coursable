//
//  StatsCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/17/22.
//

import SwiftUI

struct StatsCardView: View {
    
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    var body: some View {
        HStack {
            CompletedCoursesCardView(numberOfCoursesCompleted: periodViewModel.completedClassesToday.count)
                .padding()
                .modifier(StatsCardModifierView())
            RemainingCoursesCardView(remainingCourses: periodViewModel.numberOfClassesToday - periodViewModel.completedClassesToday.count)
                .padding()
                .modifier(StatsCardModifierView())
        }
    }
}

struct StatsCardView_Previews: PreviewProvider {
    static var previews: some View {
        StatsCardView()
            .environmentObject(PeriodViewModel())
    }
}
