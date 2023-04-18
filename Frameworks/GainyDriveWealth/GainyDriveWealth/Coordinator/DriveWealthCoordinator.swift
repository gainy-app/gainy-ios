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
import MessageUI

public class DriveWealthCoordinator {
    
    public init(analytics: GainyAnalyticsProtocol, network: GainyNetworkProtocol, profile: GainyProfileProtocol, remoteConfig: GainyRemoteConfigProtocol) {
        self.navController = UINavigationController.init(rootViewController: UIViewController())
        self.navController.setNavigationBarHidden(true, animated: false)
        self.GainyAnalytics = analytics
        self.dwAPI = DWAPI(network: network, userProfile: profile, analytics: analytics)
        self.userProfile = profile
        self.kycDataSource = DWKYCDataSource()
        self.kycDataSource.dwAPI = self.dwAPI
        self.kycDataSource.profileID = profile.profileID
        self.remoteConfig = remoteConfig
    }
    
    weak var parentCoordinator: DriveWealthCoordinator?
    
    public enum Flow {
        case onboarding,
             deposit,
             depositAmount(value: Double),
             withdraw,
             selectAccount(isNeedToDelete: Bool),
             
             investTTF(collectionId: Int, name: String),
             buyTTF(collectionId: Int, name: String),
             sellTTF(collectionId: Int, name: String, available: Double),
             
             investStock(symbol: String, name: String, type: String),
             buyStock(symbol: String, name: String, type: String),
             sellStock(symbol: String, name: String, available: Double, type: String),
             
             history(collectionId: Int, name: String, amount: Double),
             historyAll,
             historySpecific(history: [GainyTradingHistory]),
             
             addFundingAccount(profileId: Int),
             kycStatus(mode: DWOrderInvestSpaceStatus),
             detailedHistory(name: String, amount: Double, mode: DWHistoryOrderMode),
             biometryLogin(isValidEnter: BoolHandler),
             passwordSetup(dismissHandler: VoidHandler)
    }
    
    // MARK: - Inner
    public let navController: UINavigationController
    
    private(set) var childCoordinators: [DriveWealthCoordinator] = []
    
    func removeChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    // MARK: - Helpers
    public var linkHandler: Handler?
    
    //MARK: - DI
    public let dwAPI: DWAPI
    public let userProfile: GainyProfileProtocol
    public let remoteConfig: GainyRemoteConfigProtocol

    let GainyAnalytics: GainyAnalyticsProtocol
    let factory: DriveWealthFactory = DriveWealthFactory()
    let kycDataSource: DWKYCDataSource
    
    public func start(_ flow: Flow = .onboarding) {
        switch flow {
        case .onboarding:
            self.kycDataSource.profileID = userProfile.profileID
            
            //if let cache = self.kycDataSource.kycFormCache, cache.how_much_deposit != nil {
                navController.setViewControllers([factory.createKYCMainMenuView(coordinator: self)], animated: false)
//            } else {
//                navController.setViewControllers([factory.createKYCHowMuchDepositView(coordinator: self)], animated: false)
//            }
            break
        case .depositAmount(let value):
            let childCoord = DriveWealthCoordinator.init(analytics: self.GainyAnalytics, network: self.dwAPI.network, profile: self.userProfile, remoteConfig: self.remoteConfig)
            childCoordinators.append(childCoord)
            childCoord.parentCoordinator = self
            let depositVC = factory.createDepositInputView(coordinator: childCoord)
            childCoord.navController.isModalInPresentation = true
            depositVC.isModalInPresentation = true
            childCoord.navController.setViewControllers([depositVC], animated: false)
            navController.present(childCoord.navController, animated: true) {
                if value > 0.0 {
                    depositVC.loadValue(value)
                }
            }
            break
        case .deposit:
            navController.setViewControllers([factory.createDepositInputView(coordinator: self)], animated: false)
            break
        case .withdraw:
            navController.setViewControllers([factory.createWithdrawInputView(coordinator: self)], animated: false)
            break
            
        case .investTTF(let collectionId, let name):
            navController.setViewControllers([factory.createInvestInputView(coordinator: self, collectionId: collectionId, name: name)], animated: false)
            break
        case .buyTTF(let collectionId, let name):
            navController.setViewControllers([factory.createInvestInputView(coordinator: self, collectionId: collectionId, name: name, mode: .buy)], animated: false)
            break
        case .sellTTF(let collectionId, let name, let amount):
            navController.setViewControllers([factory.createInvestInputView(coordinator: self, collectionId: collectionId, name: name, mode: .sell, available: amount)], animated: false)
            break
        case .investStock(let symbol, let name, let type):
            navController.setViewControllers([factory.createStockInvestInputView(coordinator: self, symbol: symbol, name: name, tickerType: type)], animated: false)
            break
        case .buyStock(let symbol, let name, let type):
            navController.setViewControllers([factory.createStockInvestInputView(coordinator: self, symbol: symbol, name: name, tickerType: type, mode: .buy)], animated: false)
            break
        case .sellStock(let symbol, let name, let amount, let type):
            navController.setViewControllers([factory.createStockInvestInputView(coordinator: self, symbol: symbol, name: name, tickerType: type, mode: .sell, available: amount)], animated: false)
            break
            
        case .selectAccount(let isNeedToDelete):
            navController.setViewControllers([factory.createDepositSelectAccountView(coordinator: self, isNeedToDelete: isNeedToDelete)], animated: false)
            break
        case .history(let collectionId, let name, let amount):
            navController.setViewControllers([factory.createDWOrderHistoryView(coordinator: self, collectionId: collectionId, name: name, amount: amount)], animated: false)
            break
        case .historyAll:
            navController.setViewControllers([factory.createDWOrdersHistoryView(coordinator: self)], animated: false)
        case .historySpecific(let history):
            navController.setViewControllers([factory.createDWOrdersSpecificHistoryView(coordinator: self, history: history)], animated: false)
        case .addFundingAccount(let profileId):
            startFundingAccountLink(profileID: profileId, from: navController)
        case .kycStatus(let mode):
            navController.setViewControllers([factory.createInvestOrderSpaceView(coordinator: self, collectionId: 0, name: "", mode: mode)], animated: false)
        case .detailedHistory(let name, let amount, let mode):
            let vc = factory.createHistoryOrderDetailsView(coordinator: self, name: name)
            vc.amount = amount
            vc.name = name
            vc.mode = mode
            navController.setViewControllers([vc], animated: false)
        case .biometryLogin(let isValidEnter):
            navController.setViewControllers([factory.createFaceIdEnterView(coordinator: self, isValidEnter: isValidEnter)], animated: false)
        case .passwordSetup(let dismissHandler):
            navController.setViewControllers([factory.createKYCPasscodeView(coordinator: self, dismissHandler: dismissHandler)], animated: true)
        }
        self.navController.setNavigationBarHidden(true, animated: false)
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
    
    func showDepositCommissionView(dismissHandler: @escaping VoidHandler) {
        let vc = factory.createDepositComissionView(coordinator: self)
        vc.dismissHandler = dismissHandler
        showViewInPanel(vc: vc, layout: ComissionPanelLayout(height: 400.0), dismissHandler: dismissHandler)
        self.GainyAnalytics.logEventAMP("commission_structure_viewed")
    }
    
    func showSECView() {
        let vc = factory.createSECDisclaimerView(coordinator: self)
        showViewInPanel(vc: vc, layout: ComissionPanelLayout(height: 600.0), dismissHandler: nil)
        self.GainyAnalytics.logEventAMP("sec_info_viewed")
    }
    
    func showSSNDisclaimerView() {
        let vc = factory.createSSNDisclaimerView(coordinator: self)
        showViewInPanel(vc: vc, layout: ComissionPanelLayout(height: 560.0), dismissHandler: nil)
        self.GainyAnalytics.logEventAMP("sec_info_viewed")
    }
    
    class ComissionPanelLayout: FloatingPanelLayout {
        let height: CGFloat
        init(height: CGFloat) {
            self.height = height
        }
        
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .half
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .half: FloatingPanelLayoutAnchor(absoluteInset: height, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
        
        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            switch state {
            case .half: return 0.3
            default: return 0.0
            }
        }
    }
    
    private func showViewInPanel(vc: UIViewController, layout: FloatingPanelLayout, dismissHandler: VoidHandler?) {
        
        let fpc = FloatingPanelController()
        fpc.layout = layout
        let appearance = SurfaceAppearance()

        // Define corner radius and background color
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear

        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        
        // Set a content view controller.
        fpc.set(contentViewController: vc)
        fpc.isRemovalInteractionEnabled = true
        navController.present(fpc, animated: true)
    }
    
    //MARK: - KYC Status Navigation
    
    /// Show Deposit View
    func showDeposit() {
        navController.pushViewController(factory.createDepositInputView(coordinator: self), animated: true)
    }
    
    func showAddDocuments() {
        navController.pushViewController(factory.createAddDocumentsView(coordinator: self), animated: true)
    }
    
    func showUploadDocuments(with type: DocumentTypes, dismissHandler: ((DocumentTypes?) -> Void)?) {
        navController.pushViewController(factory.createUploadDocumentsView(coordinator: self, and: type, dismissHandler: dismissHandler), animated: true)
    }
    
    func showContactUs(delegate: MFMailComposeViewControllerDelegate) {
        GainyAnalytics.logEvent("profile_send_feedback_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "KYCRejected"])
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = delegate
            let recipientEmail = "support@gainy.app"
            mailComposer.setToRecipients([recipientEmail])
            navController.present(mailComposer, animated: true)
            
        } else if URL.init(string: "support@gainy.app") != nil {
            //WebPresenter.openLink(vc: self, url: emailUrl)
        }
    }
}


// MARK: - Funding Accounts
extension DriveWealthCoordinator {
    /// Start adding account from Plaid to Trade
    /// - Parameter profileID: current Profile ID
    func startFundingAccountLink(profileID: Int, from: UIViewController) {
        GainyAnalytics.logEvent("dw_plaid_link_pressed", params: nil)
        GainyAnalytics.logEventAMP("funding_acc_connect_s", params: ["location" : AnalyticsKeysHelper.shared.fundingAccountSource, "isAuto": AnalyticsKeysHelper.shared.fundingAccountAuto])
        showNetworkLoader()
        Task {
            do {
                let createdLinkToken = try await dwAPI.createPlaidLink()
                GainyAnalytics.logBFEvent("Create link done: \(createdLinkToken)")
                await MainActor.run {
                    presentPlaidLinkUsingLinkToken(profileID:profileID, linkToken: createdLinkToken)
                }
                
            } catch {
                GainyAnalytics.logBFEvent("Create link failed: \(error)")
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
                    
                    self.GainyAnalytics.logBFEvent("Link done: \(linkData.result)")
                    
                    if linkData.result {
                        await self.plaidLinked(token: linkData.plaidAccessTokenId ?? 0, instPrefix: linkData.institutionName ?? "", plaidAccounts: (linkData.accounts?.compactMap({$0}) ?? []))
                    } else {
                        await MainActor.run {
                            self.hideLoader()
                        }
                    }
                } catch {
                    self.GainyAnalytics.logBFEvent("linkPlaidToken failed: \(error)")
                    await MainActor.run {
                        self.hideLoader()
                    }
                }
            }
        }
        linkConfiguration.onExit = {[weak self] exit in
            if let error = exit.error {
                self?.GainyAnalytics.logBFEvent("exit with \(error)\n\(exit.metadata)")
                DispatchQueue.main.async {
                    self?.hideLoader()
                    self?.showAlert(error.localizedDescription)
                }
            } else {
                self?.GainyAnalytics.logEventAMP("funding_acc_connect_closed", params: ["location" : AnalyticsKeysHelper.shared.fundingAccountSource])
            }
            if exit.error != nil {
                DispatchQueue.main.async {
                    self?.hideLoader()
                }
            }
        }
        return linkConfiguration
    }
    
    /// Showing Plaid account which can be added as Trading
    /// - Parameters:
    ///   - token: Plaid token
    ///   - plaidAaccounts: Plaid accounts
    private func plaidLinked(token: Int, instPrefix: String, plaidAccounts: [PlaidAccountToLink]) async {
        var failedAccounts: [String] = []
        for plaidAccount in plaidAccounts {
            do {
                GainyAnalytics.logBFEvent("Connecting: \(plaidAccount)")
                let createdLinkToken = try await self.dwAPI.linkTradingAccount(accessToken: token, instPrefix: instPrefix, plaidAccount: plaidAccount)
                GainyAnalytics.logEvent("funding_acc_connected")
                
                GainyAnalytics.logEventAMP("funding_acc_connected", params: ["location" : AnalyticsKeysHelper.shared.fundingAccountSource])
                GainyAnalytics.logBFEvent("Funding account connected: \(plaidAccount.name) connected")
            } catch {
                failedAccounts.append("\(plaidAccount.name) - \(error.localizedDescription)")
                GainyAnalytics.logBFEvent("Connecting link failed: \(error)")
            }
        }
        if !failedAccounts.isEmpty {
            let msg = "Can't connect accounts:\n\(failedAccounts.joined(separator: ","))"
            await MainActor.run {
                self.hideLoader()
                self.showAlert(msg)
            }
        } else {
            await MainActor.run {
                self.hideLoader()
                
            }
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
            if let presented = navController.presentedViewController {
                handler.open(presentUsing: .viewController(presented))
            } else {
                handler.open(presentUsing: .viewController(navController))
            }
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
    
    private func showAlert(_ msg: String) {
        guard let vc = navController.viewControllers.last as? GainyBaseViewController else { return }
        let alertVC = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "OK", style: .destructive))
        if vc.presentedViewController != nil {
            vc.presentedViewController?.present(alertVC, animated: true)
        } else {
            vc.present(alertVC, animated: true)
        }
    }
}

protocol DriveWealthCoordinated: AnyObject {
    var coordinator: DriveWealthCoordinator? {get set}
    
    var GainyAnalytics: GainyAnalyticsProtocol! {get set}
    var dwAPI: DWAPI! {get set}
}
