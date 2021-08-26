//
//  Double+Currencies.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.08.2021.
//

import Foundation

extension Double {
    var price: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.init(identifier: "en_US")

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)"
    }
    
    var percent: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.init(identifier: "en_US")

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(self > 0 ? "+" : "-")\(formattedValue)%"
    }
}

extension Float {
    var price: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.init(identifier: "en_US")

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "$\(formattedValue)"
    }
    
    var percent: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.init(identifier: "en_US")

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)%"
    }
}
