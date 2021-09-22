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
        
        self.authorizationManager?.authorizeWithApple(completion: { authorizationStatus in
            
            self.handleAuthorizationStatus(authorizationStatus: authorizationStatus)
        })
    }
    
    @IBAction func enterWithGoogleButtonTap(_ sender: Any) {
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        showNetworkLoader()
        self.authorizationManager?.authorizeWithGoogle(self, completion: { authorizationStatus in
            
            self.handleAuthorizationStatus(authorizationStatus: authorizationStatus)
        })
    }
    
    @IBAction func privacyPolicyTap(_ sender: Any) {
        
        if let url = URL(string: "https://www.gainy.app/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func termsOfServiceTap(_ sender: Any) {
        
        if let url = URL(string: "https://www.gainy.app/terms-of-service") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func closeButtonTap(sender: UIBarButtonItem) {
        
        self.coordinator?.dismissModule()
    }
    
    private func handleAuthorizationStatus(authorizationStatus: AuthorizationStatus) {
        
        self.hideLoader()
        if authorizationStatus == .authorizedFully {
            if let finishFlow = self.coordinator?.finishFlow {
                finishFlow()
            }
        } else if authorizationStatus == .authorizedNeedCreateProfile {
            self.coordinator?.pushPersonalInfoViewController(isOnboardingDone: self.onboardingDone)
        } else if authorizationStatus != .authorizingCancelled {
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
