//
//  ForgotPasswordEmailFieldView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/27/22.
//

import SwiftUI

struct ForgotPasswordEmailFieldView: View {
    
    @Binding var email: String
    @FocusState var isInputActive: Bool
    var focused: FocusState<Bool>.Binding
    var hasError: Bool
    
    var body: some View {
        CustomTextField {
            TextField(text: $email) {
                Text("Email")
                    .foregroundColor(Color(.gray))
            }
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .focused(focused)
            .autocorrectionDisabled(true)
            .autocapitalization(.none)

            Image(systemName: "exclamationmark.triangle")
                .foregroundColor(.red)
                .opacity(hasError ? 1 : 0)


            Button {
                email = ""
            } label: {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(Color(.gray))
            }
            
            
            
        }
    }
}

