//
//  AddSubjectCustomColorView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/30/22.
//

import SwiftUI

struct AddSubjectCustomColorView: View {
    
    @State var colorPrimary: Color = colors[1]
    @State var colorSecondary: Color = colors[2]
    
    
    
    var body: some View {
        HStack(alignment: .center) {
            
            Circle()
                .frame(width: 100)
                .foregroundStyle(LinearGradient(colors: [colorPrimary, colorSecondary], startPoint: .topLeading, endPoint: .bottomTrailing))

            
            VStack(spacing: 6) {
                VStack(spacing: 4) {
                    HStack {
                        Text("Primary")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                            
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        colorPrimary = color
                                    }
                                    
                                } label: {
                                    Circle()
                                        .foregroundStyle(color)
                                        .frame(width: 30, height: 30)

                                        .overlay {
                                            if color == colorPrimary {
                                                Circle()
                                                    .foregroundStyle(.white)
                                                    .frame(width: 15, height: 15)
                                                    .transition(.scale)
                                            }

                                        }
                                        
                                }

                            }
                            
                        }
                        
                    }
                }
                
                
                VStack(spacing: 4) {
                    HStack {
                        Text("Secondary")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                            
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        colorSecondary = color
                                    }
                                    
                                } label: {
                                    Circle()
                                        .foregroundStyle(color)
                                        .frame(width: 30, height: 30)
                                        .overlay {
                                            if color == colorSecondary {
                                                Circle()
                                                    .foregroundStyle(.white)
                                                    .frame(width: 15, height: 15)
                                                    .transition(.scale)
                                            }

                                        }
                                        
                                }
                            }
                            
                        }
                        
                    }
                }
                
                
                
                
            }
            .padding(.leading)


        }
        .padding()
        
    }
}

struct AddSubjectCustomColorView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectCustomColorView()
            .preferredColorScheme(.dark)
    }
}
