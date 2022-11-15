//
//  UIImage+Bundle.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 20.09.2022.
//

import UIKit

extension UIImage {
    public convenience init?(name named: String) {
        self.init(named: named, in: Bundle(identifier: "app.gainy.framework.GainyCommon"), compatibleWith: nil)
    }
    
    public convenience init?(nameDW named: String) {
        self.init(named: named, in: Bundle(identifier: "app.gainy.framework.GainyDriveWealth"), compatibleWith: nil)
    }
}
