//
//  SlideUp.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/11/22.
//

import SwiftUI

struct SlideUp<Content> : View where Content : View {

    var content: () -> Content
    private var startingOffsetValue: CGFloat
    private var endingOffsetValue: CGFloat
    private var backgroundColorValue: Color
    private var barColorValue: Color
    private var screenHeight: CGFloat
    
    public init(startingOffset: CGFloat = 500, endingOffset: CGFloat = 100, backgroundColor: Color = .white, barColor: Color = .secondary, screenHeight: CGFloat, content: @escaping () -> Content) {
        self.content = content
        self.startingOffsetValue = startingOffset
        self.endingOffsetValue = endingOffset
        self.backgroundColorValue = backgroundColor
        self.barColorValue = barColor
        self.screenHeight = screenHeight
        
    }
    
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: SlideUpViewModifier(startingOffset: startingOffsetValue, endingOffset: endingOffsetValue, backgroundColor: backgroundColorValue, barColor: barColorValue, screenHeight: screenHeight))
    }
}

