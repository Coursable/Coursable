//
//  NoMoreEventsText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct NoMoreEventsProgressText: View {
    var body: some View {
        Text("No More \nEvents Today")
            .modifier(SubTextProgress(fontWeight: .heavy, font: .title))
    }
}

struct NoMoreEventsProgressText_Previews: PreviewProvider {
    static var previews: some View {
        NoMoreEventsProgressText()
    }
}
