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
        //VStack {
            if signInViewModel.isSignedIn {
                
                    MainPage()
                    
                    //.transition(.slide)
//                    VStack {
//                        Text("Your logged in")
//                        Button {
//                            signInViewModel.signOut()
//                        } label: {
//                            Text("Sign Out")
//                        }
//
//                    }
                
            }
            else {
                LoginView()
            }
        //}
        //.onAppear {
            //signInViewModel.isSignedIn = signInViewModel.signedIn
            
            
        //}
    }
}

struct MainSignInView_Previews: PreviewProvider {
    static var previews: some View {
        MainSignInView()
            .environmentObject(SignInViewModel())
    }
}
