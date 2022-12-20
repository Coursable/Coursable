//
//  CustomTextFieldView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import SwiftUI

struct CustomTextField<Content> : View where Content : View {

    var content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: CustomTextFieldModifier())
    }
}


private struct CustomTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack {
            content
        }
        .padding([.top, .bottom], 5)
        .padding()
        .background(.secondary)
        .cornerRadius(16)
    }
}


