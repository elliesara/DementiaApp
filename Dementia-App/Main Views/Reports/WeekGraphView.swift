//
//  WeekGraphView.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 25/07/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct WeekGraphView: View {
    let reportData: [ReportData]
    let onTap: (_ day: Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Week")
                .font(.title)
                .fontWeight(.bold)
            
            GraphView(data: graphData, onTap: { index in
                guard let index = index else { return }
                onTap(index)
            })
            .frame(height: 200)
            .padding([.leading, .trailing], 5)
        }
    }
    
    private var graphData: [GraphData] {
        var dates = [Date]()
        var date = Date().startOfWeek.startOfDay
        for _ in 0 ..< 7 {
            dates.append(date)
            date = date.startOfAdjacentDay(offset: .forward)
        }
        
        return dates.enumerated().map { index, element in
            let value = reportData
                .first(where: { $0.date == element })?
                .symptoms.map(\.severity).reduce(0, +) ?? 0
            
            return GraphData(value: Int(value),
                             name: element.dayOfWeek,
                             color: color(forIndex: index))
        }
    }
    
    private func color(forIndex index: Int) -> Color {
        switch index {
        case 0:
            return Color(#colorLiteral(red: 0.6671229601, green: 0.1596478224, blue: 0.1696583331, alpha: 1))
        case 1:
            return Color(#colorLiteral(red: 0.6952038407, green: 0.4575328231, blue: 0.1743277311, alpha: 1))
        case 2:
            return Color(#colorLiteral(red: 0.7056599855, green: 0.6749765277, blue: 0.3466123939, alpha: 1))
        case 3:
            return Color(#colorLiteral(red: 0.4436366856, green: 0.6058051586, blue: 0.3097212613, alpha: 1))
        case 4:
            return Color(#colorLiteral(red: 0.232246995, green: 0.5231903195, blue: 0.647739172, alpha: 1))
        case 5:
            return Color(#colorLiteral(red: 0.6056969166, green: 0.2998026013, blue: 0.7654415965, alpha: 1))
        case 6:
            return Color(#colorLiteral(red: 0.4391640723, green: 0.2512674332, blue: 0.8874402046, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.4391640723, green: 0.2512674332, blue: 0.8874402046, alpha: 1))
        }
    }
}

struct WeekGraphView_Previews: PreviewProvider {
    static var previews: some View {
        WeekGraphView(reportData: [], onTap: { _ in })
    }
}
