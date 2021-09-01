//
//  UserDefaults.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String

    var cachedObject: T?
    init(_ key: String) {
        self.key = key
    }

    var wrappedValue: T? {
        mutating get {
            if let cachedObject = cachedObject {
                return cachedObject
            }
            guard let arrayData = UserDefaults.standard.object(forKey: key) as? Data else {return nil}
            guard let value = try? JSONDecoder().decode(T.self, from: arrayData) else {return nil}
            self.cachedObject = value
            return value
        }
        set {
            cachedObject = newValue
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}
