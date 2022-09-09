//
//  Atomic.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 09.09.2022.
//

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
