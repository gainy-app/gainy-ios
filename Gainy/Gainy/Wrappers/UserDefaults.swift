//
//  UserDefaults.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit

@propertyWrapper
struct UserDefaultAuthorizationStatus {
    let key: String
    init(_ key: String) {
        self.key = key
    }

    var wrappedValue: AuthorizationStatus {
        get {
            let value = UserDefaults.standard.integer(forKey: key)
            return AuthorizationStatus(rawValue: value) ?? .none
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}
