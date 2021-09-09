//
//  SettingsView.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/10/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI
struct SettingsView: View {
    
    @State private var stepperValue: Int = 0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 40) {
                fontSize
                NotificationsView()
                aboutUs
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .navigationBarTitle("Settings")
        }
    }
    
    private var fontSize: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Font Size")
                .font(.headline)
            Stepper("Change your font size here:", value: $stepperValue, in: 0...6)
                .font(.footnote)
                .fixedSize()
            HStack {
                Spacer()
                Group {
                    Text("This is what your font looks like.").padding()
                }.background(Color.gray)
                Spacer()
            }.padding([.top], 20)
        }
    }
    
    private var aboutUs: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About us")
                .font(.headline)
            Text("TBD")
                .font(.footnote)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
