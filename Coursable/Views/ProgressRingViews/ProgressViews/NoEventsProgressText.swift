//
//  NoEventsProgressText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/27/22.
//

import SwiftUI

struct NoEventsProgressText: View {
    var body: some View {
        Text("No Events \nToday")
            .modifier(SubTextProgress(fontWeight: .heavy, font: .title))
    }
}

struct NoEventsProgressText_Previews: PreviewProvider {
    static var previews: some View {
        NoEventsProgressText()
    }
}
