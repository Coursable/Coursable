//
//  SignUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var signInViewModel: SignInViewModel
    @State var email = ""
    @State var password = ""
    @State var isLoading: Bool = false
    @State var hasError: Bool = false
    @State var isSecured: Bool = true
    
    var body: some View {
        ZStack {
            VStack {
                TopInfoLoginView()
                
                VStack {
                    Group {
                        EmailCardView(email: $email, hasError: hasError)
                        
                        
                        VStack {
                            PasswordCardView(isSecured: $isSecured, password: $password, hasError: hasError)
                            
                            
                            HStack {
                                Spacer()
                                Text("Forgot Password?")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }


                    LoginButtonView(email: email, password: password, isLoading: $isLoading, hasError: $hasError)
                        .padding(.top, 50)
                    
                    
                    OtherOptionsDividerView()
                        .padding(.top)
                    
                    HStack {
                        SignInWithApple()
                            .cornerRadius(16)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 60)
                    .padding(.top)
                    
                    
                    HStack(spacing: 0) {
                        Text("Don't have an account? ")
                            .foregroundColor(.secondary)
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Background"))
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    
                }
                .padding()
                
     
            }
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(SignInViewModel())
    }
}
