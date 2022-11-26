//
//  CourseIconView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/12/22.
//

import SwiftUI

struct CourseIconView: View {
    
    var period: PeriodModel
    
    var body: some View {
        Circle()
            .fill(period.subject.color)
            .frame(width: 50)
            .overlay {
                Text(period.subject.name.prefix(1))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }
    }
}

struct CourseIconView_Previews: PreviewProvider {
    static var previews: some View {
        CourseIconView(period: PeriodModel.periodOneExample)
    }
}
