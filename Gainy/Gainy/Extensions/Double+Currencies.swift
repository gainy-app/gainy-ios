//
//  Double+Currencies.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.08.2021.
//

import Foundation

extension Double {
    var price: String {
        guard self != 0.0 else {return ""}
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue.hasPrefix("-") ? "-$\(String(formattedValue.dropFirst()))" : "$\(formattedValue)"
    }
    
    var priceRaw: String {
        guard self != 0.0 else {return ""}
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue.hasPrefix("-") ? "$\(String(formattedValue.dropFirst()))" : "$\(formattedValue)"
    }
    
    var percent: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        
        let number = NSNumber(value: self * 100)
        let formattedValue = formatter.string(from: number)!
        if (self == 0.0) {
            return "\(formattedValue)%"
        }
        return "\(formattedValue)%".replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
    }
    
    
    var percentRaw: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = .current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        if (self == 0.0) {
            return "\(formattedValue)%"
        }
        return "\(formattedValue)%"
    }
    
    var percentRawUnsigned: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)%".replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
    }
    
    func formatUsingAbbrevation () -> String {
        let numFormatter = NumberFormatter()
        numFormatter.locale = .current
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
        numFormatter.maximumFractionDigits = 0
        numFormatter.numberStyle = .decimal
        
        if self < 0 {
            return "-$" + numFormatter.string(from: NSNumber(value:(value * -1.0)))!
        }
        return "$" + numFormatter.string(from: NSNumber(value:value))!
    }
}

extension Float {
    var price: String {
        guard self != 0.0 else {return ""}
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue.hasPrefix("-") ? "-$\(String(formattedValue.dropFirst()))" : "$\(formattedValue)"
    }
    
    var priceShort: String {
        guard self != 0.0 else {return ""}
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale.current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue.hasPrefix("-") ? "-$\(String(formattedValue.dropFirst()))" : "$\(formattedValue)"
    }
    
    var priceRaw: String {
        guard self != 0.0 else {return ""}
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue.hasPrefix("-") ? "$\(String(formattedValue.dropFirst()))" : "$\(formattedValue)"
    }
    
    var percent: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        let number = NSNumber(value: self * 100.0)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)%"
    }
    
    var percentUnsigned: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        let number = NSNumber(value: self * 100.0)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)%".replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
    }
    
    var percentRaw: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)%"
    }
    
    var percentRawUnsigned: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)%".replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "")
    }
    
    func formatUsingAbbrevation (_ usePrefix: Bool) -> String {
        let numFormatter = NumberFormatter()
        numFormatter.locale = .current
        
        typealias Abbrevation = (threshold:Float, divisor:Float, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (999_999_999.0, 1_000_000_000.0, "B")]
        // you can add more !
        let startValue = Float (abs(self))
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
        numFormatter.minimumIntegerDigits = 1
        if self > 1000 {
            numFormatter.minimumFractionDigits = 0
            numFormatter.maximumFractionDigits = 0
            numFormatter.allowsFloats = false
        } else {
            numFormatter.minimumFractionDigits = 1
            numFormatter.maximumFractionDigits = 2
            numFormatter.allowsFloats = true
        }
        
        let prefix = usePrefix ? "$" : ""
        if self < 0 {
            return "-" + prefix + numFormatter.string(from: NSNumber(value:(value * -1.0)))!
        }
        return prefix + numFormatter.string(from: NSNumber(value:value))!
    }
    
    func formatUsingAbbrevation () -> String {
        
        return formatUsingAbbrevation(true)
    }
}
