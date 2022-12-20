//
//  LoginDemoEmail.swift
//  Coursable
//
//  Created by Ari Reitman on 12/19/22.
//

import SwiftUI

struct LoginDemoEmail: View {
    @State var email = ""
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            

            
            HStack {
                TextField(text: $email) {
                    Text("Email")
                        .foregroundColor(Color(.gray))
                }
                .foregroundColor(.white)
                //.focused(focused)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)

                Image(systemName: "exclamationmark.triangle")
                    .foregroundColor(.red)
                    //.opacity(hasError ? 1 : 0)


                Button {
                    //email = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(.gray))
                }

            }
            .padding(20)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.secondary, lineWidth: 6)
            )
            .cornerRadius(16)
            

        }
        
        
        
    }
}

struct LoginDemoEmail_Previews: PreviewProvider {
    static var previews: some View {
        LoginDemoEmail()
    }
}
