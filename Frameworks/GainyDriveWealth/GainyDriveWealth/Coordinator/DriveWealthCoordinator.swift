//
//  DriveWealthCoordinator.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 12.09.2022.
//

import UIKit
import GainyCommon

public class DriveWealthCoordinator {
    
    public init(analytics: GainyAnalyticsProtocol, network: GainyNetworkProtocol, profile: GainyProfileProtocol) {
        self.navController = UINavigationController.init(rootViewController: UIViewController())
        self.navController.setNavigationBarHidden(true, animated: false)
        self.GainyAnalytics = analytics
        self.dwAPI = DWAPI(network: network, userProfile: profile)
        self.userProfile = profile
    }
    
    
    
    public enum Flow {
        case onboarding, deposit, withdraw, invest(collectionId: Int, name: String)
    }
    
    // MARK: - Inner
    public let navController: UINavigationController
    
    //MARK: - DI
    let GainyAnalytics: GainyAnalyticsProtocol
    let dwAPI: DWAPI
    let factory: DriveWealthFactory = DriveWealthFactory()
    let userProfile: GainyProfileProtocol
    
    public func start(_ flow: Flow = .onboarding) {
        switch flow {
        case .onboarding:
            navController.setViewControllers([factory.createKYCHowMuchDepositView(coordinator: self)], animated: false)
            break
        case .deposit:
            navController.setViewControllers([factory.createDepositInputView(coordinator: self)], animated: false)
            break
        case .withdraw:
            navController.setViewControllers([factory.createWithdrawInputView(coordinator: self)], animated: false)
            break
        case .invest(let collectionId, let name):
            navController.setViewControllers([factory.createInvestInputView(coordinator: self, collectionId: collectionId, name: name)], animated: false)
            break
        }
    }
}

protocol DriveWealthCoordinated: AnyObject {
    var coordinator: DriveWealthCoordinator? {get set}
    
    var GainyAnalytics: GainyAnalyticsProtocol! {get set}
    var dwAPI: DWAPI! {get set}
}
