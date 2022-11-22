//
//  MutableCollection+Subscript.swift
//  GainyCommon
//
//  Created by Евгений Таран on 22.11.22.
//

import Foundation
import os.log

public extension MutableCollection {
    subscript(safe index: Index) -> Iterator.Element? {
        get {
            guard startIndex <= index && index < endIndex else { return nil }
            return self[index]
        }
        set(newValue) {
            guard startIndex <= index && index < endIndex else {
                os_log("Index out of range.")
                return
            }
            guard let newValue = newValue else {
                os_log("Cannot remove out of bounds items")
                return
            }
            self[index] = newValue
        }
    }
}
