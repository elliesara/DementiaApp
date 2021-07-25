//
//  MonthGraphView.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 25/07/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct MonthGraphView: View {
    let reportData: [ReportData]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Month")
                .font(.title)
                .fontWeight(.bold)
            
            GraphView(data: [
                GraphData(value: 4, name: "Week 1", color: Color(#colorLiteral(red: 0.6671229601, green: 0.1596478224, blue: 0.1696583331, alpha: 1))),
                GraphData(value: 3, name: "Week 2", color: Color(#colorLiteral(red: 0.6952038407, green: 0.4575328231, blue: 0.1743277311, alpha: 1))),
                GraphData(value: 5, name: "Week 3", color: Color(#colorLiteral(red: 0.7056599855, green: 0.6749765277, blue: 0.3466123939, alpha: 1))),
                GraphData(value: 2, name: "Week 4", color: Color(#colorLiteral(red: 0.232246995, green: 0.5231903195, blue: 0.647739172, alpha: 1))),
            ])
            .frame(height: 200)
            .padding([.leading, .trailing], 5)
        }
    }
}

struct MonthGraphView_Previews: PreviewProvider {
    static var previews: some View {
        MonthGraphView(reportData: [])
    }
}
