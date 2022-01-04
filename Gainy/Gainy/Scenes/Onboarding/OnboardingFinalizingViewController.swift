//
//  OnboardingFinalizingViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/7/21.
//

import UIKit

final class OnboardingFinalizingViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?
    weak var mainCoordinator: MainCoordinator?
    weak var authorizationManager: AuthorizationManager?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if self.mainCoordinator != nil {
            self.finalizeOnboardingFlow()
        } else {
            self.finalizeAuthorizationFlow()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func finalizeOnboardingFlow() {
    
        guard let onboardingInfo = self.mainCoordinator?.onboardingInfoBuilder.buildOnboardingInfo(),
              let profileID = UserProfileManager.shared.profileID else {
            self.dismiss(animated: true, completion: nil)
            NotificationManager.shared.showError("Sorry... Failed to sync your answers, please try again later.")
            return
        }
        
        GainyAnalytics.logEvent("update_scoring_settings", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
        
        let query = UpdateAppProfileScoringSettingsMutation(profileID:profileID,
                                                            averageMarketReturn: onboardingInfo.averageMarketReturn,
                                                            damageOfFailure: Double(onboardingInfo.damageOfFailure),
                                                            marketLoss20: Double(onboardingInfo.ifMarketDrops20IWillBuy),
                                                            marketLoss40: Double(onboardingInfo.ifMarketDrops40IWillBuy),
                                                            investemtHorizon: Double(onboardingInfo.investmentHorizon),
                                                            riskLevel: Double(onboardingInfo.riskLevel),
                                                            stockMarketRiskLevel: onboardingInfo.stockMarketRiskLevel,
                                                            tradingExperience: onboardingInfo.tradingExperience,
                                                            unexpectedPurchaseSource: onboardingInfo.unexpectedPurchasesSource)
        Network.shared.apollo.clearCache()
        Network.shared.apollo.perform(mutation: query) { result in
            
            guard (try? result.get().data) != nil else {
                GainyAnalytics.logEvent("update_scoring_settings_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
                NotificationManager.shared.showError("Sorry... Failed to sync your answers, please try again later.")
                self.dismiss(animated: true, completion: nil)
                return
            }
            GainyAnalytics.logEvent("update_scoring_settings_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
            NotificationCenter.default.post(name: NSNotification.Name.didUpdateScoringSettings, object: nil)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func finalizeAuthorizationFlow() {
        
        guard let profileInfoBuilder = self.coordinator?.profileInfoBuilder,
              let onboardingInfoBuilder = self.coordinator?.onboardingInfoBuilder else {
            self.coordinator?.dismissModule()
            self.coordinator?.popToRootModule()
            NotificationManager.shared.showError("Sorry... Failed to finalize the authorization. Please try again later.")
            return
        }
        
        GainyAnalytics.logEvent("finalizing_create_profile", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
        self.coordinator?.profileInfoBuilder.userID = self.authorizationManager?.userID()
        self.authorizationManager?.finalizeSignUp(profileInfoBuilder: profileInfoBuilder, onboardingInfoBuilder: onboardingInfoBuilder, completion: { authorizationStatus in
            
            self.coordinator?.dismissModule()
            if authorizationStatus == .authorizedFully {
                if let finishFlow = self.coordinator?.finishFlow {
                    finishFlow()
                }
                GainyAnalytics.logEvent("finalizing_profile_created", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
            } else {
                GainyAnalytics.logEvent("finalizing_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
                self.coordinator?.popToRootModule()
                NotificationManager.shared.showError("Sorry... Failed to finalize the authorization. Please try again later.")
            }
        })
    }
}
