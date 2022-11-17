//
//  DriveWealthCoordinator.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 12.09.2022.
//

import UIKit
import GainyCommon
import FloatingPanel

public class DriveWealthCoordinator {
    
    public init(analytics: GainyAnalyticsProtocol, network: GainyNetworkProtocol, profile: GainyProfileProtocol) {
        self.navController = UINavigationController.init(rootViewController: UIViewController())
        self.navController.setNavigationBarHidden(true, animated: false)
        self.GainyAnalytics = analytics
        self.dwAPI = DWAPI(network: network, userProfile: profile)
        self.userProfile = profile
        self.kycDataSource = DWKYCDataSource()
        self.kycDataSource.dwAPI = self.dwAPI
        self.kycDataSource.profileID = profile.profileID
    }
        
    public enum Flow {
        case onboarding, deposit, withdraw, invest(collectionId: Int, name: String), buy(collectionId: Int, name: String), sell(collectionId: Int, name: String)
    }
    
    // MARK: - Inner
    public let navController: UINavigationController
    
    //MARK: - DI
    let GainyAnalytics: GainyAnalyticsProtocol
    let dwAPI: DWAPI
    let factory: DriveWealthFactory = DriveWealthFactory()
    let userProfile: GainyProfileProtocol
    let kycDataSource: DWKYCDataSource
    
    public func start(_ flow: Flow = .onboarding) {
        switch flow {
        case .onboarding:
            self.kycDataSource.profileID = userProfile.profileID
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
        case .buy(let collectionId, let name):
            navController.setViewControllers([factory.createInvestInputView(coordinator: self, collectionId: collectionId, name: name, mode: .buy)], animated: false)
            break
        case .sell(let collectionId, let name):
            navController.setViewControllers([factory.createInvestInputView(coordinator: self, collectionId: collectionId, name: name, mode: .sell)], animated: false)
            break
        }
    }
    
    func showSelectAccountView(dismissHandler: @escaping VoidHandler) {
        let fpc = FloatingPanelController()
        fpc.layout = SelectAccountPanelLayout()
        let appearance = SurfaceAppearance()

        // Define corner radius and background color
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear

        // Set the new appearance
        fpc.surfaceView.appearance = appearance

        // Set a content view controller.
        let vc = factory.createDepositSelectAccountView(coordinator: self)
        vc.dismissHandler = dismissHandler
        fpc.set(contentViewController: vc)
        fpc.isRemovalInteractionEnabled = true
        navController.present(fpc, animated: true)
    }
    
    class SelectAccountPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .half
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .half: FloatingPanelLayoutAnchor(absoluteInset: 360, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
        
        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            switch state {
            case .half: return 0.3
            default: return 0.0
            }
        }
    }
}

extension DriveWealthCoordinator: FloatingPanelControllerDelegate {
    
}

protocol DriveWealthCoordinated: AnyObject {
    var coordinator: DriveWealthCoordinator? {get set}
    
    var GainyAnalytics: GainyAnalyticsProtocol! {get set}
    var dwAPI: DWAPI! {get set}
}
