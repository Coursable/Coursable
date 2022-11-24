//
//  SignInWithButton.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct SignInWithApple: View {

    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            
        } onCompletion: { result in
            
        }
        .signInWithAppleButtonStyle(.white)
        .font(.subheadline)

    }
}

struct SignInWithButton_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithApple()
    }
}
