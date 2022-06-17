//
//  PrivacyViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import UIKit
import SwiftUI

final class ProfileSubscriptionViewController: BaseViewController {
    
    weak var mainCoordinator: MainCoordinator?
    
    @IBOutlet private weak var refundBtn: BorderButton!
    @IBOutlet private weak var subscribeButton: BorderButton!
    @IBOutlet private weak var cancelSubscriptionButton: BorderButton! {
        didSet {
            cancelSubscriptionButton.layer.borderWidth = 2.0
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.setLineHeight(lineHeight: 32.0, textAlignment: .left)
            self.updateUI()
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            self.updateUI()
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpNavigationBar()
        self.updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.updateUI()
    }
    
    private func updateUI() {
        if let button = self.refundBtn {
            button.isHidden = true
        }
        SubscriptionManager.shared.getSubscription({[weak self] type in
            if type == .free {
                if let button = self?.subscribeButton {
                    button.isHidden = false
                }
                if let button = self?.cancelSubscriptionButton {
                    button.isHidden = true
                }
                if let label = self?.titleLabel {
                    label.text = "You don’t have any\nactive subscription"
                    label.sizeToFit()
                }
                if let label = self?.descriptionLabel {
                    label.text = "That’s not cool. Switch to Gainy Premium to see Match Score and composition for all TTFs. 😃"
                    label.setLineHeight(lineHeight: 24.0, textAlignment: .left)
                    label.sizeToFit()
                }
            } else {
                if let button = self?.subscribeButton {
                    button.isHidden = true
                }
                if let button = self?.cancelSubscriptionButton {
                    button.isHidden = false
                }
                if let label = self?.titleLabel {
                    label.text = "You are Premium!"
                    label.sizeToFit()
                }
                if let label = self?.descriptionLabel {
                    label.text = "On Gainy Premium to see Match Score and composition for all TTFs. And also you are cool ❤️"
                    label.setLineHeight(lineHeight: 24.0, textAlignment: .left)
                    label.sizeToFit()
                }
                #if DEBUG
                if #available(iOS 15.0, *) {
                    if let button = self?.refundBtn {
                        button.isHidden = false
                    }
                }
                #endif
                
            }
        })
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedSemibold(14),
            NSAttributedString.Key.kern: 1.25]
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backImage = UIImage(named: "iconClose")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.title = NSLocalizedString("Current subscription", comment: "Current subscription").uppercased()
        
    }
    
    @objc private func backButtonTap(sender: UIBarButtonItem) {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction private func onSubscribeButtonTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("try_premium_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileSubscriptionViewController"])
        self.dismiss(animated: true) {
            self.mainCoordinator?.showPurchaseView()
        }
    }
    
    @IBAction private func onCancelSubscriptionTap(_ sender: Any) {
        GainyAnalytics.logEvent("cancel_subscription_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "ProfileSubscriptionViewController"])
        if let url = URL(string: "itms-apps://apps.apple.com/account/subscriptions") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    
    @IBAction private func presentSwiftUISettingsScreen() {
        if #available(iOS 15.0, *) {
            let refundTransactionsView = RefundTransactionsView()
            let hostingController = UIHostingController(rootView: refundTransactionsView)
            present(hostingController, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
        
    }
}
