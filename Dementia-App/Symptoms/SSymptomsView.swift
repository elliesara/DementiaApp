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
    @State private var newSymptom: Bool = false
    
    private let sSymptoms = ["Inability to speak properly",
                             "Slurring",
                             "Inability to identify object",
                             "Difficulty forming sentences",
                             "Cognitive impairment",
                             "Hostile behavior",
                             "Isolation from others",
                             "Unhealthy reliance on others",
                             "Abnormal stress",
                             "Abnormal fatigue"]
    
    @State var sChecks = [false, false, false, false, false, false, false, false, false, false]
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                
                ZStack {
                    Color(#colorLiteral(red: 0.9529411765, green: 0.8804875016, blue: 0.7963053584, alpha: 1)).edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        
                        Text("Social Symptoms").font(.largeTitle).fontWeight(.bold).foregroundColor(Color(#colorLiteral(red: 0.2928513885, green: 0.2821008563, blue: 0.2951488495, alpha: 1)))
                        Text("Select all that apply").font(.caption).foregroundColor(Color.blue)
                            .padding(.top, geometry.size.height*0.013)
                        
                        List {
                            ForEach(0..<self.sChecks.count) { i in
                                HStack {
                                    Text(self.sSymptoms[i])
                                    Spacer()
                                    Button(action: {
                                        self.sChecks[i].toggle()
                                        print(self.sChecks[i])
                                    }) {
                                        if self.sChecks[i] {
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
                            }.listRowBackground(Color(#colorLiteral(red: 0.9529411765, green: 0.8804875016, blue: 0.7963053584, alpha: 1)))
                        }.foregroundColor(Color(#colorLiteral(red: 0.2928513885, green: 0.2821008563, blue: 0.2951488495, alpha: 1)))
                        .frame(width: UIScreen.main.bounds.width*0.9)
                        
                        Button(action: { self.newSymptom = true }) {
                            NewSymptomButtonView(geometry: geometry)
                        }.sheet(isPresented: self.$newSymptom) {
                            NewSymptom()
                                .environment(\.managedObjectContext, managedObjectContext)
                        }
                        
                        Spacer()
                        
                    }
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(leading:
                        Button("Cancel") { self.presentationMode.wrappedValue.dismiss() }, trailing:
                        Button("Submit") { self.submitButton() }
                    )
                }
                
            }
        }
    }
    
    func submitButton() {
        for i in 0..<sChecks.count {
            print("\(i): \(sChecks[i])")
            if sChecks[i] == true {
                let sSymptom = SSymptomEntity(context: self.managedObjectContext)
                sSymptom.sSymptomName = sSymptoms[i]
                sSymptom.sCreatedAt = Date()
                sSymptom.sCheckedState = sChecks[i]
                CoreDataManager.shared.saveContext()
            }
        }
    }
    
}

struct SSymptomsView_Previews: PreviewProvider {
    static var previews: some View {
        SSymptomsView()
    }
}
