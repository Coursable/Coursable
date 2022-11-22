//
//  LoggingInViewHandler.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/21/22.
//

import SwiftUI

struct LoggingInViewHandler: View {
    
    @EnvironmentObject var signInViewModel: SignInViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
            
            Button {
                signInViewModel.signIn(email: email, password: password)
            } label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(16)
            }

        }
    }
}

struct LoggingInViewHandler_Previews: PreviewProvider {
    static var previews: some View {
        LoggingInViewHandler()
            .environmentObject(SignInViewModel())
    }
}
