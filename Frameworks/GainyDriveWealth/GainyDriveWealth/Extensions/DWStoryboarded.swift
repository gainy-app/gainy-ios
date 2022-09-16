//
//  DWStoryboarded.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 11.09.2022.
//

import UIKit

enum DWStoryboard: String {
    case kyc = "KYC"
    case buy = "Buy"
    case withdraw = "Widthdraw"
    case deposit = "Deposit"
}

protocol DWStoryboarded { }

extension DWStoryboarded where Self: UIViewController {
    // Creates a view controller from our storyboard. This relies on view controllers having the same storyboard identifier as their class name. This method shouldn't be overridden in conforming types.
    static func instantiate(_ storyboard: DWStoryboard = .kyc ) -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue + (UIDevice.current.userInterfaceIdiom  == UIUserInterfaceIdiom.pad ? "-iPad" : ""), bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth"))
        
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
