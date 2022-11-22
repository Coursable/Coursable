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
    @State var isLoading: Bool = false
    
    @State var displayErrorMessage: Bool = false
    @State var errorMessage = ""
    
    var body: some View {

        ZStack {
            VStack {
                
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .cornerRadius(16)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .cornerRadius(16)
                    
                
                Button {
                    if !email.isEmpty && !password.isEmpty {
                        Task {
                            isLoading = true
                            
                            switch await signInViewModel.signIn(email: email, password: password) {
                            case .invalidEmailPassword:
                                withAnimation(.linear(duration: 0.2)) {
                                    errorMessage = "Invalid Email or Password"
                                    displayErrorMessage = true
                                }
                            case .success:
                                withAnimation(.linear(duration: 0.2)) {
                                    errorMessage = ""
                                    displayErrorMessage = false
                                }
                            }

                            isLoading = false
                        }
                    }
                } label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .padding([.leading, .trailing], 100)
                        .background(Color("Background"))
                        .cornerRadius(16)
                }
                
                Button {
                    
                } label: {
                    Text("Don't have an account? Sign up")
                }

                
                Text(errorMessage)
                    .foregroundColor(.red)
                    .opacity(displayErrorMessage ? 1 : 0)
                
                Spacer()
            }
            .padding()
            
            if isLoading {
                ProgressView()
            }
                
        }
        //.navigationBarHidden(true)
        
        
    }

}

struct LoggingInViewHandler_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoggingInViewHandler()
                .environmentObject(SignInViewModel())
        }
    }
}
