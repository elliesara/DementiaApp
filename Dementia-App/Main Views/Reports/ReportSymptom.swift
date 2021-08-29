//
//  ReportSymptom.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 27/08/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import Foundation
import CoreData

protocol ReportSymptom {
    var id: ObjectIdentifier { get }
    var name: String { get }
    var createdAt: Date { get }
    var severity: Int16 { get }
}

extension PSymptomEntity: ReportSymptom {
    var name: String { pSymptomName }
    var createdAt: Date { pCreatedAt }
    var severity: Int16 { pSeverity }
}

extension MSymptomEntity: ReportSymptom {
    var name: String { mSymptomName }
    var createdAt: Date { mCreatedAt }
    var severity: Int16 { mSeverity }
}

extension SSymptomEntity: ReportSymptom {
    var name: String { sSymptomName }
    var createdAt: Date { sCreatedAt }
    var severity: Int16 { sSeverity }
}
