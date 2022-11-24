//
//  LoginButtonView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct LoginButtonView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    var email: String
    var password: String
    @Binding var isLoading: Bool
    @Binding var hasError: Bool
    
    var body: some View {
        Button {
            if !email.isEmpty && !password.isEmpty && !isLoading {
                Task {
                    withAnimation {
                        isLoading = true
                    }
                    
                    switch await signInViewModel.signIn(email: email, password: password) {
                    case .invalidEmailPassword:
                        withAnimation(.linear(duration: 0.2)) {
                            hasError = true
                        }
                    case .success:
                        withAnimation(.linear(duration: 0.2)) {
                            hasError = false
                        }
                    }
                        
                    withAnimation {
                        isLoading = false
                    }
                    
                }
            }
            else {
                withAnimation {
                    hasError = true
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
            
            .background(LinearGradient.bluePink)
            .opacity(isLoading ? 0.6 : 1)
            .cornerRadius(16)
            
        }
    }
}

struct LoginButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtonView(email: "", password: "", isLoading: .constant(false), hasError: .constant(false))
            .environmentObject(SignInViewModel())
    }
}
