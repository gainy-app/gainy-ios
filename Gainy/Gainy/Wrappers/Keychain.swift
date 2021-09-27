//
//  Keychain.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import Foundation

@propertyWrapper
struct KeychainString {
    let key: String
    init(_ key: String) {
        self.key = key
    }

    var wrappedValue: String? {
        get {
            return GainyKeychain.shared[self.key]
        }
        set {
            GainyKeychain.shared[self.key] = newValue
        }
    }
}
