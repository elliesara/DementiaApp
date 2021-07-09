//
//  SSymptomListEntity.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/8/21.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import Foundation
import CoreData

public class SSymptomListEntity: NSManagedObject, Identifiable {
    @NSManaged public var sName: String
    @NSManaged public var sState: Bool
}

extension SSymptomListEntity {
    static func getSSymptomList() -> NSFetchRequest<SSymptomListEntity> {
        let request: NSFetchRequest<SSymptomListEntity> = SSymptomListEntity.fetchRequest() as! NSFetchRequest<SSymptomListEntity>
        let sortDescriptor  = NSSortDescriptor(key: "sName", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
