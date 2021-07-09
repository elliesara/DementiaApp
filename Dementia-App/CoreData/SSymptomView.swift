//
//  SSymptomView.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/8/21.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct SSymptomView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var sSymptomName: String = ""
    var sCreatedAt: String = ""
    
    var body: some View {
        HStack {
            Text(sSymptomName).font(.headline).padding(.bottom)
            Text(sCreatedAt).font(.caption).padding(.bottom)
        }
    }
}

struct SSymptomView_Previews: PreviewProvider {
    static var previews: some View {
        SSymptomView(sSymptomName: "My great todo", sCreatedAt: "Today")
    }
}
