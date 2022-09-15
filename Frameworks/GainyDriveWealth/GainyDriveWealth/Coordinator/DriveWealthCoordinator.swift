//
//  DriveWealthCoordinator.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 12.09.2022.
//

import UIKit
import GainyCommon

public class DriveWealthCoordinator {
    
    public init(analytics: GainyAnalyticsProtocol, network: GainyNetworkProtocol) {
        self.navController = UINavigationController.init(rootViewController: UIViewController())
        self.GainyAnalytics = analytics
        self.Network = network
    }
    
    
    
    public enum Flow {
        case onboarding, buy, sell, withdraw, transfer
    }
    
    // MARK: - Inner
    let navController: UINavigationController
    
    //MARK: - DI
    let GainyAnalytics: GainyAnalyticsProtocol
    let Network: GainyNetworkProtocol
    
    public func start(_ flow: Flow = .onboarding) {
        switch flow {
        case .onboarding:
            navController.setViewControllers([], animated: true)
            break
        case .buy:
            break
        case .sell:
            break
        case .withdraw:
            break
        case .transfer:
            break
        }
    }
}

protocol DriveWealthCoordinated: AnyObject {
    var coordinator: DriveWealthCoordinator? {get set}
    
    var GainyAnalytics: GainyAnalyticsProtocol! {get set}
    var Network: GainyNetworkProtocol! {get set}
}
