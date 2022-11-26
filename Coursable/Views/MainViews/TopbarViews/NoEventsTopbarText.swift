//
//  NoEventsText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct NoEventsTopbarText: View {
    var body: some View {
        Text("No Events Today")
            .font(.title3.weight(.semibold))
    }
}

struct NoEventsTopbarText_Previews: PreviewProvider {
    static var previews: some View {
        NoEventsTopbarText()
    }
}
