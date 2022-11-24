//
//  LoginView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct LoginView: View {
    
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
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                VStack {
                    Group {
                        EmailCardView(email: $email, hasError: hasError)
                            .fontWeight(.semibold)
                        
                        
                        VStack {
                            PasswordCardView(isSecured: $isSecured, password: $password, hasError: hasError)
                                .fontWeight(.semibold)
                            
                            
                            HStack {
                                Spacer()
                                Text("Forgot Password?")
                                    .underline()
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                        }
                    }


                    LoginButtonView(email: email, password: password, isLoading: $isLoading, hasError: $hasError)
                        .padding(.top, 50)
                    
                    
                    OtherOptionsDividerView()
                        .foregroundColor(.white)
                        .padding(.top)
                    
                    HStack {
                        SignInWithApple()
                            .cornerRadius(16)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 60)
                    .padding(.top)
                    
                    
                    HStack(spacing: 0) {
                        Text("Don't have an account? ")
                            .foregroundColor(.white)
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .underline()
                            
                            
                    }
                    .padding(.top)


                    
                    Spacer()
                    
                    
                }
                .padding()
                
     
            }
            
        }
        
        .background(Color("Background"))
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SignInViewModel())
    }
}
