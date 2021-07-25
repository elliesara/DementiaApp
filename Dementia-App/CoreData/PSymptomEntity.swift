//
//  PSymptomEntity.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/23/20.
//  Copyright © 2020 Neuroscience Amador Valley. All rights reserved.
//

import Foundation
import CoreData

public class PSymptomEntity: NSManagedObject, Identifiable {
    @NSManaged public var pSymptomName: String
    @NSManaged public var pCheckedState: Bool
    @NSManaged public var pCreatedAt: Date
    @NSManaged public var pSeverity: Int16
}

extension PSymptomEntity {
    static func getPSymptoms() -> NSFetchRequest<PSymptomEntity> {
        let request: NSFetchRequest<PSymptomEntity> = PSymptomEntity.fetchRequest() as! NSFetchRequest<PSymptomEntity>
        let sortDescriptor  = NSSortDescriptor(key: "pCreatedAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
