//
//  UIFont+Gainy.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit
import SwiftUI

extension UIFont {
    
    static let defaultSize: CGFloat = 14.0
    
    //MARK: - Compact Rounded
    static func compactRoundedMedium(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFCompactRounded-Medium", size: size)!
    }
    
    static func compactRoundedRegular(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFCompactRounded-Regular", size: size)!
    }
    
    static func compactRoundedSemibold(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFCompactRounded-Semibold", size: size)!
    }
    
    //MARK: - Pro Display
    static func proDisplayRegular(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFProDisplay-Regular", size: size)!
    }
    
    static func proDisplaySemibold(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFProDisplay-Semibold", size: size)!
    }
    
    static func proDisplayBold(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFProDisplay-Bold", size: size)!
    }
}

extension UIFont {
    var uiFont: Font {
        Font(self as CTFont)
    }
}
