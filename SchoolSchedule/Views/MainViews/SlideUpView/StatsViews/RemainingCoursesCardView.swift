//
//  RemainingCoursesCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/14/22.
//

import SwiftUI

struct RemainingCoursesCardView: View {
    var remainingCourses: Int
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("\(remainingCourses)")
                Spacer()
                Image(systemName: "book.closed.circle.fill")
                    .foregroundColor(.blue)
            }
            .font(.title2)
            .fontWeight(.bold)
            
            Text("Remaining")
                .foregroundColor(.secondary)
            
        }
    }
}

struct RemainingCoursesCardView_Previews: PreviewProvider {
    static var previews: some View {
        RemainingCoursesCardView(remainingCourses: 3)
    }
}
