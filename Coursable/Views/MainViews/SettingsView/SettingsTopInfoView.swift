//
//  SettingsTopInfoView.swift
//  Coursable
//
//  Created by Ari Reitman on 11/28/22.
//

import SwiftUI

struct SettingsTopInfoView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Settings")
            }
            .padding()
            Spacer()
        }
    }
}

struct SettingsTopInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTopInfoView()
    }
}
