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
        Picker(selection: $symptomType, label: Text("Select the type of symptoms")) {
            Text("Physics").tag(0)
            Text("Mental").tag(1)
            Text("Social").tag(2)
        }
        .pickerStyle(SegmentedPickerStyle())
        .labelsHidden()
        .padding()
    }
    
    var entries: [ReportData] {
        let request = PSymptomEntity.getPSymptoms()
        let entities = try! managedObjectContext.fetch(request)
        
        return Dictionary(grouping: entities, by: { $0.pCreatedAt.startOfDay }).map { date, value in
            ReportData(date: date, symptoms: value)
        }.sorted(by: { $0.date > $1.date })
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
