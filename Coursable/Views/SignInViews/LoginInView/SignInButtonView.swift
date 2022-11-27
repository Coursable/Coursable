//
//  SignInButtonView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/26/22.
//

import SwiftUI

struct SignInButtonView: View {
    var isLoading: Bool
    
    var body: some View {
        Group {
            Text("Sign In")
                .fontWeight(.semibold)
                .font(.title2)
        }
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width*0.9, height: 65)
        
        .background(LinearGradient.bluePink)
        .opacity(isLoading ? 0.6 : 1)
        .cornerRadius(16)
    }
}

struct SignInButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignInButtonView(isLoading: false)
    }
}
