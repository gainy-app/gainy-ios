//
//  KYCPhoneViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import CountryKit

final class KYCPhoneViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        GainyAnalytics.logEventAMP("dw_kyc_phone_s")
        
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        if let cache = self.coordinator?.kycDataSource.kycFormCache {
            if var phoneNumber = cache.phone_number_without_code {
                if phoneNumber.count > 10 {
                    phoneNumber = String(phoneNumber.prefix(10))
                }
                self.phoneStringWithoutCountryCode = phoneNumber
                self.phoneNumberTextFieldControl.configureWithText(text: phoneNumber, placeholder: "Mobile number", smallPlaceholder: "Mobile number")
            }
        }
        self.country = Country.us()
        self.updateUI()
        self.validateAmount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.phoneNumberTextFieldControl.isEditing = true
    }
    
    @IBOutlet private weak var flagLabel: UILabel!
    @IBOutlet private weak var codeLabel: UILabel!
    
    @IBOutlet private weak var phoneNumberLabel: GainyTextField! {
        didSet {
            self.phoneNumberLabel.insets = UIEdgeInsets(top: 0.0, left: 14.0, bottom: 0.0, right: 14.0)
            self.phoneNumberLabel.isUserInteractionEnabled = false
        }
    }
    
    @IBOutlet private weak var phoneNumberTextFieldControl: GainyTextFieldControl! {
        didSet {
            self.phoneNumberTextFieldControl.delegate = self
            self.phoneNumberTextFieldControl.maxNumberOfSymbols = 10
            self.phoneNumberTextFieldControl.keyboardType = UIKeyboardType.numberPad
            self.phoneNumberTextFieldControl.isEditing = true
            self.phoneNumberTextFieldControl.useSmallPlaceholder = false
            self.phoneNumberTextFieldControl.configureWithText(text: "", placeholder: "Mobile number", smallPlaceholder: "Mobile number")
        }
    }
    
    @IBOutlet private weak var nextButton: GainyButton! {
        didSet {
            nextButton.configureWithTitle(title: "Next", color: UIColor.white, state: .normal)
            nextButton.configureWithTitle(title: "Next", color: UIColor.white, state: .disabled)
            nextButton.configureWithCornerRadius(radius: 16.0)
            nextButton.configureWithBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.configureWithHighligtedBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.isEnabled = false
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
    
    @IBOutlet private weak var searchCountriesButton: GainyButton! {
        didSet {
            searchCountriesButton.configureWithTitle(title: "", color: UIColor.clear, state: .normal)
            searchCountriesButton.configureWithTitle(title: "", color: UIColor.clear, state: .disabled)
            searchCountriesButton.configureWithCornerRadius(radius: 16.0)
            searchCountriesButton.configureWithBackgroundColor(color: UIColor.white)
            searchCountriesButton.configureWithHighligtedBackgroundColor(color: UIColor.white)
        }
    }
    
    @IBAction func searchCountriesButtonAction(_ sender: Any) {
#if DEBUG
        self.coordinator?.showKYCCountrySearch(delegate: self)
#endif
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        GainyAnalytics.logEventAMP("dw_kyc_phone_entered")
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.phone_number_without_code = self.phoneStringWithoutCountryCode
            cache.phone_number_country_iso = self.country?.iso
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        let last4Digits = String(self.phoneStringWithoutCountryCode.suffix(4))
        
        if self.coordinator?.isErrorCodeMode ?? false {
            if self.coordinator?.haveCodeToJump() ?? false {
                self.coordinator?.jumpToNextCode()
            } else {
                self.coordinator?.finishCodes()
            }
        } else {
            self.coordinator?.showKYCVerifyPhoneView(last4Digits: last4Digits, fullNumber: self.fullPhoneString)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private var country: Country?
    private var phoneStringWithoutCountryCode: String = ""
    private var fullPhoneString: String = ""
    
    private func updateUI() {
        
        guard let country = self.country else {return}
        var countryISO2 = country.iso
        if let map = self.coordinator?.kycDataSource.alpha2ToAlpha3 {
            if let key = map.keys.first(where: { key in
                map[key] == country.iso
            }) {
                countryISO2 = key
            }
        }
        let countryKit = CountryKit()
        if let flaggedCountry = countryKit.countries.first(where: { ctr in
            ctr.iso == countryISO2
        }) {
            self.flagLabel.text = flaggedCountry.emoji
            self.codeLabel.text = (flaggedCountry.phoneCode != nil) ? "+\(flaggedCountry.phoneCode!)" : "+"
        }
        self.validateAmount()
    }
}

extension KYCPhoneViewController: KYCCountrySearchViewControllerDelegate {
    
    func countrySearchViewController(sender: KYCCountrySearchViewController, didPickCountry country: Country) {
        sender.dismiss(animated: true)
        self.country = country
        self.updateUI()
    }
}

extension KYCPhoneViewController: GainyTextFieldControlDelegate {
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        
        self.validateAmount()
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {
        
        self.phoneStringWithoutCountryCode = text
        self.validateAmount()
    }
    
    func validateAmount() {
        
        let code = self.codeLabel.text ?? "+"
        let fullNumber = "\(code)\(self.phoneStringWithoutCountryCode)"
        self.fullPhoneString = fullNumber
        let valid = self.phoneStringWithoutCountryCode.count == 10
        if valid {
            let string = self.phoneStringWithoutCountryCode
            let first3 = String(string.prefix(3))
            var tempString = string.dropFirst(3)
            let middle3 = String(tempString.prefix(3))
            tempString = tempString.dropFirst(3)
            let last4 = tempString
            var result = "(\(first3)) \(middle3)-\(last4)"
            self.phoneNumberLabel.text = result
            self.phoneNumberLabel.isHidden = false
            self.phoneNumberTextFieldControl.isHidden = true
            
        } else {
            self.phoneNumberLabel.isHidden = true
            self.phoneNumberTextFieldControl.isHidden = false
        }
        nextButton.isEnabled = valid
    }
}
