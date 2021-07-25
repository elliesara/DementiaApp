//
//  PSymptomsViewTest.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 9/18/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct SymptomSelection: Identifiable {
    var id: String {
        name
    }
    
    let name: String
    var checked: Bool
    let severity: Int?
    
    
}

struct PSymptomsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: PSymptomListEntity.getPSymptomList()) var pSymptomsList: FetchedResults<PSymptomListEntity>
    @State private var symptoms: [SymptomSelection] = []
    @State private var newSymptom: Bool = false
    
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
                                        Spacer()
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        if let index = symptoms.firstIndex(where: { $0.id == symptom.id }) {
                                            symptoms[index].checked.toggle()
                                        }
                                    }
                                                                        
                                    // Button, that when tapped shows 3 options
                                    if #available(iOS 14.0, *) {
                                        Menu {
                                            ForEach(["None", "Mild", "Moderate", "Severe", "Deadly"], id: \.self) { severity in
                                                Button(severity) {
                                                    
                                                }
                                            }
                                        } label: {
                                            Text("Severity")
                                                .padding(5)
                                                .background(Color.gray)
                                                .cornerRadius(5)
                                                .foregroundColor(.white)
                                        }
                                    } else {
                                        Button(action: {
                                            print("button")
                                        }, label: {
                                            Text("Severity").padding(5)
                                        })
                                        .background(Color.gray)
                                        .cornerRadius(5)
                                    }
                                    
                                }
                                .listRowBackground(Color(#colorLiteral(red: 0.7568627451, green: 0.8426002264, blue: 0.8870300651, alpha: 0)))
                            }
                            .onDelete { i in
                                let symptomName = symptoms[i.first!].name
                                if let deleteSymptom = symptomsEntities.first(where: { $0.pName == symptomName }) {
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
                .navigationBarTitle("Physical Symptoms", displayMode: .inline)
                .navigationBarItems(leading: Button("Cancel") { self.presentationMode.wrappedValue.dismiss() },
                                    trailing: Button("Submit") {
                                                self.submitButton()
                                                self.presentationMode.wrappedValue.dismiss()
                                            }
                ).onAppear {
                    fetchSymptoms()
                }
                
            }
        }
    }
    
    private func submitButton() { /// func and var names are lowercase
        for symptom in symptoms where symptom.checked {
            let pSymptom = PSymptomEntity(context: self.managedObjectContext)
            pSymptom.pSymptomName = symptom.name
            pSymptom.pCreatedAt = Date()
            pSymptom.pCheckedState = true
        }
        
        CoreDataManager.shared.saveContext()
    }
    
    private func fetchSymptoms() {
        var newSymptoms = symptomsEntities.map { SymptomSelection(name: $0.pName, checked: false, severity: nil) }
        for symptom in symptoms where symptom.checked {
            if let index = newSymptoms.firstIndex(where: {$0.name == symptom.name}) {
                newSymptoms[index].checked = true
            }
        }
        
        symptoms = newSymptoms
    }
    
    private var symptomsEntities: [PSymptomListEntity] {
        let request = PSymptomListEntity.getPSymptomList()
        return try! managedObjectContext.fetch(request)
    }
    
}

struct PSymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        PSymptomsViewTest()
    }
}
