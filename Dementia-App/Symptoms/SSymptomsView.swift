//
//  SocialSymptoms.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/10/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct SSymptomsView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(fetchRequest: SSymptomListEntity.getSSymptomList()) var sSymptomsList: FetchedResults<SSymptomListEntity>
    @State private var newSymptom: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                
                ZStack {
                    Color(#colorLiteral(red: 0.7568627451, green: 0.8426002264, blue: 0.8870300651, alpha: 1)).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        Text("Social Symptoms").font(.largeTitle).fontWeight(.bold)
                        Text("Select all that apply").font(.caption).foregroundColor(Color.blue)
                            .padding(.top, geometry.size.height*0.013)
                        
                        List {
                            
                            ForEach(self.sSymptomsList) { sSymptom in
                                HStack {
                                    
                                    Text(sSymptom.sName)
                                    
                                    Spacer()
                                    
                                    if sSymptom.sState {
                                        Image(systemName: "checkmark.square.fill")
                                            .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5492870212, blue: 1, alpha: 1)))
                                            .font(.system(size: UIScreen.main.bounds.width*0.06))
                                    } else {
                                        Image(systemName: "square.fill")
                                            .foregroundColor(Color(#colorLiteral(red: 0.9339778938, green: 0.9339778938, blue: 0.9339778938, alpha: 1)))
                                            .font(.system(size: UIScreen.main.bounds.width*0.06))
                                    }
                                }.contentShape(Rectangle())
                                .onTapGesture {
                                    sSymptom.sState.toggle()
                                    print(sSymptom.sState)
                                }
                                .listRowBackground(Color(#colorLiteral(red: 0.7568627451, green: 0.8426002264, blue: 0.8870300651, alpha: 0)))
                            }
                            .onDelete { i in
                                let deleteSymptom = self.sSymptomsList[i.first!]
                                self.managedObjectContext.delete(deleteSymptom)
                                CoreDataManager.shared.saveContext()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width*0.9)
                        
                        Button(action: {
                            self.newSymptom = true
                        }) {
                            NewSymptomButtonView(geometry: geometry)
                        }.sheet(isPresented: self.$newSymptom) {
                            NewSymptom()
                                .environment(\.managedObjectContext, managedObjectContext)
                        }
                        
                        Spacer()
                    }
                    
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(leading: Button("Cancel") { self.presentationMode.wrappedValue.dismiss() },
                                    trailing: Button("Submit") {
                                                self.submitButton()
                                                self.presentationMode.wrappedValue.dismiss()
                                            }
                )
                
            }
        }
    }
    
    func submitButton() { /// func and var names are lowercase
        for i in 0..<sSymptomsList.count {
            if sSymptomsList[i].sState {
                let sSymptom = SSymptomEntity(context: self.managedObjectContext)
                sSymptom.sSymptomName = sSymptomsList[i].sName
                sSymptom.sCreatedAt = Date()
                sSymptom.sCheckedState = sSymptomsList[i].sState
            }
        }
        
        /// reset CheckMarks
        
        for i in 0..<sSymptomsList.count {
            sSymptomsList[i].sState = false
        }
        
        CoreDataManager.shared.saveContext()
    }
    
}

struct SSymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        SSymptomsView()
    }
}
