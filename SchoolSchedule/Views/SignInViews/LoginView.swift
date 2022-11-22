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
    @State var errorMessage = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Welcome")
                            .fontWeight(.bold)
                            .font(.title)
                            
                        Text("To begin using the app, please sign in")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    Spacer()
                }
                
                VStack {
                    Group {
                        HStack {
                            TextField("Email", text: $email)

                            if hasError {
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundColor(.red)
                            }
                            
                        }
                        .padding([.top, .bottom], 5)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .cornerRadius(16)
                        
                        
                        VStack {
                            HStack {
                                SecureField("Password", text: $password)

                                
                                if hasError {
                                    Image(systemName: "exclamationmark.triangle")
                                        .foregroundColor(.red)
                                }
                                
                                    
                            }
                            .padding([.top, .bottom], 5)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .cornerRadius(16)
                            .padding(.top, 17)
                            
                            
                            HStack {
                                Spacer()
                                Text("Forgot Password?")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }

                    
                    
                    Button {
                        if !email.isEmpty && !password.isEmpty && !isLoading {
                            Task {
                                withAnimation {
                                    isLoading = true
                                }
                                
                                switch await signInViewModel.signIn(email: email, password: password) {
                                case .invalidEmailPassword:
                                    withAnimation(.linear(duration: 0.2)) {
                                        errorMessage = "Invalid Email or Password"
                                        hasError = true
                                    }
                                case .success:
                                    withAnimation(.linear(duration: 0.2)) {
                                        errorMessage = ""
                                        hasError = false
                                    }
                                }
                                
                                Task {
                                    await resetErrorText()
                                }
                                    

                                withAnimation {
                                    isLoading = false
                                }
                                
                            }
                        }
                    } label: {
                        
                        Group {
                            if !isLoading {
                                Text("Sign In")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                            }
                            else {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width*0.9, height: 65)
                        .background(Color("Background"))
                        .opacity(isLoading ? 0.6 : 1)
                        .cornerRadius(16)
                    }
                    .padding(.top, 50)
                    
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 1)
                            .foregroundColor(.secondary)
                        
                        Text("or sign in with")
                            .foregroundColor(.secondary)
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 1)
                            .foregroundColor(.secondary)
                    }
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
    
    @Sendable private func resetErrorText() async {
        try? await Task.sleep(for: .seconds(3))
        
        withAnimation {
            errorMessage = ""
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SignInViewModel())
    }
}
