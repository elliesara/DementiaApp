//
//  MSymptomView.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/8/21.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct MSymptomView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var mSymptomName: String = ""
    var mCreatedAt: String = ""
    
    var body: some View {
        HStack {
            Text(mSymptomName).font(.headline).padding(.bottom)
            Text(mCreatedAt).font(.caption).padding(.bottom)
        }
    }
}

struct MSymptomView_Previews: PreviewProvider {
    static var previews: some View {
        MSymptomView(mSymptomName: "My great todo", mCreatedAt: "Today")
    }
}
