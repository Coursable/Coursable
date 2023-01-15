//
//  SettingsScheduleInfoView.swift
//  Coursable
//
//  Created by Ari Reitman on 12/23/22.
//

import SwiftUI

struct SettingsScheduleInfoView: View {
    
    var dayModel: DayModel
    
    var body: some View {
        ZStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .background(Color("Background"))
    }
}

struct SettingsScheduleInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScheduleInfoView(dayModel: DayModel.ExampleDay1)
    }
}
