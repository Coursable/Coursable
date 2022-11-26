//
//  PasswordCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct LoginPasswordCardView: View {
    @Binding var isSecured: Bool
    @Binding var password: String
    var focused: FocusState<Bool>.Binding
    var hasError: Bool
    
    var body: some View {
        LoginTextField {
            Group {
                if isSecured {
                    SecureField(text: $password) {
                        Text("Password")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.white)
                }
                else {
                    TextField(text: $password) {
                        Text("Password")
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.white)
                }
            }
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
            .focused(focused)

            
               

            
            if hasError {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
            
            
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
}

