//
//  CourseInfoView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/13/22.
//

import SwiftUI

struct CourseInfoView: View {
    var period: PeriodModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(period.subject.name)
                .font(.title3)
                .fontWeight(.semibold)
            Text(period.subject.teacher)
                .foregroundColor(.secondary)
                .font(.subheadline)
            
        }
    }
}

struct CourseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CourseInfoView(period: PeriodModel.periodOneExample)
    }
}
