//
//  StatsCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/14/22.
//

import SwiftUI

struct StatsCardView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(UIColor.systemGray6))
            }
    }
}
