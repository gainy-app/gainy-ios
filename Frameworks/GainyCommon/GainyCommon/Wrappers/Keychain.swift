//
//  Keychain.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import Foundation

@propertyWrapper
public struct KeychainString {
    public let key: String
    public init(_ key: String) {
        self.key = key
    }

    public var wrappedValue: String? {
        get {
            return GainyKeychain.shared[self.key]
        }
        set {
            GainyKeychain.shared[self.key] = newValue
        }
    }
}

@propertyWrapper
public struct KeychainDate {
    public let key: String
    public init(_ key: String) {
        self.key = key
    }
    
    public lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
        return df
    }()

    public var wrappedValue: Date? {
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
