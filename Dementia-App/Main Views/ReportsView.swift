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
    @EnvironmentObject var appState: AppState
    @FetchRequest(fetchRequest: PSymptomEntity.getPSymptoms()) var physicalSymptoms: FetchedResults<PSymptomEntity>
    @FetchRequest(fetchRequest: MSymptomEntity.getMSymptoms()) var mentalSymptoms: FetchedResults<MSymptomEntity>
    @FetchRequest(fetchRequest: SSymptomEntity.getSSymptoms()) var socialSymptoms: FetchedResults<SSymptomEntity>
    
    @State private var expand = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack(alignment: .leading) {
                    
                    Text("Your Symptoms").font(.system(size: UIScreen.main.bounds.height*0.03)).fontWeight(.semibold).padding(.bottom)
                    
                    Button(action: { self.expand.toggle() }) {
                        HStack {
                            Text("Self-Care Deficit")
                            Image(systemName: expand ? "chevron.up" : "chevron.down")
                        }
                    }
                    
                    if expand {
                        ForEach(physicalSymptoms) { pSymptom in
                            PSymptomView(pSymptomName: pSymptom.pSymptomName, pCreatedAt: "\(pSymptom.pCreatedAt.shortMedium)").padding(.top)
                        }
                        ForEach(mentalSymptoms) { mSymptom in
                            MSymptomView(mSymptomName: mSymptom.mSymptomName, mCreatedAt: "\(mSymptom.mCreatedAt.shortMedium)").padding(.top)
                        }
                        ForEach(socialSymptoms) { sSymptom in
                            SSymptomView(sSymptomName: sSymptom.sSymptomName, sCreatedAt: "\(sSymptom.sCreatedAt.shortMedium)").padding(.top)
                        }
                    }
                    
                    /// RESETS DATA WITHIN APP (Only used for debugging purposes)
//                    Button("Reset data") {
//                        appState.reset = .reset
//                        let _ = MockedData()
//                    }
                    
                    
                }.navigationBarTitle("Reports")
                .padding(.bottom)
                .onAppear() {
                    CoreDataManager.shared.whereIsMySQLite()
                }
            }
        }
    }
}

struct ReportsView_Previews: PreviewProvider {
    static var previews: some View {
        ReportsView()
    }
}
