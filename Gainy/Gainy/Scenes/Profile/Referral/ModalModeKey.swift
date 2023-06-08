//
//  ModalModeKey.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.06.2023.
//

import SwiftUI

struct ModalModeKey: EnvironmentKey {
    static let defaultValue = Binding<Bool>.constant(false) // < required
}

// define modalMode value
extension EnvironmentValues {
    var modalMode: Binding<Bool> {
        get {
            return self[ModalModeKey.self]
        }
        set {
            self[ModalModeKey.self] = newValue
        }
    }
}
