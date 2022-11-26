//
//  LoginTextFieldView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import SwiftUI

struct LoginTextField<Content> : View where Content : View {

    var content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: LoginTextFieldModifier())
    }
}


private struct LoginTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack {
            content
        }
        .padding([.top, .bottom], 5)
        .padding()
        .background(.secondary)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        .cornerRadius(16)
    }
}


