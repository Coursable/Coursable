//
//  CurrentEventText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct CurrentEventTopbarText: View {
    
    var periodModel: PeriodModel
    
    var body: some View {
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
    }
}

struct CurrentEventTopbarText_Previews: PreviewProvider {
    static var previews: some View {
        CurrentEventTopbarText(periodModel: PeriodModel.periodExample)
    }
}
