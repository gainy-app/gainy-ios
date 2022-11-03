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
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
    }
    
    @IBOutlet private weak var scrollView: UIScrollView!

    @IBOutlet private weak var topSwitch: UISwitch! {
        didSet {
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let isON = cache.employment_affiliated_with_a_broker {
                    self.topSwitch.isOn = isON
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
            cache.employment_is_director_of_a_public_company = self.companiesNamesTextFieldControl.text
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCInvestmentProfileView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    @IBAction func topSwitchValueChanged(_ sender: Any) {
        
        self.topHiddenView.isHidden = !self.topSwitch.isOn
        
    }
    
    @IBAction func middleSwitchValueChanged(_ sender: Any) {
        
        self.middleHiddenView.isHidden = !self.middleSwitch.isOn
        self.updateNextButtonState()
    }
    
    @IBAction func bottomSwitchValueChanged(_ sender: Any) {
        
    }
    
    private func updateNextButtonState() {
        
        if !self.middleSwitch.isHidden && self.companiesNamesTextFieldControl.text.isEmpty {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
        }
    }
}


extension KYCAdditionalQuestionsViewController: GainyTextFieldControlDelegate {
 
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        
        sender.isEditing = false
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {
        
        if !self.middleSwitch.isHidden && text.isEmpty {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
        }
    }
}
