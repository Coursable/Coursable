//
//  TopNavBar.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 11/19/22.
//

import SwiftUI


struct TopNavBar<Content> : View where Content : View {
    var content: () -> Content
    private var showBackButton: Bool
    
    public init(showBackButton: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.showBackButton = showBackButton
    }
    
    public var body: some View {
        ModifiedContent(content: self.content(), modifier: TopNavBarViewModifier(showBackButton: self.showBackButton))
    }
}

private struct TopNavBarViewModifier: ViewModifier {
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

