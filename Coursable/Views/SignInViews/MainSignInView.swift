//
//  MainSignInView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/21/22.
//

import SwiftUI

struct MainSignInView: View {
    @State var isLoading: Bool = false
    @EnvironmentObject var signInViewModel: SignInViewModel

    var body: some View {
        NavigationView {
            ZStack {
                switch signInViewModel.state {
                  case .signedIn: MainPage()
                  case .signedOut: LoginView()
                }

                
                if isLoading {
                    CustomLoading()
                }

            }
            .onAppear {
                withAnimation {
                    isLoading = true
                }
                if signInViewModel.signedIn {
                    signInViewModel.state = .signedIn
                }
                else {
                    signInViewModel.state = .signedOut
                }
                withAnimation {
                    isLoading = false
                }

            }
            .background {
                Color("Background")
                    .ignoresSafeArea()
            }
            .animation(.default, value: signInViewModel.state)
        }
        
    }
}

struct MainSignInView_Previews: PreviewProvider {
    static var previews: some View {
        MainSignInView()
            .environmentObject(SignInViewModel())
    }
}
