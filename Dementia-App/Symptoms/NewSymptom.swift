//
//  NewSymptom.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/16/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct NewSymptom: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: PSymptomListEntity.getPSymptomList()) var pSymptomsList: FetchedResults<PSymptomListEntity>
    @State private var newSymptom: String = ""
    
    @State private var newSypmtomArr: [String] = []
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Color(#colorLiteral(red: 0.9568627477, green: 0.8000291185, blue: 0.7665636, alpha: 1)).edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    HStack {
                        
                        TextField("Enter new symptom name", text: $newSymptom)
                            .textFieldStyle(CustomTextFieldStyle())
                            .frame(width: UIScreen.main.bounds.width*0.7, height: UIScreen.main.bounds.height*0.04)
                        
                        Button(action: {
                            
                            self.newSypmtomArr.append(self.newSymptom)
                            
                            let pSymptom = PSymptomListEntity(context: self.managedObjectContext)
                            pSymptom.pName = newSymptom
                            pSymptom.pState = false
                            
                            CoreDataManager.shared.saveContext()
                            
                            self.newSymptom = ""
                            
                        }) {
                            
                            HStack(alignment: .center) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.width*0.1, height: UIScreen.main.bounds.height*0.02)
                            }
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.main.bounds.width*0.15, height: UIScreen.main.bounds.height*0.037)
                            .background(Color(#colorLiteral(red: 0, green: 0.5492870212, blue: 1, alpha: 1)))
                            
                        }
                        .cornerRadius(8)
                        .frame(width: UIScreen.main.bounds.width*0.15, height: UIScreen.main.bounds.height*0.037)
                        
                    }
                    
                    List {
                        ForEach(0..<self.newSypmtomArr.count, id:\.self) {
                            Text(self.newSypmtomArr[$0])
                        }.listRowBackground(Color(#colorLiteral(red: 0.9568627477, green: 0.8000291185, blue: 0.7665636, alpha: 1))) /// added
                    }
                    
                    Spacer()
                    
                }
                .navigationBarTitle("Add New Symptom", displayMode: .inline)
                .navigationBarItems(leading: Button("Cancel") { self.presentation.wrappedValue.dismiss() },
                                    trailing: Button("Done") { self.presentation.wrappedValue.dismiss() }
                                    
                )
                .padding()
                
            }
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.leading, UIScreen.main.bounds.width*0.03)
            .padding(.top, UIScreen.main.bounds.width*0.015)
            .padding(.bottom, UIScreen.main.bounds.width*0.015)
            .background(Color(#colorLiteral(red: 0.9339778938, green: 0.9339778938, blue: 0.9339778938, alpha: 1)))
            .cornerRadius(8)
    }
}

struct NewSymptom_Previews: PreviewProvider {
    static var previews: some View {
        NewSymptom()
    }
}
