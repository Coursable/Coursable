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
    
    @State var displayErrorMessage: Bool = false
    
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
                Task {
                    
                    await signInViewModel.signIn(email: email, password: password) //{
                    
                       // withAnimation(.linear(duration: 0.2)) {
                        //    displayErrorMessage = true
                        //}
                        
                    //}
                }
                print(signInViewModel.signedIn)
            } label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(16)
            }
            Text("Unable to log in")
                .foregroundColor(.red)
                .opacity(displayErrorMessage ? 1 : 0)
            
            Text(String(signInViewModel.isSignedIn))
            Text(String(signInViewModel.signedIn))
        }
        .onAppear {
            signInViewModel.isSignedIn = signInViewModel.signedIn
            print("refershed")
        }
    }

}

struct LoggingInViewHandler_Previews: PreviewProvider {
    static var previews: some View {
        LoggingInViewHandler()
            .environmentObject(SignInViewModel())
    }
}
