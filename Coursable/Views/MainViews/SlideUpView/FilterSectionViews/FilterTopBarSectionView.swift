//
//  FilterTopBarSectionView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/19/22.
//

import SwiftUI

struct FilterTopBarSectionView: View {
    
    @EnvironmentObject var periodViewModel: PeriodViewModel
    @Binding var hideCompletedCourses: Bool
    
    var body: some View {
        HStack {
            Text(hideCompletedCourses ? "Courses Remaining Today (\(periodViewModel.numberOfClassesToday - periodViewModel.completedClassesToday.count))" : "Courses Meeting Today (\(periodViewModel.numberOfClassesToday))")
            Spacer()
            CourseFilterMenuView(hideCompletedCourses: $hideCompletedCourses)
            .textCase(nil)
        }

    }
}

struct FilterTopBarSectionView_Previews: PreviewProvider {
    static var previews: some View {
        FilterTopBarSectionView(hideCompletedCourses: .constant(false))
            .environmentObject(PeriodViewModel())
    }
}
