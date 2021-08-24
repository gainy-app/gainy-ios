//
//  Atomic.swift
//  Gainy
//
//  Created by Anton Gubarenko on 22.08.2021.
//

import Foundation

@propertyWrapper
struct Atomic<Value> {
    private let queue = DispatchQueue(label: "com.gainy.atomic")
    private var value: Value

    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Value {
        get {
            return queue.sync { value }
        }
        set {
            queue.sync { value = newValue }
        }
    }
}
