//
//  OnboardingFinalizingViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/7/21.
//

import UIKit
import GainyAPI
import GainyCommon

final class OnboardingFinalizingViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?
    weak var mainCoordinator: MainCoordinator?
    weak var authorizationManager: AuthorizationManager?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if self.mainCoordinator != nil {
            if UserProfileManager.shared.isOnboarded {
                self.finalizeOnboardingFlow()
            } else {
                self.updateAppProfileScoringSettings()
            }
        } else {
            self.finalizeAuthorizationFlow()
        }
        GainyAnalytics.logEvent("questioner_done", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
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
            NotificationManager.shared.showError("Sorry... Failed to sync your answers, please try again later.", report: true)
            return
        }
        
        GainyAnalytics.logEvent("update_scoring_settings", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
        
        let query = UpdateProfileScoringSettingsWithInterestsMutation(profileID:profileID,
                                                            averageMarketReturn: onboardingInfo.averageMarketReturn,
                                                            damageOfFailure: Double(onboardingInfo.damageOfFailure),
                                                            marketLoss20: Double(onboardingInfo.ifMarketDrops20IWillBuy),
                                                            marketLoss40: Double(onboardingInfo.ifMarketDrops40IWillBuy),
                                                            investemtHorizon: Double(onboardingInfo.investmentHorizon),
                                                            riskLevel: Double(onboardingInfo.riskLevel),
                                                            stockMarketRiskLevel: onboardingInfo.stockMarketRiskLevel,
                                                            tradingExperience: onboardingInfo.tradingExperience,
                                                            unexpectedPurchaseSource: onboardingInfo.unexpectedPurchasesSource, interests: onboardingInfo.profileInterestIDs)
        Network.shared.apollo.clearCache()
        Network.shared.apollo.perform(mutation: query) { result in
            
            guard let data = (try? result.get().data) else {
                GainyAnalytics.logEvent("update_scoring_settings_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
                NotificationManager.shared.showError("Sorry... Failed to sync your answers, please try again later.", report: true)
                self.dismiss(animated: true, completion: nil)
                return
            }
            let recSettingsOutput = data.resultMap["set_recommendation_settings"]
            let scoringSettingsOutput = data.resultMap["insert_app_profile_scoring_settings_one"]
            
            GainyAnalytics.logEvent("update_scoring_settings_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
            NotificationCenter.default.post(name: NSNotification.Name.didUpdateScoringSettings, object: nil)
            
            UserProfileManager.shared.getProfileCollections(loadProfile: true, forceReload: true) { _  in
                runOnMain { [weak self] in
                    self?.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: Notification.Name.init("startProfileTabUpdateNotification"), object: nil)
                    })
                }
            }
        }
    }
    
    private func updateAppProfileScoringSettings() {
    
        guard let onboardingInfo = self.mainCoordinator?.onboardingInfoBuilder.buildOnboardingInfo(),
              let profileID = UserProfileManager.shared.profileID else {
            self.dismiss(animated: true, completion: nil)
            NotificationManager.shared.showError("Sorry... Failed to sync your answers, please try again later.", report: true)
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
                NotificationManager.shared.showError("Sorry... Failed to sync your answers, please try again later.", report: true)
                self.dismiss(animated: true, completion: nil)
                return
            }
            GainyAnalytics.logEvent("update_scoring_settings_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
            NotificationCenter.default.post(name: NSNotification.Name.didUpdateScoringSettings, object: nil)
            
            UserProfileManager.shared.getProfileCollections(loadProfile: true, forceReload: true) { _  in
                runOnMain { [weak self] in
                    self?.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: Notification.Name.init("startProfileTabUpdateNotification"), object: nil)
                    })
                }
            }
        }
    }
    
    private func finalizeAuthorizationFlow() {
        
        guard let profileInfoBuilder = self.coordinator?.profileInfoBuilder else {
            self.coordinator?.dismissModule()
            self.coordinator?.popToRootModule()
            NotificationManager.shared.showError("Sorry... Failed to finalize the authorization. Please try again later.", report: true)
            return
        }
        
        GainyAnalytics.logEvent("finalizing_create_profile", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
        self.coordinator?.profileInfoBuilder.userID = self.authorizationManager?.userID()
        self.authorizationManager?.finalizeSignUpNoOnboarding(profileInfoBuilder: profileInfoBuilder, completion: { authorizationStatus in
            
            if authorizationStatus == .authorizedFully {
                UserProfileManager.shared.isFromOnboard = true
                self.coordinator?.dismissModule(animated: true, completion: {
                    if let finishFlow = self.coordinator?.finishFlow {
                        finishFlow()
                    }
                })
                GainyAnalytics.logEvent("finalizing_profile_created", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
                return
            }
            let haveNetwork = self.haveNetwork
            self.coordinator?.dismissModule(animated: true, completion: {
                if authorizationStatus == .authorizingFailed_EmailAlreadyInUse {
                    GainyAnalytics.logEvent("finalizing_failed_email_in_use", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
                    NotificationManager.shared.showError("Entered email is already in use. Please try another one - or sign in using different account.", report: true)
                } else if !haveNetwork{
                    GainyAnalytics.logEvent("finalizing_failed_no_internet", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
                    NotificationManager.shared.showError("No Internet connection. Please connect to the Internet and try again.", report: true)
                } else {
                    NotificationManager.shared.showError("Sorry... Something went wrong, please try again later.", report: true)
                    GainyAnalytics.logEvent("finalizing_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationFinalizing"])
                }
            })
            
        })
    }
}
