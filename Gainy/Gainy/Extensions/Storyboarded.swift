//
//  Storyboarded.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit

enum Storyboard: String {
    case onboarding = "Onboarding"
    case discovery = "Discovery"
    case portfolio = "Portfolio"
    case analytics = "Analytics"
    case profile = "Profile"
    case popups = "Popups"
}

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    // Creates a view controller from our storyboard. This relies on view controllers having the same storyboard identifier as their class name. This method shouldn't be overridden in conforming types.
    static func instantiate(_ storyboard: Storyboard = .discovery ) -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue + (UIDevice.current.userInterfaceIdiom  == UIUserInterfaceIdiom.pad ? "-iPad" : ""), bundle: Bundle.main)
        
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
