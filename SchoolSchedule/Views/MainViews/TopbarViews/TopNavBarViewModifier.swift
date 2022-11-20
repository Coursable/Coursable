//
//  TopNavBarViewModifier.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/19/22.
//

import SwiftUI


struct TopNavBarViewModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    var showBackButton: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            HStack {
                if showBackButton {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                content
                Spacer()
            }
            .padding(20)
        }
        .background {
            Color("Background").ignoresSafeArea(edges: .top)
                .frame(width: UIScreen.main.bounds.width * 10) //extend the frame to prevent background clashing
        }

    }
}

