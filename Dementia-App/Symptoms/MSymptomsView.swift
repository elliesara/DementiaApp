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
    @State private var newSymptom: Bool = false
    private let mSymptoms = ["Disturbed thought process",
                             "Chronic confusion",
                             "Decreased ability to reason",
                             "Decreased attention span",
                             "Easy distractability",
                             "Lack of inhibition",
                             "Inappropriate social behavior",
                             "Paranoia",
                             "Explosive behavior",]
    @State var mChecks = [false, false, false, false]
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                
                ZStack {
                    Color(#colorLiteral(red: 0.7541411519, green: 0.8313546777, blue: 0.9701576829, alpha: 1)).edgesIgnoringSafeArea(.all)
                    
                    VStack() {
                        
                        Text("Mental Symptoms").fontWeight(.bold).font(.largeTitle).foregroundColor(Color(#colorLiteral(red: 0.2928513885, green: 0.2821008563, blue: 0.2951488495, alpha: 1)))
                        Text("Select all that apply").font(.caption).foregroundColor(Color.blue)
                            .padding(.top, geometry.size.height*0.013)
                        
                        List {
                            ForEach(0..<self.mChecks.count) { i in
                                HStack {
                                    Text(self.mSymptoms[i])
                                    Spacer()
                                    Button(action: {
                                        self.mChecks[i].toggle()
                                        print(self.mChecks[i])
                                    }) {
                                        if self.mChecks[i] {
                                            Image(systemName: "checkmark.square.fill")
                                                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5492870212, blue: 1, alpha: 1)))
                                                .font(.system(size: UIScreen.main.bounds.width*0.06))
                                        } else {
                                            Image(systemName: "square.fill")
                                                .foregroundColor(Color(#colorLiteral(red: 0.9339778938, green: 0.9339778938, blue: 0.9339778938, alpha: 1)))
                                                .font(.system(size: UIScreen.main.bounds.width*0.06))
                                        }
                                    }
                                }
                            }.listRowBackground(Color(#colorLiteral(red: 0.7541411519, green: 0.8313546777, blue: 0.9701576829, alpha: 1)))
                        }.foregroundColor(Color(#colorLiteral(red: 0.2928513885, green: 0.2821008563, blue: 0.2951488495, alpha: 1))).frame(width: UIScreen.main.bounds.width*0.9)
                        
                        Button(action: { self.newSymptom = true}) {
                            
                            HStack(alignment: .center) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.05,
                                           height: geometry.size.height * 0.05)
                                
                                Text("New Symptom")
                                    .font(.system(size: geometry.size.width * 0.048))
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .foregroundColor(Color(.white))
                            .frame(width: geometry.size.width * 0.5,
                                   height: geometry.size.height * 0.063)
                                .background(Color.blue)
                                .cornerRadius(10)
                            
                        }.sheet(isPresented: self.$newSymptom) {
                            NewSymptom()
                        }
                        
                        Spacer()
                    }.navigationBarItems(leading:
                        Button("Cancel") { self.presentationMode.wrappedValue.dismiss()}, trailing:
                        Button("Submit") { self.submitButton() }
                    )
                }
                
            }
        }
    }
    
    func submitButton() {
        for i in 0..<mChecks.count {
            print("\(i): \(mChecks[i])")
            if mChecks[i] == true {
                let mSymptom = MSymptomEntity(context: self.managedObjectContext)
                mSymptom.mSymptomName = mSymptoms[i]
                mSymptom.mCreatedAt = Date()
                mSymptom.mCheckedState = mChecks[i]
                CoreDataManager.shared.saveContext()
            }
        }
    }
}

struct MSymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        MSymptomsView()
    }
}
