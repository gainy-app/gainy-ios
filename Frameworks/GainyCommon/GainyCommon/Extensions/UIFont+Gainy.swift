//
//  UIFont+Gainy.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit
import SwiftUI

extension UIFont {
    
    public  static let defaultSize: CGFloat = 14.0
    
    //MARK: - Compact Rounded
    public static func compactRoundedMedium(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFCompactRounded-Medium", size: size)!
    }
    
    public static func compactRoundedRegular(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFCompactRounded-Regular", size: size)!
    }
    
    public static func compactRoundedSemibold(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFCompactRounded-Semibold", size: size)!
    }
    
    //MARK: - Pro Display
    public static func proDisplayRegular(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFProDisplay-Regular", size: size)!
    }
    
    public static func proDisplayMedium(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFProDisplay-Medium", size: size)!
    }
    
    public static func proDisplaySemibold(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFProDisplay-Semibold", size: size)!
    }
    
    public static func proDisplayBold(_ size: CGFloat = defaultSize) -> UIFont {
        UIFont.init(name: "SFProDisplay-Bold", size: size)!
    }
}

extension UIFont {
    public var uiFont: Font {
        Font(self as CTFont)
    }
}
