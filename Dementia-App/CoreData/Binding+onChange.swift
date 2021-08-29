//
//  Binding+onChange.swift
//  Dementia-App
//
//  Created by Jakub Machoń on 18/08/2021.
//  Copyright © 2021 Neuroscience Amador Valley. All rights reserved.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
