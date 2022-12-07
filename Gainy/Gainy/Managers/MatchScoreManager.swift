//
//  MatchScoreManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.04.2022.
//

import UIKit

/// MatchScore layout settings
struct MatchScoreManager {
    
    /// Color of text for MS
    /// - Parameter matchScore: MS
    /// - Returns: UIColor for MS
    static func textColorFor(_ matchScore: Int) -> UIColor {
        guard UserProfileManager.shared.isOnboarded else {
            return UIColor.Gainy.mainText!
        }
        switch matchScore {
        case 0..<35:
            return UIColor.Gainy.mainText!
        case 35..<65:
            return UIColor.Gainy.mainText!
        case 65...:
            return UIColor.Gainy.mainText!
        default:
            return UIColor.Gainy.mainText!
        }
    }
    
    /// Circle color for MS
    /// - Parameter matchScore: MS
    /// - Returns: UIColor for MS
    static func circleColorFor(_ matchScore: Int) -> UIColor {
        guard UserProfileManager.shared.isOnboarded else {
            return UIColor(hexString: "3BF06E")!
        }
        switch matchScore {
        case 0..<35:
            return UIColor(hexString: "E7EAEE")!
        case 35..<65:
            return UIColor(hexString: "E7EAEE")!
        case 65...:
            return UIColor(hexString: "3BF06E")!
        default:
            return UIColor(hexString: "E7EAEE")!
        }
    }
    
    static func backColorFor(_ matchScore: Int) -> UIColor {
        guard UserProfileManager.shared.isOnboarded else {
            return UIColor(hexString: "38CF92")!
        }
        switch matchScore {
        case 0..<35:
            return UIColor(hexString: "E7EAEE")!
        case 35..<65:
            return UIColor(hexString: "E7EAEE")!
        case 65...:
            return UIColor(hexString: "38CF92")!
        default:
            return UIColor(hexString: "E7EAEE")!
        }
    }
}
