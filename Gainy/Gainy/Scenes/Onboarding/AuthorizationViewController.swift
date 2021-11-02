//
//  AuthorizationViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/16/21.
//

import UIKit

final class AuthorizationViewController: BaseViewController {
    
    @IBOutlet private weak var enterWithAppleButton: BorderButton!
    @IBOutlet private weak var enterWithGoogleButton: BorderButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    weak var coordinator: OnboardingCoordinator?
    weak var authorizationManager: AuthorizationManager?
    
    public var onboardingDone: Bool?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpNavigationBar()
        self.setUpContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func enterWithAppleButtonTap(_ sender: Any) {
        
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        showNetworkLoader()
        GainyAnalytics.logEvent("enter_with_apple_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        self.authorizationManager?.authorizeWithApple(completion: { authorizationStatus in
            DispatchQueue.main.async { [weak self] in
                self?.handleAuthorizationStatus(authorizationStatus: authorizationStatus)
            }
        })
    }
    
    @IBAction func enterWithGoogleButtonTap(_ sender: Any) {
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        showNetworkLoader()
        GainyAnalytics.logEvent("enter_with_google_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        self.authorizationManager?.authorizeWithGoogle(self, completion: { authorizationStatus in
            DispatchQueue.main.async { [weak self] in
                self?.handleAuthorizationStatus(authorizationStatus: authorizationStatus)
            }
        })
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("authorization_close_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        self.coordinator?.dismissModule()
    }
    
    private func handleAuthorizationStatus(authorizationStatus: AuthorizationStatus) {
        
        self.hideLoader()
        if authorizationStatus == .authorizedFully {
            GainyAnalytics.logEvent("authorization_fully_authorized", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
            if let finishFlow = self.coordinator?.finishFlow {
                self.coordinator?.dismissModule()
                finishFlow()
            }
        } else if authorizationStatus == .authorizedNeedCreateProfile {
            GainyAnalytics.logEvent("authorization_need_create_profile", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
            self.coordinator?.pushPersonalInfoViewController(isOnboardingDone: self.onboardingDone)
        } else if authorizationStatus != .authorizingCancelled {
            GainyAnalytics.logEvent("authorization_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
            NotificationManager.shared.showError("Sorry... Failed to authorize. Please try again later.")
        }
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = NSLocalizedString("Welcome on board", comment: "Welcome on board").uppercased()
   
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItems = [closeItem]
    }
    
    private func setUpContent() {
        
        self.enterWithAppleButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
        self.enterWithGoogleButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
        
        var title = NSLocalizedString("Hi there!", comment: "Hi there!")
        if self.onboardingDone != nil {
            title = NSLocalizedString("Almost done!", comment: "Almost done!")
        }
        self.titleLabel.text = title
    }
    
}
