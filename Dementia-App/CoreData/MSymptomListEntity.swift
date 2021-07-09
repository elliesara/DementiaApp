//
//  MSymptomListEntity.swift
//  Dementia-App
//
//  Created by Ellie Sara Huang on 7/8/21.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import Foundation
import CoreData

public class MSymptomListEntity: NSManagedObject, Identifiable {
    @NSManaged public var mName: String
    @NSManaged public var mState: Bool
}

extension MSymptomListEntity {
    static func getMSymptomList() -> NSFetchRequest<MSymptomListEntity> {
        let request: NSFetchRequest<MSymptomListEntity> = MSymptomListEntity.fetchRequest() as! NSFetchRequest<MSymptomListEntity>
        let sortDescriptor  = NSSortDescriptor(key: "mName", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
}
