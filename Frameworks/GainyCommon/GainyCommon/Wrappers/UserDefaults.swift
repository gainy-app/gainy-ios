//
//  UserDefaults.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit

@propertyWrapper
public struct UserDefault<T: Codable> {
    public let key: String

    public var cachedObject: T?
    public init(_ key: String) {
        self.key = key
    }

    public var wrappedValue: T? {
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
        }
    }
}

@propertyWrapper
public struct UserDefaultBool {
    public let key: String
    public init(_ key: String) {
        self.key = key
    }

    public var wrappedValue: Bool {
        get {
            return UserDefaults.standard.bool(forKey: key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

@propertyWrapper
public struct UserDefaultArray<T: Codable> {
    public  let key: String
    
    public  init(key: String) {
        self.key = key
    }

    public  var wrappedValue: [T] {
        get {
            guard let arrayData = UserDefaults.standard.object(forKey: key) as? Data else {return []}
            guard let value = try? JSONDecoder().decode([T].self, from: arrayData) else {return []}
            return value
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
