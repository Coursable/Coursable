//
//  MainView.swift
//  SchoolSchedule
//
//  Created by Ari Reitman on 9/24/22.
//

import SwiftUI

struct MainPage_FirstLayerView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    
    @State var showSettingsSheet: Bool = false
        
    
    var body: some View {
        VStack {

            
            ZStack {
                Button {
                    showSettingsSheet.toggle()
                } label: {
                    ZStack {
                        
                        Circle()
                            .opacity(0.3)
                            .foregroundStyle(.gray)
                            .frame(width: 50)
                            .overlay {
                                Image(systemName: "gearshape.fill")
                                    .font(.title2)
                                    .font(.largeTitle)
                                .foregroundStyle(.white)
                            }
                        
                        
                    }
                        
                }
                .offset(x: -155)
                
                HStack {
                    Spacer()
                    TopbarText()
                       .foregroundColor(.white)
                    Spacer()
                }
                
                Button {
                    
                } label: {
                    ZStack {
                        
                        Circle()
                            .opacity(0.3)
                            .foregroundStyle(.gray)
                            .frame(width: 50)
                            .overlay {
                                Image("MyIcon")//"MyIcon"
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45)
                                    .font(.largeTitle)
                                .foregroundStyle(.white)
                            }
                        
                        
                    }
                        
                }
                .offset(x: 155)

            }
            .padding(.top)
            


            ProgressRingView()

            Spacer()
            
            

            
        }
        .onAppear {
            Task {
                await periodViewModel.retrieveSubjectData()
            }
            
        }
        .foregroundColor(.white)
        .background(Color("Background"))
        .fullScreenCover(isPresented: $showSettingsSheet, content: {
            SettingsView(showSettingsSheet: $showSettingsSheet)
        })
        
        

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage_FirstLayerView()
            .environmentObject(PeriodViewModel())
    }
}
