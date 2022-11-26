//
//  SignUpPasswordCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/26/22.
//

import SwiftUI

struct SignUpPasswordCardView: View {
    @Binding var isSecured: Bool
    @Binding var password: String
    var focused: FocusState<Bool>.Binding
    var hasError: Bool
    
    var body: some View {
        VStack {
            LoginTextField {
                HStack {
                    Group {
                        if isSecured {
                            SecureField(text: $password) {
                                Text("Password")
                                    .foregroundColor(Color(.gray))
                            }
                        }
                        else {
                            TextField(text: $password) {
                                Text("Password")
                                    .foregroundColor(Color(.gray))
                            }
                        }
                    }
                    
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .focused(focused)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    Spacer()
                    Button {
                        isSecured.toggle()
                    } label: {
                        Group {
                            if isSecured {
                                Image(systemName: "eye")
                            }
                            else {
                                Image(systemName: "eye.slash")
                            }
                        }
                        .foregroundColor(Color(.gray))
                            
                    }
                }
            }
            .fontWeight(.semibold)
            
            if hasError {
                HStack {
                    Spacer()
                    SignUpErrorView(systemImage: "exclamationmark.triangle", message: "Password Must Be 8 Characters")
                }
                .font(.footnote)
            }

        }
    }
}
