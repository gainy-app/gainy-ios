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

    public var wrappedValue: Date? {
        mutating get {
            return AppDateFormatter.shared.date(from: GainyKeychain.shared[self.key] ?? "", dateFormat: .yyyMMddHHmmssZ)
        }
        set {
            if let newValue = newValue {
                GainyKeychain.shared[self.key] = AppDateFormatter.shared.string(from: newValue, dateFormat: .yyyMMddHHmmssZ)
            }
        }
    }
}
