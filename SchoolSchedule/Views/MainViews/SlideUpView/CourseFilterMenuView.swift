//
//  CourseFilterMenuView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/17/22.
//

import SwiftUI

struct CourseFilterMenuView: View {
    @Binding var hideCompletedCourses: Bool
    
    var body: some View {
        Menu {
            Button("Display All Courses", action: {
                withAnimation {
                    hideCompletedCourses = false
                }
            })
            Button("Hide Completed Courses", action: {
                withAnimation {
                    hideCompletedCourses = true
                }
                
            })
        } label: {
            Image(systemName: "ellipsis")
        }
    }
}

struct CourseFilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        CourseFilterMenuView(hideCompletedCourses: .constant(false))
    }
}
