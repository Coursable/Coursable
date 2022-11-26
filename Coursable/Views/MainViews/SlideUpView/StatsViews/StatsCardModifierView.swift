//
//  StatsCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/14/22.
//

import SwiftUI

struct StatsCardModifierView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray, lineWidth: 2)
                    .opacity(0.2)
            }
    }
}
