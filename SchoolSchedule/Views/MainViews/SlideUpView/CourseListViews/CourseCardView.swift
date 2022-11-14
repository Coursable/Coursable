//
//  CourseCardview.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/12/22.
//

import SwiftUI

struct CourseCardView: View {
    var period: PeriodModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CourseIconView(period: period)
                CourseInfoView(period: period)
                    .padding(.leading, 3)
            }
            CourseTimeInfoView(period: period)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray, lineWidth: 2)
                .opacity(0.2)

        }
        
    }
}

struct CourseCardview_Previews: PreviewProvider {
    static var previews: some View {
        CourseCardView(period: PeriodModel.periodOneExample)
    }
}
