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
//    //blue 0
//    Color(red: Subject.Blue[0]/255,
//          green: Subject.Blue[1]/255,
//          blue: Subject.Blue[2]/255),
//    //orange 1
//    Color(red: Subject.Orange[0]/255,
//          green: Subject.Orange[1]/255,
//          blue: Subject.Orange[2]/255),
//    //pink 2
//    Color(red: Subject.Pink[0]/255,
//          green: Subject.Pink[1]/255,
//          blue: Subject.Pink[2]/255),
//    //yellow 3
//    Color(red: Subject.Yellow[0]/255,
//          green: Subject.Yellow[1]/255,
//          blue: Subject.Yellow[2]/255),
    
    Color.blue,
    
    Color.orange,
    
    Color.pink,
    
    Color.yellow,
    
    Color.green,
    
    Color.cyan,
    
    Color.indigo,
    
    Color.mint,
    
    Color.teal,
    
]

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {

        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r*255, g*255, b*255, o)
    }
}
