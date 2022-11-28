//
//  ForgotPasswordTopInfoView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/27/22.
//

import SwiftUI

struct ForgotPasswordTopInfoView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Forgot Password")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    
                Text("To reset your password, please enter your email below")
                    .font(.subheadline)
            }
            .padding()
            Spacer()
        }
    }
}

struct ForgotPasswordTopInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordTopInfoView()
    }
}
