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
            
            GraphView(data: graphData)
            .frame(height: 200)
            .padding([.leading, .trailing], 5)
        }
    }
    
    private var graphData: [GraphData] {
        summedSeverities.enumerated().map { index, value in
            GraphData(value: Int(value),
                      name: "Week \(index + 1)",
                      color: color(forWeek: index))
        }
    }
    
    private var ranges: [(Date, Date)] {
        var ranges = [(Date, Date)]()
        var date = Date().startOfMonth.startOfDay
        let endOfMonth = Date().endOfMonth
        
        while date < endOfMonth {
            var endDate = date.endOfWeek
            if endOfMonth < endDate {
                endDate = endOfMonth
            }
            
            ranges += [(date, endDate)]
            date = endDate.startOfAdjacentDay(offset: .forward)
        }
        return ranges
    }
    
    private var summedSeverities: [Int] {
        let ranges = ranges
        var values = [Int](repeating: 0, count: ranges.count)
        
        for data in reportData where data.date >= Date().startOfMonth {
            ranges.enumerated().forEach { index, range in
                if data.date >= range.0 && data.date <= range.1 {
                    values[index] += Int(data.symptoms.map { $0.severity }.reduce(0, +))
                }
            }
        }
        
        return values
    }
    
    private func color(forWeek week: Int) -> Color {
        switch week {
        case 0:
            return Color(#colorLiteral(red: 0.6671229601, green: 0.1596478224, blue: 0.1696583331, alpha: 1))
        case 1:
            return Color(#colorLiteral(red: 0.6952038407, green: 0.4575328231, blue: 0.1743277311, alpha: 1))
        case 2:
            return Color(#colorLiteral(red: 0.7056599855, green: 0.6749765277, blue: 0.3466123939, alpha: 1))
        case 3:
            return Color(#colorLiteral(red: 0.232246995, green: 0.5231903195, blue: 0.647739172, alpha: 1))
        case 4:
            return Color(#colorLiteral(red: 0.4436366856, green: 0.6058051586, blue: 0.3097212613, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.4391640723, green: 0.2512674332, blue: 0.8874402046, alpha: 1))
        }
    }
}

struct MonthGraphView_Previews: PreviewProvider {
    static var previews: some View {
        MonthGraphView(reportData: [])
    }
}
