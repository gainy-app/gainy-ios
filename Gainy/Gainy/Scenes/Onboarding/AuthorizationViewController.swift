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
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!
    
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
            GainyAnalytics.logEvent("no_internet")
            return
        }
        showNetworkLoader()
        GainyAnalytics.logEvent("enter_with_apple_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        self.authorizationManager?.authorizeWithApple(completion: { authorizationStatus in
            runOnMain{
                self.handleAuthorizationStatus(authorizationStatus: authorizationStatus)
            }
        })
    }
    
    @IBAction func enterWithGoogleButtonTap(_ sender: Any) {
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            GainyAnalytics.logEvent("no_internet")
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
        self.coordinator?.popToRootModule()
    }
    
    @objc func backButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("authorization_back_button_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        self.coordinator?.popModule()
    }
    
    private func handleAuthorizationStatus(authorizationStatus: AuthorizationStatus) {
        
        self.hideLoader()
        if authorizationStatus == .authorizedFully {
            GainyAnalytics.logEvent("authorization_fully_authorized", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
            if let finishFlow = self.coordinator?.finishFlow {
                self.coordinator?.dismissModule()
                finishFlow()
            }
            if GainyAnalytics.shared.isLogin {
                GainyAnalytics.logEvent("login_success")
            }
        } else if authorizationStatus == .authorizedNeedCreateProfile {
            if let done = self.onboardingDone, done == true {
                GainyAnalytics.logEvent("authorization_need_create_profile", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
                self.coordinator?.pushPersonalInfoViewController()
            } else {
                self.coordinator?.pushIntroductionViewController()
            }
        } else if authorizationStatus != .authorizingCancelled {
            GainyAnalytics.logEvent("authorization_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
            NotificationManager.shared.showError("Sorry... Failed to authorize. Please try again later.")
        } else if authorizationStatus == .authorizingCancelled {
            GainyAnalytics.logEvent("authorization_cancelled", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "AuthorizationView"])
        }
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14),
                NSAttributedString.Key.kern: 1.25]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.title = NSLocalizedString("Introduction", comment: "Introduction").uppercased()
        let backImage = UIImage(named: "iconArrowLeft")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.navigationItem.rightBarButtonItems = [closeItem]
    }
    
    private func setUpContent() {
        
        self.enterWithAppleButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
        self.enterWithGoogleButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 16.0)
        
        var title = NSLocalizedString("Hi there!", comment: "Hi there!")
        self.imageView.image = UIImage.init(named: "sign-in-img")
        self.imageViewHeightConstraint.constant = 184.0
        if let done = self.onboardingDone, done == true {
            title = NSLocalizedString("Almost done!", comment: "Almost done!")
            self.imageView.image = UIImage.init(named: "sign-up-img")
            self.imageViewHeightConstraint.constant = 200.0
        }
        self.titleLabel.text = title
        
        
    }
    
}
