//
//  DayGraphView.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 25/07/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct DayGraphView: View {
    let reportData: [ReportData]
    let onTap: (_ severity: Int) -> Void
    
    private let severities = ["Mild", "Moderate", "Severe", "Deadly"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Day")
                .font(.title)
                .fontWeight(.bold)
            
            GraphView(data: graphData, onTap: { index in
                guard let index = index else { return }
                onTap(index + 1)
            })
            .frame(height: 200)
            .padding([.leading, .trailing], 5)
        }
    }
    
    private var entries: [ReportSymptom] {
        reportData.first(where: { $0.date == Date().startOfDay })?.symptoms ?? []
    }
    
    private var graphData: [GraphData] {
        let entries = entries
        
        return severities.enumerated().map { index, element in
            GraphData(value: entries.filter { $0.severity == index + 1 }.count,
                      name: element,
                      color: color(forSeverity: index + 1))
        }
    }
    
    private func color(forSeverity severity: Int) -> Color {
        switch severity {
        case 1:
            return Color(#colorLiteral(red: 0.6952038407, green: 0.4575328231, blue: 0.1743277311, alpha: 1))
        case 2:
            return Color(#colorLiteral(red: 0.7056599855, green: 0.6749765277, blue: 0.3466123939, alpha: 1))
        case 3:
            return Color(#colorLiteral(red: 0.232246995, green: 0.5231903195, blue: 0.647739172, alpha: 1))
        case 4:
            return Color(#colorLiteral(red: 0.6056969166, green: 0.2998026013, blue: 0.7654415965, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.6671229601, green: 0.1596478224, blue: 0.1696583331, alpha: 1))
        }
    }
}

struct DayGraphView_Previews: PreviewProvider {
    static var previews: some View {
        DayGraphView(reportData: [], onTap: { _ in })
    }
}
