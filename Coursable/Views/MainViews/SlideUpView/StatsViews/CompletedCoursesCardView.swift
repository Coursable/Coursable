//
//  CompletedCoursesCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/14/22.
//

import SwiftUI

struct CompletedCoursesCardView: View {
    
    var numberOfCoursesCompleted: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("\(numberOfCoursesCompleted)")
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
            .font(.title2)
            .fontWeight(.bold)
            
            Text("Completed")
                .foregroundColor(.secondary)
            
        }
    }
}

struct CompletedCoursesCardView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedCoursesCardView(numberOfCoursesCompleted: 3)
    }
}
