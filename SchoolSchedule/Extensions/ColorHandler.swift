//
//  ColorHandler.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/25/22.
//

import Foundation
import SwiftUI

extension LinearGradient {
    static let bluePink = LinearGradient(colors: [.blue, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let yellowOrange = LinearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let orangePurple = LinearGradient(colors: [.orange, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let defaultGray = LinearGradient(colors: [.gray, .secondary], startPoint: .topLeading, endPoint: .bottomTrailing)
}
