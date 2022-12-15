//
//  KYCAdditionalQuestionsViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors

final class KYCAdditionalQuestionsViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEvent("dw_kyc_eqa_s")
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
    }
    
    @IBOutlet private weak var scrollView: UIScrollView!

    @IBOutlet private weak var topSwitch: UISwitch! {
        didSet {
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let isON = cache.employment_affiliated_with_a_broker {
                    self.topSwitch.isOn = isON
                    self.topHiddenView.isHidden = !self.topSwitch.isOn
                }
            }
        }
    }
    
    @IBOutlet private weak var politicallyExposedNamesSwitch: UISwitch! {
        didSet {
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let namesString = cache.politically_exposed_names {
                    self.politicallyExposedNamesSwitch.isOn = namesString.count > 0
                    self.politicallyExposedNamesHiddenView.isHidden = !self.politicallyExposedNamesSwitch.isOn
                }
            }
        }
    }
    
    @IBOutlet private weak var middleSwitch: UISwitch! {
        didSet {
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let companiesString = cache.employment_is_director_of_a_public_company {
                    self.middleSwitch.isOn = companiesString.count > 0
                    self.middleHiddenView.isHidden = !self.middleSwitch.isOn
                }
            }
        }
    }
    
    @IBOutlet private weak var bottomSwitch: UISwitch! {
        didSet {
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let isON = cache.irs_backup_withholdings_notified {
                    self.bottomSwitch.isOn = isON
                }
            }
        }
    }
    
    @IBOutlet private weak var topHiddenView: UIView!
    @IBOutlet private weak var politicallyExposedNamesHiddenView: UIView!
    @IBOutlet private weak var middleHiddenView: UIView!
    @IBOutlet private weak var companiesNamesTextFieldControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let companiesString = cache.employment_is_director_of_a_public_company {
                    defaultValue = companiesString
                }
            }
            companiesNamesTextFieldControl.delegate = self
            companiesNamesTextFieldControl.configureWithText(text: defaultValue, placeholder: "List Names", smallPlaceholder: "List Names")
            companiesNamesTextFieldControl.configureWith(placeholderInset: 7.0)
        }
    }
    
    @IBOutlet private weak var politicallyExposedNamesTextFieldControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let namesString = cache.politically_exposed_names {
                    defaultValue = namesString
                }
            }
            politicallyExposedNamesTextFieldControl.delegate = self
            politicallyExposedNamesTextFieldControl.configureWithText(text: defaultValue, placeholder: "List Names", smallPlaceholder: "List Names")
            politicallyExposedNamesTextFieldControl.configureWith(placeholderInset: 7.0)
        }
    }
    
    
    @IBOutlet private weak var nextButton: GainyButton! {
        didSet {
            nextButton.configureWithTitle(title: "Next", color: UIColor.white, state: .normal)
            nextButton.configureWithTitle(title: "Next", color: UIColor.white, state: .disabled)
            nextButton.configureWithCornerRadius(radius: 16.0)
            nextButton.configureWithBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.configureWithHighligtedBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
        }
    }
    
    @IBOutlet private weak var backButton: GainyButton! {
        didSet {
            backButton.configureWithTitle(title: "", color: UIColor.white, state: .normal)
            backButton.configureWithTitle(title: "", color: UIColor.white, state: .disabled)
            backButton.configureWithCornerRadius(radius: 16.0)
            backButton.configureWithBackgroundColor(color: UIColor.white)
            backButton.configureWithHighligtedBackgroundColor(color: UIColor.white)
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.employment_affiliated_with_a_broker = self.topSwitch.isOn
            cache.irs_backup_withholdings_notified = self.bottomSwitch.isOn
            if self.middleSwitch.isOn {
                cache.employment_is_director_of_a_public_company = self.companiesNamesTextFieldControl.text
            }
            if self.politicallyExposedNamesSwitch.isOn {
                cache.politically_exposed_names = self.politicallyExposedNamesTextFieldControl.text
            }
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCInvestmentProfileView()
        GainyAnalytics.logEvent("dw_kyc_eqa_e")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    @IBAction func topSwitchValueChanged(_ sender: Any) {
        
        self.topHiddenView.isHidden = !self.topSwitch.isOn
        
    }
    
    @IBAction func politicallyExposedNamesSwitchValueChanged(_ sender: Any) {
        
        if (!self.politicallyExposedNamesSwitch.isOn) {
            self.politicallyExposedNamesTextFieldControl.isEditing = false
            self.view.endEditing(true)
        }
        self.politicallyExposedNamesHiddenView.isHidden = !self.politicallyExposedNamesSwitch.isOn
        self.updateNextButtonState()
    }
    
    
    @IBAction func middleSwitchValueChanged(_ sender: Any) {
        
        if (!self.middleSwitch.isOn) {
            self.companiesNamesTextFieldControl.isEditing = false
            self.view.endEditing(true)
        }
        self.middleHiddenView.isHidden = !self.middleSwitch.isOn
        self.updateNextButtonState()
    }
    
    @IBAction func bottomSwitchValueChanged(_ sender: Any) {
        
    }
    
    private func updateNextButtonState() {
        
        if self.middleSwitch.isOn && self.companiesNamesTextFieldControl.text.isEmpty {
            self.nextButton.isEnabled = false
        } else if self.politicallyExposedNamesSwitch.isOn && self.politicallyExposedNamesTextFieldControl.text.isEmpty {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
        }
    }
}


extension KYCAdditionalQuestionsViewController: GainyTextFieldControlDelegate {
 
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        if sender == self.companiesNamesTextFieldControl {
            self.scrollView.contentOffset = CGPoint(x: 0.0, y: 510.0)
        } else if sender == self.politicallyExposedNamesTextFieldControl {
            self.scrollView.contentOffset = CGPoint(x: 0.0, y: 310.0)
        }
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        
        sender.isEditing = false
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {
        
        let companiesNames = (sender == self.companiesNamesTextFieldControl) ? text : self.companiesNamesTextFieldControl.text
        let politicallyExposedNames = (sender == self.politicallyExposedNamesTextFieldControl) ? text : self.politicallyExposedNamesTextFieldControl.text
        
        if self.middleSwitch.isOn && companiesNames.isEmpty {
            self.nextButton.isEnabled = false
        } else if self.politicallyExposedNamesSwitch.isOn && politicallyExposedNames.isEmpty {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
        }
        
        if !self.middleSwitch.isHidden && text.isEmpty {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
        }
    }
}
