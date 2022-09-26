//
//  TopbarText.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/26/22.
//

import SwiftUI

struct TopbarText: View {
    var body: some View {
        VStack(spacing: 5) {
            Text("Event")
                .font(.title3.weight(.semibold))
                
            Text("10:45-11:45AM - Room 16")
                .font(.subheadline.weight(.semibold))
        }
    }
}

struct TopbarText_Previews: PreviewProvider {
    static var previews: some View {
        TopbarText()
    }
}
