//
//  EmailCardView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/22/22.
//

import SwiftUI

struct EmailCardView: View {
    @Binding var email: String
    var hasError: Bool
    
    var body: some View {
        HStack {
            TextField("Email", text: $email)

            if hasError {
                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
            }
            
            Button {
                email = ""
            } label: {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.secondary)
            }
            
        }
        .padding([.top, .bottom], 5)
        .padding()
        .background(Color(.secondarySystemBackground))
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        .cornerRadius(16)
    }
}

struct EmailCardView_Previews: PreviewProvider {
    static var previews: some View {
        EmailCardView(email: .constant(""), hasError: false)
    }
}
