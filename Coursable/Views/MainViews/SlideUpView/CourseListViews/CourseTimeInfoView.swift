//
//  CourseTimeInfoView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/13/22.
//

import SwiftUI

struct CourseTimeInfoView: View {
    var period: PeriodModel
    
    var body: some View {
        HStack {
            Image(systemName: "clock")
                .foregroundColor(.secondary)
            Text("\(DateFormatter.localizedString(from: period.startTimeParsed, dateStyle: .none, timeStyle: .short))-\(DateFormatter.localizedString(from: period.endTimeParsed, dateStyle: .none, timeStyle: .short))")
                .foregroundColor(.secondary)
            Spacer()
            Image(systemName: "book")
                .foregroundColor(.secondary)
            Text("Period \(period.periodNumber)")
                .foregroundColor(.secondary)
                
        }
    }
}

struct CourseTimeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CourseTimeInfoView(period: PeriodModel.periodOneExample)
    }
}
