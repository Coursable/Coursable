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


var colors = [
    //blue 0
    Color(red: Subject.Blue[0]/255,
          green: Subject.Blue[1]/255,
          blue: Subject.Blue[2]/255),
    //orange 1
    Color(red: Subject.Orange[0]/255,
          green: Subject.Orange[1]/255,
          blue: Subject.Orange[2]/255),
    //pink 2
    Color(red: Subject.Pink[0]/255,
          green: Subject.Pink[1]/255,
          blue: Subject.Pink[2]/255),
    //yellow 3
    Color(red: Subject.Yellow[0]/255,
          green: Subject.Yellow[1]/255,
          blue: Subject.Yellow[2]/255),
]
