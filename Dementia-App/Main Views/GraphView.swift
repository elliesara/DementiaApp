//
//  GraphView.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 25/07/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct GraphData: Identifiable {
    var id: String {
        name
    }
    
    let value: Int
    let name: String
    let color: Color
}

struct GraphView: View {
    let data: [GraphData]

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { reader in
                HStack(alignment: .bottom) {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.9339778938, green: 0.9339778938, blue: 0.9339778938, alpha: 1)))
                        .frame(width: 2, height: reader.size.height)
                    
                    ForEach(data) { entry in
                        Spacer()
                        Rectangle()
                            .fill(entry.color)
                            .frame(width: barWidth, height: barHeight(for: entry) * 0.8 * reader.size.height)
                        Spacer()
                    }
                }
            }
            
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.9339778938, green: 0.9339778938, blue: 0.9339778938, alpha: 1)))
                .frame(height: 2)
            
            HStack {
                ForEach(data) { entry in
                    Spacer()
                    Text(entry.name)
                        .fixedSize()
                        .font(.footnote)
                        .foregroundColor(entry.color)
                        .frame(width: barWidth)
                    Spacer()
                }
            }.padding(.top, 5)
        }
    }
    
    private var barWidth: CGFloat {
        30
    }
    
    private func barHeight(for entry: GraphData) -> CGFloat {
        let max = CGFloat(data.map(\.value).max() ?? 0)
        return CGFloat(entry.value) / max
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(data: [
            GraphData(value: 4, name: "None", color: .red),
            GraphData(value: 3, name: "Mild", color: .orange),
            GraphData(value: 5, name: "Moderate", color: .yellow),
            GraphData(value: 2, name: "Severe", color: .blue),
            GraphData(value: 1, name: "Deadly", color: .purple),
        ]).frame(height: 200)
    }
}
