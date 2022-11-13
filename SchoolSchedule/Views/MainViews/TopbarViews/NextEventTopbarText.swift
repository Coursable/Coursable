//
//  NextEventText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct NextEventTopbarText: View {
    var periodModel: PeriodModel
    
    var body: some View {
        VStack {
            Text("Next Period: " + periodModel.subject.name)
                .font(.title3.weight(.semibold))
            
            HStack(spacing: 2) {
                Text("Starts at")
                Text(periodModel.startTimeParsed, format: .dateTime.hour().minute())
                Text("-")
                Text("Room " + periodModel.subject.roomNumber)
            }
            .font(.subheadline.weight(.semibold))
        }

    }
}

struct NextEventTopbarText_Previews: PreviewProvider {
    static var previews: some View {
        NextEventTopbarText(periodModel: PeriodModel.periodOneExample)
    }
}
