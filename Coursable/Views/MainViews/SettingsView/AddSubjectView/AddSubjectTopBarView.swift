//
//  AddSubjectTopBarView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/30/22.
//

import SwiftUI

struct AddSubjectTopBarView: View {
    @Binding var showAddSubjectSheet: Bool
    @Binding var subjectToEdit: Subject?
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Text("Add Subject")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .overlay(
                Button {
                    subjectToEdit = nil
                    showAddSubjectSheet.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.top, 5)
                .padding(.trailing, 30)
                
                ,alignment: .topTrailing
            )
        }
    }
}

struct AddSubjectTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectTopBarView(showAddSubjectSheet: .constant(false), subjectToEdit: .constant(Subject.LanguageArtsSubjectExample))
            .preferredColorScheme(.dark)
    }
}
