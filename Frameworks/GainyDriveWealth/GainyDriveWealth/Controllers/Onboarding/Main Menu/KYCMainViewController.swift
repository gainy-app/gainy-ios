//
//  KYCMainViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors

enum KYCMainViewControllerState: Int {
    case createAccount, verifyIdentity, investorProfile, submit
    
    func increment() -> KYCMainViewControllerState {
        return KYCMainViewControllerState.init(rawValue: self.rawValue + 1) ?? .submit
    }
    
    func decrement() -> KYCMainViewControllerState {
        return KYCMainViewControllerState.init(rawValue: self.rawValue - 1) ?? .createAccount
    }
}

final class KYCMainViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        var state: KYCMainViewControllerState = .createAccount
        self.gainyNavigationBar.configureWithItems(items: [.close])
        if let cache = self.coordinator?.kycDataSource.kycFormCache {
            if let filled = cache.account_filled, filled == true {
                state = .verifyIdentity
            }
            if let filled = cache.identity_filled, filled == true {
                state = .investorProfile
            }
            if let filled = cache.investor_profile_filled, filled == true {
                state = .submit
            }
            if let selected = cache.disclosures_all_agreements_qccepted {
                self.agreementsButton.isSelected = selected
            }
        }
        self.updateState(state: state)
        
        
        
        if let attributedString: NSAttributedString = privacyPolicyTextView.attributedText {
            
            if var mutableAttributedString = attributedString.mutableCopy() as? NSMutableAttributedString {
                mutableAttributedString.setAsLink(textToFind: "Drivewealth Account Agreements", linkURL: "https://legal.drivewealth.com/customer-account-agreement")
                mutableAttributedString.setAsLink(textToFind: "Portfolio Line of Credit Agreement", linkURL: "https://legal.drivewealth.com/customer-account-agreement")
                mutableAttributedString.setAsLink(textToFind: "Form CRS", linkURL: "https://legal.drivewealth.com/customer-account-agreement")
                mutableAttributedString.setAsLink(textToFind: "Form ADV Part 2", linkURL: "https://legal.drivewealth.com/customer-account-agreement")
                privacyPolicyTextView.attributedText = mutableAttributedString.copy() as? NSAttributedString
            }
        }
    }
    
    
    public func updateState(state: KYCMainViewControllerState) {
        
        self.state = state
        self.createAccountEditButton.isHidden = true
        self.verifyIdentityEditButton.isHidden = true
        self.investorProfileEditButton.isHidden = true
        
        self.createAccountView.layer.borderWidth = 0.0
        self.createAccountView.layer.borderColor = UIColor.clear.cgColor
        self.verifyIdentityView.layer.borderWidth = 0.0
        self.verifyIdentityView.layer.borderColor = UIColor.clear.cgColor
        self.investorProfileView.layer.borderWidth = 0.0
        self.investorProfileView.layer.borderColor = UIColor.clear.cgColor
        
        let bgColor = UIColor(displayP3Red: 231.0 / 255.0, green: 234.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
        let activeColor = UIColor(displayP3Red: 0.0 / 255.0, green: 98.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        
        self.createAccountNumberView.backgroundColor = bgColor
        self.verifyIdentityNumberView.backgroundColor = bgColor
        self.investorProfileNumberView.backgroundColor = bgColor
        
        self.nextBtn.configureWithTitle(title: "Continue", color: UIColor.white, state: .normal)
        self.nextBtn.configureWithTitle(title: "Continue", color: UIColor.white, state: .disabled)
        self.termsView.isHidden = true
        
        let title = state == .createAccount ? "What now" : "What we gonna\ndo next?"
        self.titleLabel.text = title
        
        switch state {
        case .createAccount:
            self.nextBtn.configureWithTitle(title: "Start", color: UIColor.white, state: .normal)
            self.nextBtn.configureWithTitle(title: "Start", color: UIColor.white, state: .disabled)
            self.createAccountView.layer.borderWidth = 2.0
            self.createAccountView.layer.borderColor = activeColor.cgColor
            self.createAccountNumberView.backgroundColor = activeColor
            
        case .verifyIdentity:
            self.verifyIdentityView.layer.borderWidth = 2.0
            self.verifyIdentityView.layer.borderColor = activeColor.cgColor
            self.createAccountNumberView.backgroundColor = activeColor
            self.verifyIdentityNumberView.backgroundColor = activeColor
            self.createAccountEditButton.isHidden = false
            
        case .investorProfile:
            self.investorProfileView.layer.borderWidth = 2.0
            self.investorProfileView.layer.borderColor = activeColor.cgColor
            self.createAccountNumberView.backgroundColor = activeColor
            self.verifyIdentityNumberView.backgroundColor = activeColor
            self.investorProfileNumberView.backgroundColor = activeColor
            self.createAccountEditButton.isHidden = false
            self.verifyIdentityEditButton.isHidden = false
            
        case .submit:
            self.termsView.isHidden = false
            self.createAccountNumberView.backgroundColor = activeColor
            self.verifyIdentityNumberView.backgroundColor = activeColor
            self.investorProfileNumberView.backgroundColor = activeColor
            self.createAccountEditButton.isHidden = false
            self.verifyIdentityEditButton.isHidden = false
            self.investorProfileEditButton.isHidden = false
            self.nextBtn.configureWithTitle(title: "Done! Submit this form", color: UIColor.white, state: .normal)
            self.nextBtn.configureWithTitle(title: "Done! Submit this form", color: UIColor.white, state: .disabled)
            let bottomOffset = CGPoint(x: 0, y: 540.0)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
        }
        self.nextBtn.configureWithDisabledBackgroundColor(color: bgColor)
        self.agreementsButton.isSelected = true
        self.updateDisclosuresCache()
        self.updateSubmitButtonState()
    }
    
    private var state: KYCMainViewControllerState = .createAccount
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var privacyPolicyTextView: UITextView! {
        didSet {
            privacyPolicyTextView.isEditable = false
            privacyPolicyTextView.isScrollEnabled = false
            
        }
    }
    
    @IBOutlet private weak var createAccountView: UIView!
    @IBOutlet private weak var verifyIdentityView: UIView!
    @IBOutlet private weak var investorProfileView: UIView!
    
    @IBOutlet private weak var createAccountNumberView: UIView!
    @IBOutlet private weak var verifyIdentityNumberView: UIView!
    @IBOutlet private weak var investorProfileNumberView: UIView!
    
    @IBOutlet private weak var createAccountEditButton: GainyButton! {
        didSet {
            createAccountEditButton.configureWithCornerRadius(radius: 0.0)
            createAccountEditButton.configureWithBackgroundColor(color: UIColor.clear)
            createAccountEditButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        }
    }
    
    @IBOutlet private weak var verifyIdentityEditButton: GainyButton! {
        didSet {
            verifyIdentityEditButton.configureWithCornerRadius(radius: 0.0)
            verifyIdentityEditButton.configureWithBackgroundColor(color: UIColor.clear)
            verifyIdentityEditButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        }
    }
    
    @IBOutlet private weak var investorProfileEditButton: GainyButton! {
        didSet {
            investorProfileEditButton.configureWithCornerRadius(radius: 0.0)
            investorProfileEditButton.configureWithBackgroundColor(color: UIColor.clear)
            investorProfileEditButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        }
    }
    
    @IBOutlet private weak var scrollView: UIScrollView! {
        didSet {
            self.scrollView.delaysContentTouches = false
        }
    }
    @IBOutlet private weak var termsView: UIView!
    
    @IBOutlet private weak var agreementsButton: UIButton! {
        didSet {
            self.agreementsButton.isUserInteractionEnabled = true
        }
    }
   
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Start", color: UIColor.white, state: .normal)
        }
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        if self.state == .submit {
            
            self.showNetworkLoader()
            self.coordinator?.kycDataSource.upsertKycFormFromCache({ success in
                DispatchQueue.main.async {
                    if success {
                        print("Successfully upset KYC form values from collected data")
                        self.coordinator?.kycDataSource.sendKYCForm({ sendFormSuccess in
                            DispatchQueue.main.async {
                                self.hideLoader()
                                if sendFormSuccess {
                                    // TODO: KYC - what to do after send form?
                                    print("Successfully send KYC form")
                                    self.coordinator?.showOrderSpaceDone(amount: 0, collectionId: 0, name: "", mode: .kycSubmittted)
                                    
                                } else {
                                    print("Error: Failed to send KYC form!")
                                    self.showAlertWithMessage("Failed to send KYC form, please check your internet connection and try again.")
                                }
                            }
                        })
                    } else {
                        print("Error: Failed to upset KYC form!")
                        self.hideLoader()
                        self.showAlertWithMessage("Failed to upset KYC form.")
                    }
                }
            })
            return
        }
        
        if self.state == .createAccount {
            self.coordinator?.showKYCCountrySelector()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.updateState(state: self.state.increment())
            })
            return
        }
        
        if self.state == .verifyIdentity {
            self.coordinator?.showKYCLegalNameView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.updateState(state: self.state.increment())
            })
            return
        }
        
        if self.state == .investorProfile {
            self.coordinator?.showKYCYourEmploymentView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.updateState(state: self.state.increment())
            })
            return
        }
    }
    
    @IBAction func createAccountEditButtonAction(_ sender: Any) {
        self.coordinator?.showKYCCountrySelector()
    }
    
    @IBAction func verifyIdentityEditButtonAction(_ sender: Any) {
        self.coordinator?.showKYCLegalNameView()
    }
    
    @IBAction func investorProfileEditButtonAction(_ sender: Any) {
        self.coordinator?.showKYCYourEmploymentView()
    }
    
    @IBAction func agreementButtonAction(_ sender: Any) {
        self.agreementsButton.isSelected = !self.agreementsButton.isSelected
        self.updateDisclosuresCache()
        self.updateSubmitButtonState()
    }
    
    private func updateDisclosuresCache() {
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.disclosures_all_agreements_qccepted = self.agreementsButton.isSelected
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
    }
    
    private func showAlertWithMessage(_ mesage: String) {
        let alertController = UIAlertController(title: nil, message: NSLocalizedString(mesage, comment: ""), preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
            
        }
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func updateSubmitButtonState() {
        
        guard self.state == .submit else {
            self.nextBtn.isEnabled = true
            return
        }
        
        if  self.agreementsButton.isSelected {
            self.nextBtn.isEnabled = true
        } else {
            self.nextBtn.isEnabled = false
        }
    }
}


extension NSMutableAttributedString {

   public func setAsLink(textToFind:String, linkURL:String)  {

       let foundRange = self.mutableString.range(of: textToFind)
       if foundRange.location != NSNotFound {
           self.addAttribute(NSAttributedString.Key.link, value: linkURL, range: foundRange)
           self.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single, range: foundRange)
           self.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: 0x0062FF) ?? UIColor.blue, range: foundRange)
           self.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor(hex: 0x0062FF) ?? UIColor.blue, range: foundRange)
       }
   }
}
