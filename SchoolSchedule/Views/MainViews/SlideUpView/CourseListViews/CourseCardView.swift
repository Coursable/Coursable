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
            HStack(alignment: .top) {
                CourseIconView(period: period)
                VStack(alignment: .leading) {
                    Text(period.subject.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(period.subject.teacher)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    
                }
                .padding(.leading, 3)
                
                
            }
            .padding([.top, .leading, .trailing])
            .padding(.bottom, 10)
            
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
            
            .padding([.leading, .bottom, .trailing])
            .font(.subheadline)
            
            
            
        
        }
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
