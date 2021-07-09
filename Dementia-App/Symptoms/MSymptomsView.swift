//
//  MSymptomsView.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/10/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct MSymptomsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(fetchRequest: MSymptomListEntity.getMSymptomList()) var mSymptomsList: FetchedResults<MSymptomListEntity>
    @State private var newSymptom: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                
                ZStack {
                    Color(#colorLiteral(red: 0.7568627451, green: 0.8426002264, blue: 0.8870300651, alpha: 1)).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        Text("Mental Symptoms").font(.largeTitle).fontWeight(.bold)
                        Text("Select all that apply").font(.caption).foregroundColor(Color.blue)
                            .padding(.top, geometry.size.height*0.013)
                        
                        List {
                            
                            ForEach(self.mSymptomsList) { mSymptom in
                                HStack {
                                    
                                    Text(mSymptom.mName)
                                    
                                    Spacer()
                                    
                                    if mSymptom.mState {
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
                                    mSymptom.mState.toggle()
                                    print(mSymptom.mState)
                                }
                                .listRowBackground(Color(#colorLiteral(red: 0.7568627451, green: 0.8426002264, blue: 0.8870300651, alpha: 0)))
                            }
                            .onDelete { i in
                                let deleteSymptom = self.mSymptomsList[i.first!]
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
        for i in 0..<mSymptomsList.count {
            if mSymptomsList[i].mState {
                let mSymptom = MSymptomEntity(context: self.managedObjectContext)
                mSymptom.mSymptomName = mSymptomsList[i].mName
                mSymptom.mCreatedAt = Date()
                mSymptom.mCheckedState = mSymptomsList[i].mState
            }
        }
        
        /// reset CheckMarks
        
        for i in 0..<mSymptomsList.count {
            mSymptomsList[i].mState = false
        }
        
        CoreDataManager.shared.saveContext()
    }
}

struct MSymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        MSymptomsView()
    }
}
