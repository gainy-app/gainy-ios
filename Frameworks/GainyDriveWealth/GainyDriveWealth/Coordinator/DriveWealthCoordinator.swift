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
        self.navController.setNavigationBarHidden(true, animated: false)
        self.GainyAnalytics = analytics
        self.Network = network
    }
    
    
    
    public enum Flow {
        case onboarding, deposit, sell, withdraw, transfer
    }
    
    // MARK: - Inner
    public let navController: UINavigationController
    
    //MARK: - DI
    let GainyAnalytics: GainyAnalyticsProtocol
    let Network: GainyNetworkProtocol
    let factory: DriveWealthFactory = DriveWealthFactory()
    
    public func start(_ flow: Flow = .onboarding) {
        switch flow {
        case .onboarding:
            navController.setViewControllers([], animated: true)
            break
        case .deposit:
            navController.setViewControllers([factory.createDepositInputView(coordinator: self)], animated: true)
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
