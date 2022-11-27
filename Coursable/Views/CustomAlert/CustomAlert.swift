//
//  AlertThing.swift
//  Coursable
//
//  Created by Ari Reitman on 11/27/22.
//

import SwiftUI
import Combine

enum AlertType {
    case notification
    case accountAlreadyCreated
    
    func title() -> String {
        switch self {
        case.notification:
            return "Notification"
        case .accountAlreadyCreated:
            return "Error"
        }
    }
    
    func message() -> String {
        switch self {
        case .notification:
            return "This is a notification to show you information"
        case .accountAlreadyCreated:
            return "An account has already been created under this email"
        }
    }
    
    /// Left button action text for the alert view
    var leftActionText: String {
        switch self {
        case .notification:
            return "Cancel"
        case .accountAlreadyCreated:
            return ""
        }
    }
    
    /// Right button action text for the alert view
    var rightActionText: String {
        switch self {
        case .notification:
            return "Go"
        case .accountAlreadyCreated:
            return "Ok"
        }
    }
}

struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: AlertType = .notification
    
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?

    
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                if alertType.title() != "" {
                    Text(alertType.title())
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                }

                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.callout)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                

                HStack {
                    if (!alertType.leftActionText.isEmpty) {
                        Button {
                            leftButtonAction?()
                        } label: {
                            Text(alertType.leftActionText)
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
                        Text(alertType.rightActionText)
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
        CustomAlert(presentAlert: .constant(true))
    }
}



