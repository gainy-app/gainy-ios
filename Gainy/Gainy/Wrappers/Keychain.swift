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

@propertyWrapper
struct KeychainDate {
    let key: String
    init(_ key: String) {
        self.key = key
    }
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = ""
        return df
    }()

    var wrappedValue: Date? {
        mutating get {
            return dateFormatter.date(from: GainyKeychain.shared[self.key] ?? "")
        }
        set {
            if let newValue = newValue {
                GainyKeychain.shared[self.key] = dateFormatter.string(from: newValue)
            }
        }
    }
}
