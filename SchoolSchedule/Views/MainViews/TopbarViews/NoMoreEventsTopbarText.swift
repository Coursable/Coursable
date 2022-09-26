//
//  NoMoreEventsText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct NoMoreEventsTopbarText: View {
    var body: some View {
        Text("No More Events Today")
            .font(.title3.weight(.semibold))
    }
}

struct NoMoreEventsTopbarText_Previews: PreviewProvider {
    static var previews: some View {
        NoMoreEventsTopbarText()
    }
}
