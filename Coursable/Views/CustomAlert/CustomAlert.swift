//
//  AlertThing.swift
//  Coursable
//
//  Created by Ari Reitman on 11/27/22.
//

import SwiftUI
import Combine

struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    
    var title: String = ""
    var bodyText: String
    
    var leftButtonText: String = ""
    var rightButtonText: String = ""
    
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?

    
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                if title != "" {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                }

                Text(bodyText)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.callout)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                

                HStack {
                    if (!leftButtonText.isEmpty) {
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(leftButtonText)
                                .font(.headline)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        }
                        .cornerRadius(16)
                        .padding([.leading, .bottom, .trailing], 6)
                    }
                    
                    // right button (default)
                    Button {
                        rightButtonAction?()
                    } label: {
                        Text(rightButtonText)
                            //.font(.system(size: 16, weight: .bold))
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(15)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    }
                    
                    .background {
                        LinearGradient.bluePink
                    }
                    
                    .cornerRadius(16)
                    .padding([.trailing, .bottom, .leading], 6)
                    
                    

                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                
                .padding([.horizontal, .bottom], 0)
                    
 
            }
            .frame(width: 300, height: 180)
            //.frame(width: 270, height: 150)
            .background(Color.white)
            
            .cornerRadius(16)
            .transition(.opacity)
        }
        .zIndex(2)
        .transition(.opacity)
        .animation(.default, value: presentAlert)
    }
}

struct AlertThing_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(presentAlert: .constant(true), bodyText: "Body")
    }
}



