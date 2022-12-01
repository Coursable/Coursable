//
//  SettingsTextField.swift
//  Coursable
//
//  Created by Ari Reitman on 11/30/22.
//

import SwiftUI

struct SettingsTextField<Content> : View where Content : View {

    var content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: SettingsTextFieldModifier())
    }
}


private struct SettingsTextFieldModifier: ViewModifier {
    
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

