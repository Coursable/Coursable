//
//  MainSignInView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/21/22.
//

import SwiftUI

struct MainSignInView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    switch viewRouter.currentPage {
                    case .signInPage:
                        LoginView()
                    case .mainPage:
                        MainPage()
                    }
                }
                .onAppear {
                    signInViewModel.isSignedIn = signInViewModel.signedIn

                    
                    if signInViewModel.isSignedIn {
                        viewRouter.currentPage = .mainPage
                    }
                    else {
                        viewRouter.currentPage = .signInPage
                    }
                    
                    print(viewRouter.currentPage)
                }
            }
            .background {
                Color("Background")
                    .ignoresSafeArea()
            }
            .animation(.default, value: viewRouter.currentPage)
        }
        
    }
}

struct MainSignInView_Previews: PreviewProvider {
    static var previews: some View {
        MainSignInView()
            .environmentObject(SignInViewModel())
            .environmentObject(ViewRouter())
    }
}
