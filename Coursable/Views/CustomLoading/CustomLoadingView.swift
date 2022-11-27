//
//  CustomLoading.swift
//  Coursable
//
//  Created by Ari Reitman on 11/27/22.
//

import SwiftUI

struct CustomLoading: View {
    
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .shadow(radius: 5, x: 0, y: 0)
                .frame(width: 70, height: 70, alignment: .center)
            Circle()
                .trim(from: 0, to: 0.37)
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(LinearGradient.bluePink)
                .frame(width: 30, height: 30, alignment: .center)
                .rotationEffect(Angle(degrees: isLoading ? 0 : 360))
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                        isLoading.toggle()
                    }
                }
        }
    }
}

struct CustomLoading_Previews: PreviewProvider {
    static var previews: some View {
        CustomLoading()
    }
}
