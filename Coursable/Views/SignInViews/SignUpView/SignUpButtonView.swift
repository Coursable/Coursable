//
//  SignUpButtonView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/26/22.
//

import SwiftUI

struct SignUpButtonView: View {
    var isLoading: Bool
    
    var body: some View {
        Group {
            if !isLoading {
                Text("Sign Up")
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

struct SignUpButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpButtonView(isLoading: false)
    }
}
