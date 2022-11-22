//
//  DriveWealthCoordinator.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 12.09.2022.
//

import UIKit
import GainyCommon
import FloatingPanel
import LinkKit
import Apollo
import GainyAPI

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
        case onboarding, deposit, withdraw, selectAccount(isNeedToDelete: Bool), invest(collectionId: Int, name: String), buy(collectionId: Int, name: String), sell(collectionId: Int, name: String), history(collectionId: Int, name: String, amount: Double)
    }
    
    // MARK: - Inner
    public let navController: UINavigationController
    
    // MARK: - Helpers
    private var linkHandler: Handler?
    
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
        case .selectAccount(let isNeedToDelete):
            navController.setViewControllers([factory.createDepositSelectAccountView(coordinator: self, isNeedToDelete: isNeedToDelete)], animated: false)
            break
        case .history(let collectionId, let name, let amount):
            navController.setViewControllers([createDWORderHistoryView(collectionId: collectionId, name: name, amount: amount)], animated: false)
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
    
    //MARK: - Shared views
    
    func createDWORderHistoryView(collectionId: Int, name: String, amount: Double) -> DWOrderDetailsViewController {
        let vc = factory.createInvestOrderDetailsView(coordinator: self, collectionId: collectionId, name: name)
        vc.collectionId = collectionId
        vc.amount = amount
        vc.name = name
        vc.mode = .history
        return vc
    }
}

extension DriveWealthCoordinator: FloatingPanelControllerDelegate {
    
}


// MARK: - Funding Accounts
extension DriveWealthCoordinator {
    /// Start adding account from Plaid to Trade
    /// - Parameter profileID: current Profile ID
    func startFundingAccountLink(profileID: Int, from: UIViewController) {
        GainyAnalytics.logEvent("dw_plaid_link_pressed", params: nil)
        
        showNetworkLoader()
        Task {
            do {
                let createdLinkToken = try await dwAPI.createPlaidLink()
                print("Create link done: \(createdLinkToken)")
                await MainActor.run {
                    presentPlaidLinkUsingLinkToken(profileID:profileID, linkToken: createdLinkToken)
                }
                
            } catch {
                print("Create link failed: \(error)")
                await MainActor.run {
                    hideLoader()
                }
            }
        }
    }
    
    func createLinkTokenConfiguration(profileID: Int, linkToken: String, reLink: Bool = false, accessTokenId: Int? = nil)  -> LinkTokenConfiguration {
        // With custom configuration using a link_token
        var linkConfiguration = LinkTokenConfiguration(token: linkToken) {[weak self] success in
            guard let self = self else { return }
            Task {
                do {
                    let linkData = try await self.dwAPI.linkPlaidToken(publicToken: success.publicToken)
                    print("Link done: \(linkData.result ?? false)")
                    
                    if linkData.result {
                       await self.plaidLinked(token: linkData.plaidAccessTokenId ?? 0, plaidAccounts: (linkData.accounts?.compactMap({$0}) ?? []))
                    } else {
                        await MainActor.run {
                            self.hideLoader()
                        }
                    }
                } catch {
                    print("Link failed: \(error)")
                    await MainActor.run {
                        self.hideLoader()
                    }
                }
            }
        }
        linkConfiguration.onExit = {[weak self] exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                print("exit with \(exit.metadata)")
            }
            DispatchQueue.main.async {
                self?.hideLoader()
            }
        }
        return linkConfiguration
    }
    
    /// Showing Plaid account which can be added as Trading
    /// - Parameters:
    ///   - token: Plaid token
    ///   - plaidAaccounts: Plaid accounts
    private func plaidLinked(token: Int, plaidAccounts: [PlaidAccountToLink]) async {
        for plaidAccount in plaidAccounts {
            do {
                let createdLinkToken = try await self.dwAPI.linkTradingAccount(accessToken: token, plaidAccount: plaidAccount)
            } catch {
                print("Create link failed: \(error)")
            }
        }
        await MainActor.run {
            self.hideLoader()
        }
    }
    
    // MARK: Start Plaid Link using a Link token
    // For details please see https://plaid.com/docs/#create-link-token
    func presentPlaidLinkUsingLinkToken(profileID: Int, linkToken: String, reLink: Bool = false, accessTokenId: Int? = nil) {
        let linkConfiguration = createLinkTokenConfiguration(profileID: profileID, linkToken: linkToken, reLink:reLink, accessTokenId:accessTokenId)
        let result = Plaid.create(linkConfiguration)
        
        switch result {
        case .failure(let error):
            break
        case .success(let handler):
            handler.open(presentUsing: .viewController(navController))
            linkHandler = handler
        }
    }
    
    private func showNetworkLoader() {
        guard let vc = navController.viewControllers.last as? GainyBaseViewController else { return }
        vc.showNetworkLoader()
    }
    
    private func hideLoader() {
        guard let vc = navController.viewControllers.last as? GainyBaseViewController else { return }
        vc.hideLoader()
    }
}

protocol DriveWealthCoordinated: AnyObject {
    var coordinator: DriveWealthCoordinator? {get set}
    
    var GainyAnalytics: GainyAnalyticsProtocol! {get set}
    var dwAPI: DWAPI! {get set}
}
