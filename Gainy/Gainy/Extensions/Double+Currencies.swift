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

        let number = NSNumber(value: self * 100)
        let formattedValue = formatter.string(from: number)!
        if (self == 0.0) {
            return "\(formattedValue)%"
        }
        return "\(formattedValue)%"
    }
    
    var percentRaw: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.init(identifier: "en_US")

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        if (self == 0.0) {
            return "\(formattedValue)%"
        }
        return "\(formattedValue)%"
    }
    
    func formatUsingAbbrevation () -> String {
            let numFormatter = NumberFormatter()

            typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (999_999_999.0, 1_000_000_000.0, "B")]
                                               // you can add more !
            let startValue = Double (abs(self))
            let abbreviation:Abbrevation = {
                var prevAbbreviation = abbreviations[0]
                for tmpAbbreviation in abbreviations {
                    if (startValue < tmpAbbreviation.threshold) {
                        break
                    }
                    prevAbbreviation = tmpAbbreviation
                }
                return prevAbbreviation
            } ()

            let value = self / abbreviation.divisor
            numFormatter.positiveSuffix = abbreviation.suffix
            numFormatter.negativeSuffix = abbreviation.suffix
            numFormatter.allowsFloats = true
            numFormatter.minimumIntegerDigits = 1
            numFormatter.minimumFractionDigits = 0
            numFormatter.maximumFractionDigits = 2

        return "$" + numFormatter.string(from: NSNumber(value:value))!
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

        let number = NSNumber(value: self * 100.0)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)%"
    }
    
    var percentRaw: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.init(identifier: "en_US")

        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)%"
    }
    
    func formatUsingAbbrevation () -> String {
            let numFormatter = NumberFormatter()

            typealias Abbrevation = (threshold:Float, divisor:Float, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (999_999_999.0, 1_000_000_000.0, "B")]
                                               // you can add more !
            let startValue = self
            let abbreviation:Abbrevation = {
                var prevAbbreviation = abbreviations[0]
                for tmpAbbreviation in abbreviations {
                    if (startValue < tmpAbbreviation.threshold) {
                        break
                    }
                    prevAbbreviation = tmpAbbreviation
                }
                return prevAbbreviation
            } ()

            let value = self / abbreviation.divisor
            numFormatter.positiveSuffix = abbreviation.suffix
            numFormatter.negativeSuffix = abbreviation.suffix
            numFormatter.allowsFloats = true
            numFormatter.minimumIntegerDigits = 1
            numFormatter.minimumFractionDigits = 0
            numFormatter.maximumFractionDigits = 2

        return "$" + numFormatter.string(from: NSNumber(value:value))!
    }
}
