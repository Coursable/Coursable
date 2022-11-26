//
//  SignUpEmailCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/26/22.
//

import SwiftUI

struct SignUpEmailCardView: View {
    @Binding var email: String
    @FocusState var isInputActive: Bool
    var focused: FocusState<Bool>.Binding
    var hasError: Bool
    
    var body: some View {
        VStack {
            LoginTextField {
                HStack {
                    TextField(text: $email) {
                        Text("Email")
                            .foregroundColor(Color(.gray))
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .focused(focused)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    Spacer()
                    Button {
                        email = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color(.gray))
                    }
                }
            }
            .fontWeight(.semibold)
            
            if hasError {
                HStack {
                    Spacer()
                    SignUpErrorView(systemImage: "exclamationmark.triangle", message: "Invalid Email")
                }
                .font(.footnote)
            }


        }
    }
}
