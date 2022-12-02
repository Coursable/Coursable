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
            .fill(LinearGradient(colors: [Color(red: period.subject.colorGradientPrimary[0]/255, green: period.subject.colorGradientPrimary[1]/255, blue: period.subject.colorGradientPrimary[2]/255), Color(red: period.subject.colorGradientSecondary[0]/255, green: period.subject.colorGradientSecondary[1]/255, blue: period.subject.colorGradientSecondary[2]/255)], startPoint: .topLeading, endPoint: .bottomTrailing))

            .frame(width: 50)
       
        
            .overlay {
                
                
                Text(period.subject.name.prefix(1).capitalized)
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
