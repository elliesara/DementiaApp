//
//  NewSymptomButtonView.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 20/06/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct NewSymptomButtonView: View {
    let geometry: GeometryProxy
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width*0.05, height: geometry.size.height*0.05)
            
            Text("New Symptom")
                .font(.system(size: geometry.size.width*0.048))
                .fontWeight(.bold)
        }
        .padding()
        .foregroundColor(Color.white)
        .frame(height: geometry.size.height*0.063)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct NewSymptomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            NewSymptomButtonView(geometry: geometry)
        }
    }
}
