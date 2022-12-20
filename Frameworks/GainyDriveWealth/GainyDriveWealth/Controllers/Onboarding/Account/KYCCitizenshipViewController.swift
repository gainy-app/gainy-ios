//
//  KYCCitizenshipViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import CountryKit

final class KYCCitizenshipViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEvent("dw_kyc_citz_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        var isON = false
        let countryKit = CountryKit()
        if let cache = self.coordinator?.kycDataSource.kycFormCache {
            if var countryISO = cache.citizenship {
                if countryISO == "USA" {
                    countryISO = "US"
                    isON = true
                }
                if let map = self.coordinator?.kycDataSource.alpha2ToAlpha3 {
                    if let key = map.keys.first(where: { key in
                        map[key] == countryISO
                    }) {
                        countryISO = key
                    }
                }
                let country = countryKit.searchByIsoCode(countryISO)
                self.country = country
            } else {
                isON = true
            }
        }
        
        if self.country == nil {
            let country = countryKit.searchByIsoCode("US")
            self.country = country
            isON = true
        }

        self.citizenUSSwitch.isOn = isON
        self.citizenNotUSSwitch.isOn = !isON
        self.hiddenView.isHidden = isON
        self.updateNextButtonState()
    }
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var citizenUSSwitch: UISwitch!
    @IBOutlet private weak var citizenNotUSSwitch: UISwitch!
    
    @IBOutlet private weak var hiddenView: UIView!
    
    @IBOutlet private weak var citizenshipTextFieldControl: GainyTextFieldControl! {
        didSet {
            let countryKit = CountryKit()
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if var countryISO = cache.citizenship {
                    if countryISO == "USA" {
                        countryISO = "US"
                    }
                    if let map = self.coordinator?.kycDataSource.alpha2ToAlpha3 {
                        if let key = map.keys.first(where: { key in
                            map[key] == countryISO
                        }) {
                            countryISO = key
                        }
                    }
                    let country = countryKit.searchByIsoCode(countryISO)
                    self.country = country
                }
            }
            
            if self.country == nil {
                let country = countryKit.searchByIsoCode("US")
                self.country = country
            }
            self.citizenshipTextFieldControl.delegate = self
            self.citizenshipTextFieldControl.textFieldEnabled = false
            self.citizenshipTextFieldControl.configureWith(placeholderInset: 7.0)
            var defaultValue = ""
            if let country = self.country, country.iso.contains("US") == false {
                defaultValue = country.emoji + " " + country.localizedName
            }
            self.citizenshipTextFieldControl.configureWithText(text: defaultValue, placeholder: "Citizenship", smallPlaceholder: "Citizenship")
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache, let country = self.country {
            if country.iso.contains("US") || self.citizenUSSwitch.isOn {
                cache.citizenship = "USA"
                GainyAnalytics.logEvent("dw_kyc_citz_usa")
            } else {
                cache.citizenship = country.iso
                GainyAnalytics.logEvent("dw_kyc_citz_non_usa")
            }
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCEmailView()
    }
    
    @IBAction func citizenUSSwitchValueChanged(_ sender: Any) {
        self.citizenNotUSSwitch.isOn = !self.citizenUSSwitch.isOn
        self.hiddenView.isHidden = self.citizenUSSwitch.isOn
        
        self.updateNextButtonState()
    }
    
    @IBAction func citizenNotUSSwitchValueChanged(_ sender: Any) {
        
        self.citizenUSSwitch.isOn = !self.citizenNotUSSwitch.isOn
        self.hiddenView.isHidden = self.citizenUSSwitch.isOn
        
        self.updateNextButtonState()
    }
    
    private var country: Country?
    private let allKeyValues = [
        ["YRS_LESS_1" : "Less than 1 year"],
        ["YRS_1" : "1 year"],
        ["YRS_2" : "2 years"],
        ["YRS_3" : "3 years"],
        ["YRS_4" : "4 years"],
        ["YRS_5" : "5 years"],
        ["YRS_MORE_5" : "More than 5 years"],
    ]
    
    private func updateNextButtonState() {
        
        if self.citizenUSSwitch.isOn {
            self.nextButton.isEnabled = true
            return
        }
        guard self.country != nil else  {
            self.nextButton.isEnabled = false
            return
        }
        
        self.nextButton.isEnabled = true
    }
    
    private func updateCitizenshipTextField() {
        
        guard let country = self.country else {return}
        guard !country.iso.contains("US") else {return}
        let text = country.emoji + " " + country.localizedName
        self.citizenshipTextFieldControl.configureWithText(text: text, placeholder: "Citizenship", smallPlaceholder: "Citizenship")
        self.updateNextButtonState()
    }
}


extension KYCCitizenshipViewController: GainyTextFieldControlDelegate {
 
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        self.citizenshipTextFieldControl.isEditing = false
        self.coordinator?.showKYCCountrySearch(delegate: self, exceptUS: true)
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        
        sender.isEditing = false
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {
        
    }
}

extension KYCCitizenshipViewController: KYCCountrySearchViewControllerDelegate {
    func countrySearchViewController(sender: KYCCountrySearchViewController, didPickCountry country: Country) {
        sender.dismiss(animated: true)
        self.country = country
        self.updateCitizenshipTextField()
        self.updateNextButtonState()
    }
}
