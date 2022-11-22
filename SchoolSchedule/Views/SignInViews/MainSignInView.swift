//
//  MainSignInView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/21/22.
//

import SwiftUI

struct MainSignInView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if signInViewModel.isSignedIn {
                    
                    //MainPage()
                    VStack {
                        //MainPage()
                        Text("Your logged in")
                        Button {
                            signInViewModel.signOut()
                        } label: {
                            Text("Sign Out")
                        }

                    }
                    
                }
                else {
                    LoginView()
                }
            }
            .onAppear {
                signInViewModel.isSignedIn = signInViewModel.signedIn
        }
        }
    }
}

struct MainSignInView_Previews: PreviewProvider {
    static var previews: some View {
        MainSignInView()
            .environmentObject(SignInViewModel())
    }
}
