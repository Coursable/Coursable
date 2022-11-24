//
//  PasswordCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct PasswordCardView: View {
    @Binding var isSecured: Bool
    @Binding var password: String
    var hasError: Bool
    
    var body: some View {
        HStack {
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
        .padding([.top, .bottom], 5)
        .padding()
        .background(.secondary)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        .cornerRadius(16)
        .padding(.top, 17)
    }
}

struct PasswordCardView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordCardView(isSecured: .constant(true), password: .constant(""), hasError: false)
    }
}
