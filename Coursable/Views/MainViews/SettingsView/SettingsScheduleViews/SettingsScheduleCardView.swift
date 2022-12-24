//
//  SettingsScheduleCardView.swift
//  Coursable
//
//  Created by Ari Reitman on 12/23/22.
//

import SwiftUI

struct SettingsScheduleCardView: View {
    
    var dayModel: DayModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Circle()
                    .fill(DayModel.dayColors[dayModel.day - 1])
                    .frame(width: 50)
                    .overlay {
                        
                        Text(dayModel.day.convertWeekdayToString().prefix(1).capitalized)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                    }
                
                VStack(alignment: .leading) {
                    Text(dayModel.day.convertWeekdayToString())
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                }
                .padding(.leading, 3)
                
                Spacer()
                
                
                
                
                
                
            }

        }
        .padding()
        .foregroundColor(.white)
        .background(Color(UIColor.secondaryLabel))
        .cornerRadius(15)
    }
}

struct SettingsScheduleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScheduleCardView(dayModel: DayModel.ExampleDay1)
    }
}
