//
//  TestView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/28/22.
//

import SwiftUI

struct TestView: View {
    @State var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            Button {
                showSheet.toggle()
            } label: {
                Text("Click")
            }

        }
        .sheet(isPresented: $showSheet, content: {
            Text("Test")
        })
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
