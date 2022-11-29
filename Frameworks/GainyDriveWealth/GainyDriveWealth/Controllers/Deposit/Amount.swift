//
//  Amount.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 24.11.2022.
//

import UIKit

class Amount {
    var val: Double? {
        return Double("\(left)\(isDot ? "." : "")\(right)")
    }
    
    var valStr: String {
        if val != nil {
            if right.isEmpty {
                if isDot {
                    return "$\(amountFormatter.string(from: NSNumber(value: Double(left) ?? 0.0)) ?? "")."
                } else {
                    return "$\(amountFormatter.string(from: NSNumber(value: Double(left) ?? 0.0)) ?? "")"
                }
            } else {
                return "$\(amountFormatter.string(from: NSNumber(value: Double(left) ?? 0.0)) ?? "").\(right)"
            }
        } else {
            return "$"
        }
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        return formatter
    }()
    
    var left: String = ""
    
    var right: String = ""
    
    var isDot: Bool = false
    
    func addDigit(digit: String) {
        if isDot && digit == "." {
            return
        }
        if digit == "." && !isDot {
            if left.isEmpty {
                left += "0"
            }
            isDot = true
        } else {
            if isDot {
                right += digit
            } else {
                left += digit
            }
        }
    }
    
    func deleteDigit() {
        if !right.isEmpty {
            right = String(right.dropLast())
        } else {
            if isDot {
                isDot = false
            } else {
                left = String(left.dropLast())
            }
        }
    }
}
