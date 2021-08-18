//
//  MSymptomEntity.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/23/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import Foundation
import CoreData

public class MSymptomEntity: NSManagedObject, Identifiable {
    @NSManaged public var mCheckedState: Bool
    @NSManaged public var mCreatedAt: Date
    @NSManaged public var mSymptomName: String
    @NSManaged public var mSeverity: Int16
}

extension MSymptomEntity {
    static func getMSymptoms() -> NSFetchRequest<MSymptomEntity> {
        let request: NSFetchRequest<MSymptomEntity> = MSymptomEntity.fetchRequest() as! NSFetchRequest<MSymptomEntity>
        
        let sortDescriptor  = NSSortDescriptor(key: "mSymptomName", ascending: true)

        request.sortDescriptors = [sortDescriptor]

        return request
    }
}
