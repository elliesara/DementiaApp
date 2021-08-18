//
//  SocialSymptoms.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/10/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct SSymptomsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingActionSheet = false
    @State private var selectedSymptom: SymptomSelection?
    
    @State private var symptoms: [SymptomSelection] = []
    @State private var newSymptom: Bool = false
    private let symptomsSeverities = ["None", "Mild", "Moderate", "Severe", "Deadly"]
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                
                ZStack {
                    Color(#colorLiteral(red: 0.7568627451, green: 0.8426002264, blue: 0.8870300651, alpha: 1)).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        Text("\"How are you feeling today?\"")
                            .font(.headline)
                            .italic()
                            .padding()
                        
                        List {
                            ForEach(symptoms) { symptom in
                                HStack {
                                    if #available(iOS 14.0, *) {
                                        Menu {
                                            ForEach(symptomsSeverities.indices) { index in
                                                Button(symptomsSeverities[index]) {
                                                    onSeveritySelection(severityIndex: index, symptom: symptom)
                                                }
                                            }
                                        } label: {
                                            row(for: symptom)
                                        }
                                    } else {
                                        row(for: symptom)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                showingActionSheet = true
                                                selectedSymptom = symptom
                                            }
                                    }
                                }
                                .listRowBackground(Color.clear)
                            }
                            .onDelete { i in
                                let symptomName = symptoms[i.first!].name
                                if let deleteSymptom = symptomsEntities.first(where: { $0.sName == symptomName }) {
                                    self.managedObjectContext.delete(deleteSymptom)
                                    CoreDataManager.shared.saveContext()
                                    symptoms.remove(at: i.first!)
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width*0.9)
                        
                        Button(action: {
                            self.newSymptom = true
                        }) {
                            NewSymptomButtonView(geometry: geometry)
                        }.sheet(isPresented: self.$newSymptom, onDismiss: {
                            fetchSymptoms()
                        }) {
                            NewSymptom()
                                .environment(\.managedObjectContext, managedObjectContext)
                        }
                        
                        Spacer()
                    }
                    
                }
                .navigationBarTitle("Social Symptoms", displayMode: .inline)
                .navigationBarItems(leading: Button("Cancel") { self.presentationMode.wrappedValue.dismiss() },
                                    trailing: Button("Submit") {
                                                self.submitButton()
                                                self.presentationMode.wrappedValue.dismiss()
                                            }
                )
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Select severity"),
                                message: Text(selectedSymptom?.name ?? ""),
                                buttons: symptomsSeverities.indices.map { index in
                                    .default(Text(symptomsSeverities[index])) {
                                        onSeveritySelection(severityIndex: index, symptom: selectedSymptom!)
                                    }
                                })
                }
                .onAppear {
                    fetchSymptoms()
                }
                
            }
        }
    }
    
    private func row(for symptom: SymptomSelection) -> some View {
        HStack {
            if symptom.checked {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5492870212, blue: 1, alpha: 1)))
                    .font(.system(size: UIScreen.main.bounds.width*0.05))
            } else {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.9339778938, green: 0.9339778938, blue: 0.9339778938, alpha: 1)))
                    .font(.system(size: UIScreen.main.bounds.width*0.05))
            }
            Text(symptom.name)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
            Spacer()
            Text(severityText(for: symptom))
                .padding(5)
                .background(Color(severityColor(for: symptom)))
                .cornerRadius(5)
                .foregroundColor(.white)
                .frame(minWidth: 90)
        }
    }
    
    private func severityText(for symptom: SymptomSelection) -> String {
        let severity = symptom.severity ?? 0
        if severity == 0 {
            return "Severity"
        }
        return symptomsSeverities[severity]
    }
    
    private func severityColor(for symptom: SymptomSelection) -> UIColor {
        let severity = symptom.severity ?? 0
        switch severity {
        case 1:
            return #colorLiteral(red: 0.2216491533, green: 0.3751649105, blue: 0.8584440176, alpha: 1)
        case 2:
            return #colorLiteral(red: 0.1818526089, green: 0.2700923681, blue: 0.5435188413, alpha: 1)
        case 3:
            return #colorLiteral(red: 0.3910571039, green: 0.1766899824, blue: 0.1648342609, alpha: 1)
        case 4:
            return #colorLiteral(red: 0.7155836225, green: 0.2962410748, blue: 0.2824460268, alpha: 1)
        default:
            return UIColor.gray
        }
    }
    
    private func onSeveritySelection(severityIndex: Int, symptom: SymptomSelection) {
        guard let index = symptoms.firstIndex(where: { $0.id == symptom.id }) else {
            return
        }
        
        if severityIndex == 0 {
            symptoms[index].checked = false
            symptoms[index].severity = nil
            return
        }
        symptoms[index].checked = true
        symptoms[index].severity = severityIndex
        
    }
    
    private func submitButton() { /// func and var names are lowercase
        for symptom in symptoms where symptom.checked {
            let sSymptom = SSymptomEntity(context: self.managedObjectContext)
            sSymptom.sSymptomName = symptom.name
            sSymptom.sCreatedAt = Date()
            sSymptom.sCheckedState = true
            sSymptom.sSeverity = Int16(symptom.severity ?? 0)
        }
        
        CoreDataManager.shared.saveContext()
    }
    
    private func fetchSymptoms() {
        var newSymptoms = symptomsEntities.map { SymptomSelection(name: $0.sName, checked: false, severity: nil) }
        for symptom in symptoms where symptom.checked {
            if let index = newSymptoms.firstIndex(where: {$0.name == symptom.name}) {
                newSymptoms[index].checked = true
                newSymptoms[index].severity = symptom.severity
            }
        }
        
        symptoms = newSymptoms
    }
    
    private var symptomsEntities: [SSymptomListEntity] {
        let request = SSymptomListEntity.getSSymptomList()
        return try! managedObjectContext.fetch(request)
    }
    
}

struct SSymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        SSymptomsView()
    }
}
