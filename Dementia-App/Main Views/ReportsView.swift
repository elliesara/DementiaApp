//
//  ReportsView.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/10/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct ReportsView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E, d MMM yyyy")
        return formatter
    }()
    @State private var symptomType = 0 {
        didSet {
            print(symptomType)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                header
                ForEach(entries) { entry in
                    Section(header: header(for: entry)) {
                        ForEach(entry.symptoms) { symptom in
                            Text(symptom.pSymptomName)
                        }
                    }
                }
            }
            .navigationBarTitle("Reports")
        }
    }
    
    private func header(for entry: ReportData) -> some View {
        Text(dateFormatter.string(from: entry.date))
            .padding([.top, .bottom])
    }
    
    private var header: some View {
        VStack {
            if #available(iOS 14.0, *) {
                TabView {
                    dayGraph
                    weekGraph
                    monthGraph
                }
                .frame(height: 250)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .tabViewStyle(PageTabViewStyle())
            } else {
                GeometryReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            dayGraph.frame(width: proxy.size.width)
                            weekGraph.frame(width: proxy.size.width)
                            monthGraph.frame(width: proxy.size.width)
                        }
                    }
                }.frame(height: 250)
            }
            
            Picker(selection: $symptomType, label: Text("Select the type of symptoms")) {
                Text("Physics").tag(0)
                Text("Mental").tag(1)
                Text("Social").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .labelsHidden()
            .padding()
        }
    }
    
    var entries: [ReportData] {
        let request = PSymptomEntity.getPSymptoms()
        let entities = try! managedObjectContext.fetch(request)
        
        return Dictionary(grouping: entities, by: { $0.pCreatedAt.startOfDay }).map { date, value in
            ReportData(date: date, symptoms: value)
        }.sorted(by: { $0.date > $1.date })
    }
    
    var dayGraph: some View {
        VStack(alignment: .leading) {
            Text("Day")
                .font(.title)
                .fontWeight(.bold)
            
            GraphView(data: [
                GraphData(value: 4, name: "None", color: Color(#colorLiteral(red: 0.6671229601, green: 0.1596478224, blue: 0.1696583331, alpha: 1))),
                GraphData(value: 3, name: "Mild", color: Color(#colorLiteral(red: 0.6952038407, green: 0.4575328231, blue: 0.1743277311, alpha: 1))),
                GraphData(value: 5, name: "Moderate", color: Color(#colorLiteral(red: 0.7056599855, green: 0.6749765277, blue: 0.3466123939, alpha: 1))),
                GraphData(value: 2, name: "Severe", color: Color(#colorLiteral(red: 0.232246995, green: 0.5231903195, blue: 0.647739172, alpha: 1))),
                GraphData(value: 1, name: "Deadly", color: Color(#colorLiteral(red: 0.6056969166, green: 0.2998026013, blue: 0.7654415965, alpha: 1))),
            ])
            .frame(height: 200)
            .padding([.leading, .trailing], 5)
        }
    }
    
    var weekGraph: some View {
        VStack(alignment: .leading) {
            Text("Week")
                .font(.title)
                .fontWeight(.bold)
            
            GraphView(data: [
                GraphData(value: 4, name: "Sun", color: Color(#colorLiteral(red: 0.6671229601, green: 0.1596478224, blue: 0.1696583331, alpha: 1))),
                GraphData(value: 3, name: "Mon", color: Color(#colorLiteral(red: 0.6952038407, green: 0.4575328231, blue: 0.1743277311, alpha: 1))),
                GraphData(value: 5, name: "Tue", color: Color(#colorLiteral(red: 0.7056599855, green: 0.6749765277, blue: 0.3466123939, alpha: 1))),
                GraphData(value: 2, name: "Wed", color: Color(#colorLiteral(red: 0.232246995, green: 0.5231903195, blue: 0.647739172, alpha: 1))),
                GraphData(value: 1, name: "Thu", color: Color(#colorLiteral(red: 0.6056969166, green: 0.2998026013, blue: 0.7654415965, alpha: 1))),
                GraphData(value: 1, name: "Fri", color: Color(#colorLiteral(red: 0.6056969166, green: 0.2998026013, blue: 0.7654415965, alpha: 1))),
                GraphData(value: 1, name: "Sat", color: Color(#colorLiteral(red: 0.6056969166, green: 0.2998026013, blue: 0.7654415965, alpha: 1))),
            ])
            .frame(height: 200)
            .padding([.leading, .trailing], 5)
        }
    }
    
    var monthGraph: some View {
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

struct ReportData: Identifiable {
    var id: Date {
        date
    }
    
    let date: Date
    let symptoms: [PSymptomEntity]
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
    }
}
