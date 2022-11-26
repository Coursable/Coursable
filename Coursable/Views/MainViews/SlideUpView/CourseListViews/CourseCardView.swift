//
//  CourseCardview.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/12/22.
//

import SwiftUI

struct CourseCardView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    var period: PeriodModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                HStack {
                    CourseIconView(period: period)
                    CourseInfoView(period: period)
                        .padding(.leading, 3)
                }
                Spacer()
                if let currentPeriodNumber = periodViewModel.currentPeriodNumber {
                    if currentPeriodNumber == period.periodNumber {
                        Text("In Progress")
                            .font(.footnote)
                            .padding([.leading,.trailing], 10)
                            .padding([.top, .bottom], 4)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .background {
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundColor(.blue)
                                    
                            }
                    }
                    
                }
                
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
            .environmentObject(PeriodViewModel())
    }
}
