//
//  EmailCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct EmailCardView: View {
    @Binding var email: String
    @FocusState var isInputActive: Bool
    var focused: FocusState<Bool>.Binding
    var hasError: Bool
    
    var body: some View {
        HStack {
            TextField(text: $email) {
                Text("Email")
                    .foregroundColor(Color(.gray))
            }
            .foregroundColor(.white)
            .focused(focused)

            
            
            if hasError {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
            
            Button {
                email = ""
            } label: {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(Color(.gray))
            }
            
            
        }
        .padding([.top, .bottom], 5)
        .padding()
        .background(.secondary)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        .cornerRadius(16)
    }
}