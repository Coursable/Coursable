//
//  TopInfoSignUpView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/25/22.
//

import SwiftUI

struct SignUpTopInfoView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Sign Up")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    
                Text("Please enter your valid credentials")
                    .font(.subheadline)
            }
            .padding()
            Spacer()
        }
    }
}

struct TopInfoSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpTopInfoView()
    }
}
