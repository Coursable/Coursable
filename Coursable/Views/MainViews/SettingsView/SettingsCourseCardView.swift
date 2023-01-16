//
//  SettingsCourseCardView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/28/22.
//

import SwiftUI

struct SettingsCourseCardView: View {
    @EnvironmentObject var periodViewModel: PeriodViewModel
    var isEditingSubjects: Bool
    var subject: Subject
    @State var isLoading: Bool = false
    @Binding var showAddSubjectSheet: Bool
    @Binding var subjectToEdit: Subject?
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Circle()
                    .fill(LinearGradient(colors: [Color(red: subject.colorGradientPrimary[0]/255, green: subject.colorGradientPrimary[1]/255, blue: subject.colorGradientPrimary[2]/255), Color(red: subject.colorGradientSecondary[0]/255, green: subject.colorGradientSecondary[1]/255, blue: subject.colorGradientSecondary[2]/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 50)
                    .overlay {
                        
                        Text(subject.name.prefix(1).capitalized)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                    }
                VStack(alignment: .leading) {
                    Text(subject.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    HStack {
                        //Image(systemName: "person")
                        Text("\(subject.teacher) - Room \(subject.roomNumber)")
                        
                        
 
                    }
                    .font(.subheadline)

                    
                }
                .padding(.leading, 3)
                
                Spacer()

            }
            

        }
        
        .padding()
        .foregroundColor(.white)
        .background(Color("SecondaryBackground"))
        .cornerRadius(15)
    }

}

struct SettingsCourseCardView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCourseCardView(isEditingSubjects: true, subject: Subject.LanguageArtsSubjectExample, showAddSubjectSheet: .constant(false), subjectToEdit: .constant(Subject.LanguageArtsSubjectExample))
            .environmentObject(PeriodViewModel())
    }
}
