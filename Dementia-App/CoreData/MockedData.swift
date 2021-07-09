//
//  MockedData.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 9/18/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

struct MockedData: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        if appState.reset == .reset {
            
            CoreDataManager.shared.deleteAllObjects(PSymptomEntity.self)
            CoreDataManager.shared.deleteAllObjects(PSymptomListEntity.self)
            CoreDataManager.shared.deleteAllObjects(MSymptomEntity.self)
            CoreDataManager.shared.deleteAllObjects(MSymptomListEntity.self)
            CoreDataManager.shared.deleteAllObjects(SSymptomEntity.self)
            CoreDataManager.shared.deleteAllObjects(SSymptomListEntity.self)
            
            let newPSymptom1 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom1.pName = "Having an unkempt appearance"
            newPSymptom1.pState = false
            
            let newPSymptom2 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom2.pName = "Inability to wash body"
            newPSymptom2.pState = false
            
            let newPSymptom3 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom3.pName = "Difficulty choosing clothing"
            newPSymptom3.pState = false
            
            let newPSymptom4 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom4.pName = "Difficulty brushing teeth"
            newPSymptom4.pState = false
            
            let newPSymptom5 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom5.pName = "Trouble wearing clothes"
            newPSymptom5.pState = false
            
            let newPSymptom6 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom6.pName = "Inability to sit on toilet"
            newPSymptom6.pState = false
            
            let newPSymptom7 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom7.pName = "Difficulty washing hands"
            newPSymptom7.pState = false
            
            let newPSymptom8 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom8.pName = "Inability to shave/comb hair"
            newPSymptom8.pState = false
            
            let newPSymptom9 = PSymptomListEntity(context: self.managedObjectContext)
            newPSymptom9.pName = "Convulsions"
            newPSymptom9.pState = false
            
            // <<< Mental Symptoms List >>>
            
            let newMSymptom1 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom1.mName = "Disturbed thought process"
            newMSymptom1.mState = false
            
            let newMSymptom2 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom2.mName = "Chronic confusion"
            newMSymptom2.mState = false
            
            let newMSymptom3 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom3.mName = "Decreased ability to reason"
            newMSymptom3.mState = false
            
            let newMSymptom4 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom4.mName = "Decreased attention span"
            newMSymptom4.mState = false
            
            let newMSymptom5 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom5.mName = "Easy distractability"
            newMSymptom5.mState = false
            
            let newMSymptom6 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom6.mName = "Lack of inhibition"
            newMSymptom6.mState = false
            
            let newMSymptom7 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom7.mName = "Inappropriate social behavior"
            newMSymptom7.mState = false
            
            let newMSymptom8 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom8.mName = "Paranoia"
            newMSymptom8.mState = false
            
            let newMSymptom9 = MSymptomListEntity(context: self.managedObjectContext)
            newMSymptom9.mName = "Explosive behavior"
            newMSymptom9.mState = false
            
            // <<< Social Symptoms List >>>
            
            let newSSymptom1 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom1.sName = "Inability to speak properly"
            newSSymptom1.sState = false
            
            let newSSymptom2 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom2.sName = "Slurring"
            newSSymptom2.sState = false
            
            let newSSymptom3 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom3.sName = "Inability to identify object"
            newSSymptom3.sState = false
            
            let newSSymptom4 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom4.sName = "Difficulty forming sentences"
            newSSymptom4.sState = false
            
            let newSSymptom5 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom5.sName = "Cognitive impairment"
            newSSymptom5.sState = false
            
            let newSSymptom6 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom6.sName = "Hostile behavior"
            newSSymptom6.sState = false
            
            let newSSymptom7 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom7.sName = "Isolation from others"
            newSSymptom7.sState = false
            
            let newSSymptom8 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom8.sName = "Unhealthy reliance on others"
            newSSymptom8.sState = false
            
            let newSSymptom9 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom9.sName = "Abnormal stress"
            newSSymptom9.sState = false
            
            let newSSymptom10 = SSymptomListEntity(context: self.managedObjectContext)
            newSSymptom10.sName = "Abnormal fatigue"
            newSSymptom10.sState = false
            
            CoreDataManager.shared.saveContext()
        }
        
        return(Text(""))
        
    }
}

struct MockedData_Previews: PreviewProvider {
    static var previews: some View {
        MockedData()
    }
}
