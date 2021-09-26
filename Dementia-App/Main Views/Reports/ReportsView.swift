//
//  ReportsView.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/10/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI
import CoreData

enum FilterType: Equatable {
    case severity(type: Int)
    case dayOfWeek(number: Int)
    case week(number: Int)
}

struct ReportsView: View {
    
    private static let graphHeight: CGFloat = 250
    
    @Environment(\.managedObjectContext) var managedObjectContext
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("E, d MMM yyyy")
        return formatter
    }()
    @State private var symptomType = 0
    @State private var listEntries: [ReportData] = []
    @State private var graphEntries: [ReportData] = []
    @State private var filter: FilterType?
    
    var body: some View {
        NavigationView {
            List {
                header
                ForEach(listEntries) { entry in
                    Section(header: header(for: entry)) {
                        ForEach(entry.symptoms, id: \.id) { (symptom: ReportSymptom) in
                            Text(symptom.name)
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
    
    private func setFilter(newFilter: FilterType) {
        if filter == newFilter {
            filter = nil
        } else {
            filter = newFilter
        }
        loadEntries()
    }
    
    private var header: some View {
        VStack {
            if #available(iOS 14.0, *) {
                TabView {
                    DayGraphView(reportData: graphEntries, onTap: { category in
                        setFilter(newFilter: .severity(type: category))
                    }).frame(height: ReportsView.graphHeight)
                    WeekGraphView(reportData: graphEntries, onTap: { day in
                        setFilter(newFilter: .dayOfWeek(number: day))
                    }).frame(height: ReportsView.graphHeight)
                    MonthGraphView(reportData: graphEntries, onTap: { week in
                        setFilter(newFilter: .week(number: week))
                    }).frame(height: ReportsView.graphHeight)
                }
                .frame(height: 350)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .tabViewStyle(PageTabViewStyle())
                .padding([.top], -30)
            } else {
                GeometryReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            DayGraphView(reportData: graphEntries, onTap: { category in
                                setFilter(newFilter: .severity(type: category))
                            }).frame(width: proxy.size.width, height: ReportsView.graphHeight)
                            WeekGraphView(reportData: graphEntries, onTap: { day in
                                setFilter(newFilter: .dayOfWeek(number: day))
                            }).frame(width: proxy.size.width, height: ReportsView.graphHeight)
                            MonthGraphView(reportData: graphEntries, onTap: { week in
                                setFilter(newFilter: .week(number: week))
                            }).frame(width: proxy.size.width, height: ReportsView.graphHeight)
                        }
                    }
                }.frame(height: 275)
            }
            
            Picker(selection: $symptomType.onChange(onSymptomTypeChange), label: Text("Select the type of symptoms")) {
                Text("Physics").tag(0)
                Text("Mental").tag(1)
                Text("Social").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .labelsHidden()
            .padding()
            .padding([.top], -25)
        }
    }
    
    private func onSymptomTypeChange(_ symptomType: Int) {
        loadEntries()
    }
    
    private func loadEntries() {
        print("filter: \(filter)")
        graphEntries = Dictionary(grouping: currentEntries, by: { $0.createdAt.startOfDay }).map { date, value in
            ReportData(date: date, symptoms: value)
        }.sorted(by: { $0.date > $1.date })
        
        setListEntries()
    }
    
    private var currentEntries: [ReportSymptom] {
        switch symptomType {
        case 0:
            let request = PSymptomEntity.getPSymptoms()
            return try! managedObjectContext.fetch(request)
        case 1:
            let request = MSymptomEntity.getMSymptoms()
            return try! managedObjectContext.fetch(request)
        case 2:
            let request = SSymptomEntity.getSSymptoms()
            return try! managedObjectContext.fetch(request)
        default:
            preconditionFailure("Unknown symptomType")
        }
    }
    
    private func setListEntries() {
        listEntries = graphEntries
        guard let filter = filter else { return }
        
        switch filter {
        case .severity(let type):
            break
        case .dayOfWeek(let number):
            break
        case .week(let number):
            break
        }
    }
}

struct ReportData: Identifiable {
    var id: Date {
        date
    }
    
    let date: Date
    let symptoms: [ReportSymptom]
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
    }
}
