//
//  CustomLoading.swift
//  Coursable
//
//  Created by Ari Reitman on 11/27/22.
//

import SwiftUI

struct CustomLoading: View {
    
    var showBackground: Bool = true
    
    var size: Double = 70
    
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            if showBackground {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.white)
                    .shadow(radius: 5, x: 0, y: 0)
                    .frame(width: size, height: size, alignment: .center)
            }

            Circle()
                .trim(from: 0, to: 0.37)
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(LinearGradient.bluePink)
                .frame(width: size*0.4, alignment: .center)
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
