//
//  PrivacyViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import UIKit

final class PrivacyViewController: BaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedSemibold(14)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backImage = UIImage(named: "iconClose")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.title = NSLocalizedString("Privacy", comment: "Privacy").uppercased()
    }
    
    @objc private func backButtonTap(sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPrivacyPolicyTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_privacy_policy_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PrivacyViewController"])
        if let url = URL(string: Constants.Links.privacy) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func onTermsOfServiceTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_terms_of_service_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PrivacyViewController"])
        if let url = URL(string: Constants.Links.tos) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func onPrivacyNoticeTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_privacy_notice_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PrivacyViewController"])
        if let url = URL(string: Constants.Links.privacyNotice) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func onFormCRSTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("form_CRS_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PrivacyViewController"])
        if let url = URL(string: Constants.Links.formCRS) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func onADVTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("form_ADV_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PrivacyViewController"])
        if let url = URL(string: Constants.Links.advPart3) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func onClientAgreementTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_client_agreement_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PrivacyViewController"])
        if let url = URL(string: Constants.Links.clientAgreement) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
    
    @IBAction func onConsentToEDTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_to_EDelivaty_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PrivacyViewController"])
        if let url = URL(string: Constants.Links.contentTOEDelivery) {
            WebPresenter.openLink(vc: self, url: url)
        }
    }
}
