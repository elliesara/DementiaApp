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
    @State private var entries: [ReportData] = []
    
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
            .onAppear {
                loadEntries()
            }
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
                    DayGraphView(reportData: entries)
                    WeekGraphView(reportData: entries)
                    MonthGraphView(reportData: entries)
                }
                .frame(height: 250)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .tabViewStyle(PageTabViewStyle())
            } else {
                GeometryReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            DayGraphView(reportData: entries).frame(width: proxy.size.width)
                            WeekGraphView(reportData: entries).frame(width: proxy.size.width)
                            MonthGraphView(reportData: entries).frame(width: proxy.size.width)
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
    
    private func loadEntries() {
        let request = PSymptomEntity.getPSymptoms()
        let entities = try! managedObjectContext.fetch(request)
        
        entries = Dictionary(grouping: entities, by: { $0.pCreatedAt.startOfDay }).map { date, value in
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
