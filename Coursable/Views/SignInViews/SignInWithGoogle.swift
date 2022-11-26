//
//  SignInWithButton.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct SignInWithGoogle: View {

    var body: some View {

        HStack {
            Image("GoogleLogo")
                .resizable()
                .scaledToFit()
                .padding()
            Text("Continue with Google")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Spacer()
        }
        .background(.white)
        .cornerRadius(16)
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 60)


    }
}

struct SignInWithButton_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithGoogle()
    }
}
