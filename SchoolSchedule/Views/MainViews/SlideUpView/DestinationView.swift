//
//  NavBarTest.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/19/22.
//

import SwiftUI

struct DestinationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var periodModel: PeriodModel
    
    var body: some View {
        VStack {
            TopNavBar {
                VStack {
                    Text(periodModel.subject.name)
                        .font(.title3.weight(.semibold))
                    
                    HStack(spacing: 2) {
                        Text(periodModel.startTimeParsed, format: .dateTime.hour().minute())
                        Text("-")
                        Text(periodModel.endTimeParsed, format: .dateTime.hour().minute())
                        Text(" ")
                        Text("Room " + periodModel.subject.roomNumber)
                    }
                    .font(.subheadline.weight(.semibold))     
                }
                .foregroundColor(.white)
            }
            
            Spacer()
        }
        .navigationBarHidden(true)

        
    }

}

struct NavBarTest_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DestinationView(periodModel: PeriodModel.periodOneExample)
            Spacer()
        }
    }
}
