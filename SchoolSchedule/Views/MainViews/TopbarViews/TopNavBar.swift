//
//  TopNavBar.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/19/22.
//

import SwiftUI


struct TopNavBar<Content> : View where Content : View {
    var content: () -> Content
    private var showBackButton: Bool
    
    public init(showBackButton: Bool = true, content: @escaping () -> Content) {
        self.content = content
        self.showBackButton = showBackButton
    }
    
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: TopNavBarViewModifier(showBackButton: self.showBackButton))
    }
}

