//
//  ForgotPasswordSubmitButtonView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/27/22.
//

import SwiftUI

struct ForgotPasswordSubmitButtonView: View {
    var isLoading: Bool
    
    var body: some View {
        Group {
            Text("Send Email")
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

struct ForgotPasswordSubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordSubmitButtonView(isLoading: false)
    }
}
