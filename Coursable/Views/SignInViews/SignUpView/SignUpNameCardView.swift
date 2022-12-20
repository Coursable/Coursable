//
//  SignUpLastNameCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/26/22.
//

import SwiftUI

struct SignUpNameCardView: View {
    @Binding var name: String
    @FocusState var isInputActive: Bool
    var focused: FocusState<Bool>.Binding
    var hasError: Bool
    
    var body: some View {
        CustomTextField {
            HStack {
                TextField(text: $name) {
                    Text("Name")
                        .foregroundColor(Color(.gray))
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .focused(focused)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
            }
            Spacer()
            SignUpErrorView(systemImage: "exclamationmark.triangle", message: "")
                .opacity(hasError ? 1 : 0)
        }
        .fontWeight(.semibold)
    }
}
