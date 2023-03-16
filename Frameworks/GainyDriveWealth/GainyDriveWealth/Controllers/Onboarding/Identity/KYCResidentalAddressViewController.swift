//
//  KYCResidentalAddressViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import GainyAPI

final class KYCResidentalAddressViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEventAMP("dw_kyc_res_addr_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        self.gainyNavigationBar.backgroundColor = self.view.backgroundColor
        if self.firstAddressTextControl.text.isEmpty {
            self.firstAddressTextControl.isEditing = true
        }
        self.scrollView.isScrollEnabled = true
        self.updateNextButtonState(firstAddress: self.firstAddressTextControl.text, secondAddress: self.secondAddressTextControl.text, city: self.cityTextControl.text, postalCode: self.postCodeTextControl.text)
    }
    
    @IBOutlet private weak var firstAddressTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressStreet1?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let address = cache.address_street1 {
                    defaultValue = address
                }
            }
            firstAddressTextControl.delegate = self
            firstAddressTextControl.configureWithText(text: defaultValue, placeholder: "Address line 1", smallPlaceholder: "Address line 1")
        }
    }
    
    @IBOutlet private weak var secondAddressTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let address = cache.address_street2 {
                    defaultValue = address
                }
            }
            secondAddressTextControl.delegate = self
            secondAddressTextControl.configureWithText(text: defaultValue, placeholder: "Address line 2", smallPlaceholder: "Address line 2")
        }
    }
    
    @IBOutlet private weak var cityTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressCity?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let city = cache.address_city {
                    defaultValue = city
                }
            }
            cityTextControl.delegate = self
            cityTextControl.configureWithText(text: defaultValue, placeholder: "City", smallPlaceholder: "City")
        }
    }
    
    @IBOutlet private weak var stateTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let statePr = cache.address_province {
                    let state = String(statePr.prefix(2))
                    if let choices = self.coordinator?.kycDataSource.kycFormConfig?.addressProvince?.choices {
                        if let stateChoice = choices.first(where: { item in
                            if let itemValue = item, itemValue.value == state {
                                return true
                            }
                            return false
                        }) {
                            self.state = stateChoice
                            defaultValue = stateChoice?.value ?? ""
                        }
                    }
                }
            }
            stateTextControl.delegate = self
            stateTextControl.configureWithText(text: defaultValue, placeholder: "State", smallPlaceholder: "State")
            stateTextControl.textFieldEnabled = false
        }
    }
    
    @IBOutlet private weak var postCodeTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressPostalCode?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let zipCode = cache.address_postal_code {
                    defaultValue = zipCode
                }
            }
            postCodeTextControl.delegate = self
            postCodeTextControl.configureWithText(text: defaultValue, placeholder: "Zip code", smallPlaceholder: "Zip code")
            postCodeTextControl.keyboardType = .numberPad
            postCodeTextControl.maxNumberOfSymbols = 5
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
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBAction func nextButtonAction(_ sender: Any) {
        //Validating addres
        showNetworkLoader()
        Task {
            do {
                let validatedAddr = try await dwAPI.validateAddress(street1: self.firstAddressTextControl.text,
                                                                street2: self.secondAddressTextControl.text,
                                                                    city: self.cityTextControl.text,
                                                                    province: self.state?.value ?? "",
                                                                    postalCode: self.postCodeTextControl.text, country: "us")
                if validatedAddr.ok ?? false {
                    await MainActor.run {
                        hideLoader()
                        if let suggested = validatedAddr.suggested {
                            let addrLine = [suggested.street1,
                                            suggested.street2,
                                            (suggested.province?.isEmpty ?? true) ? self.state?.value ?? "" : suggested.province,
                                            (suggested.city?.isEmpty ?? true) ? self.cityTextControl.text : suggested.city,
                                            (suggested.postalCode?.isEmpty ?? true) ? self.postCodeTextControl.text : suggested.postalCode].compactMap({$0}).joined(separator: ",")
                            let alertController = UIAlertController(title: nil, message: NSLocalizedString("We are suggesting to use this validated address - \(addrLine)", comment: ""), preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) in
                                finishValidation()
                            }
                            let proceedAction = UIAlertAction(title: NSLocalizedString("Use", comment: ""), style: .destructive) { (action) in
                                finishValidation(suggestion: suggested)
                            }
                            alertController.addAction(proceedAction)
                            alertController.addAction(cancelAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                    }
                } else {
                    await MainActor.run {
                        hideLoader()
                        showValidationFailed()
                    }
                }
                
            } catch {
                await MainActor.run {
                    hideLoader()
                    showValidationFailed()
                }
            }
        }
        
        func showValidationFailed() {
            let alertController = UIAlertController(title: "Error", message: "Address validation failed. Please check your address one more time and try again.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .destructive) {_ in
                
            }
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        func finishValidation() {
            if var cache = self.coordinator?.kycDataSource.kycFormCache {
                cache.address_street1 = self.firstAddressTextControl.text
                cache.address_street2 = self.secondAddressTextControl.text
                cache.address_city = self.cityTextControl.text
                cache.address_province = self.state?.value ?? ""
                cache.address_postal_code = self.postCodeTextControl.text
                self.coordinator?.kycDataSource.kycFormCache = cache
            }
            self.coordinator?.showKYCSocialSecurityNumberView()
            GainyAnalytics.logEventAMP("dw_kyc_res_addr_e", params: ["city" : self.cityTextControl.text ?? "", "state" : self.state?.value ?? ""])
        }
        
        func finishValidation(suggestion: KycValidateAddressQuery.Data.KycValidateAddress.Suggested) {
            self.firstAddressTextControl.setText(suggestion.street1 ?? "")
            self.secondAddressTextControl.setText(suggestion.street2 ?? "")
            if let city = suggestion.city {
                self.cityTextControl.setText(city)
            }
            self.postCodeTextControl.setText(suggestion.postalCode ?? "")
            
            if var cache = self.coordinator?.kycDataSource.kycFormCache {
                cache.address_street1 = suggestion.street1 ?? ""
                cache.address_street2 = suggestion.street2 ?? ""
                cache.address_city = suggestion.city ?? ""
                cache.address_province = suggestion.province ?? ""
                cache.address_postal_code = suggestion.postalCode ?? ""
                self.coordinator?.kycDataSource.kycFormCache = cache
            }
            self.coordinator?.showKYCSocialSecurityNumberView()
            GainyAnalytics.logEvent("dw_kyc_res_addr_e")
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }

    
    
    private var state: KycGetFormConfigQuery.Data.KycGetFormConfig.AddressProvince.Choice? = nil
    
    private func updateNextButtonState(firstAddress: String, secondAddress: String, city: String, postalCode: String) {
        
        guard firstAddress.isEmpty == false, city.isEmpty == false, postalCode.isEmpty == false, self.state != nil, postalCode.count == 5 else {
            self.nextButton.isEnabled = false
            return
        }
        
        self.nextButton.isEnabled = true
    }
    
    private func updateContentOffset(value: CGFloat) {
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentOffset = CGPoint(x: 0.0, y: value)
            self.view.layoutIfNeeded()
        }
    }
}

extension KYCResidentalAddressViewController: KYCStateSearchViewControllerDelegate {
    
    func stateSearchViewController(sender: KYCStateSearchViewController, didPickState state: KycGetFormConfigQuery.Data.KycGetFormConfig.AddressProvince.Choice) {
        
        sender.dismiss(animated: true)
        self.state = state
        self.stateTextControl.configureWithText(text: state.value)
        self.postCodeTextControl.isEditing = true
        self.updateContentOffset(value: 300.0)
        self.updateNextButtonState(firstAddress: self.firstAddressTextControl.text, secondAddress: self.secondAddressTextControl.text, city: self.cityTextControl.text, postalCode: self.postCodeTextControl.text)
    }
}

extension KYCResidentalAddressViewController: GainyTextFieldControlDelegate {
    
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        if sender == self.stateTextControl {
            self.stateTextControl.isEditing = false
            self.coordinator?.showKYCStateSearchView(delegate: self)
        } else if sender == self.cityTextControl {
            self.updateContentOffset(value: 150.0)
        } else if sender == self.postCodeTextControl {
            self.updateContentOffset(value: 300.0)
        } else if sender == self.secondAddressTextControl {
            self.updateContentOffset(value: 15.0)
        } else {
            self.updateContentOffset(value: 0.0)
        }
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        
        if sender == self.firstAddressTextControl {
            self.secondAddressTextControl.isEditing = true
            self.updateContentOffset(value: 15.0)
        } else if sender == self.secondAddressTextControl {
            self.cityTextControl.isEditing = true
            self.updateContentOffset(value: 150.0)
        } else if sender == self.cityTextControl {
            self.stateTextControl.isEditing = false
            self.coordinator?.showKYCStateSearchView(delegate: self)
        } else {
            if self.firstAddressTextControl.text.isEmpty {
                self.firstAddressTextControl.isEditing = true
            } else if self.secondAddressTextControl.text.isEmpty {
                self.secondAddressTextControl.isEditing = true
            } else if self.cityTextControl.text.isEmpty {
                self.cityTextControl.isEditing = true
            } else if self.stateTextControl.text.isEmpty {
                self.stateTextControl.isEditing = false
                self.coordinator?.showKYCStateSearchView(delegate: self)
            } else if self.postCodeTextControl.text.isEmpty {
                self.postCodeTextControl.isEditing = true
            } else {
                self.updateNextButtonState(firstAddress: self.firstAddressTextControl.text, secondAddress: self.secondAddressTextControl.text, city: self.cityTextControl.text, postalCode: self.postCodeTextControl.text)
            }
        }
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {
        
        let firstAddress = (sender == self.firstAddressTextControl ? text : self.firstAddressTextControl.text)
        let secondAddress = (sender == self.secondAddressTextControl ? text : self.secondAddressTextControl.text)
        let city = (sender == self.cityTextControl ? text : self.cityTextControl.text)
        var postalCode = (sender == self.postCodeTextControl ? text : self.postCodeTextControl.text)
        
        self.updateNextButtonState(firstAddress: firstAddress, secondAddress: secondAddress, city: city, postalCode: postalCode)
    }
}

