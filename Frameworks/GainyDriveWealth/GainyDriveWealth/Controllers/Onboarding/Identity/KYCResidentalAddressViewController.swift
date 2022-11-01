//
//  KYCResidentalAddressViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors

final class KYCResidentalAddressViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        self.gainyNavigationBar.backgroundColor = self.view.backgroundColor
        self.firstAddressTextControl.isEditing = true
        self.scrollView.isScrollEnabled = true
    }
    
    @IBOutlet private weak var firstAddressTextControl: GainyTextFieldControl! {
        didSet {
            let defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressStreet1?.placeholder ?? ""
            firstAddressTextControl.delegate = self
            firstAddressTextControl.configureWithText(text: defaultValue, placeholder: "Address line 1", smallPlaceholder: "Address line 1")
        }
    }
    
    @IBOutlet private weak var secondAddressTextControl: GainyTextFieldControl! {
        didSet {
            secondAddressTextControl.delegate = self
            secondAddressTextControl.configureWithText(text: "", placeholder: "Address line 2", smallPlaceholder: "Address line 2")
        }
    }
    
    @IBOutlet private weak var cityTextControl: GainyTextFieldControl! {
        didSet {
            let defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressCity?.placeholder ?? ""
            cityTextControl.delegate = self
            cityTextControl.configureWithText(text: defaultValue, placeholder: "City", smallPlaceholder: "City")
        }
    }
    
    @IBOutlet private weak var stateTextControl: GainyTextFieldControl! {
        didSet {
            // TODO: Question - there is only addressCountry, no state
//            let defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressCountry?.placeholder ?? ""
            stateTextControl.delegate = self
            stateTextControl.configureWithText(text: "", placeholder: "State", smallPlaceholder: "State")
            stateTextControl.textFieldEnabled = false
        }
    }
    
    @IBOutlet private weak var postCodeTextControl: GainyTextFieldControl! {
        didSet {
            let defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressPostalCode?.placeholder ?? ""
            postCodeTextControl.delegate = self
            postCodeTextControl.configureWithText(text: defaultValue, placeholder: "Zip code", smallPlaceholder: "Zip code")
            postCodeTextControl.keyboardType = .numberPad
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
        
        self.coordinator?.kycDataSource.upsertKycForm(address_city: self.cityTextControl.text, address_postal_code: self.postCodeTextControl.text, address_province: self.state ?? "", address_street1: self.firstAddressTextControl.text, address_street2: self.secondAddressTextControl.text, { success in
            if success {
                print("Success mutate address_city, address_postal_code, address_province, address_street1, address_street2: \(success)")
            } else {
                print("Failed to mutate address_city, address_postal_code, address_province, address_street1, address_street2: \(success)")
            }
        })
        
        self.coordinator?.showKYCSocialSecurityNumberView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }

    
    
    private var state: String? = nil
    
    private func updateNextButtonState(firstAddress: String, secondAddress: String, city: String, postalCode: String) {
        
        guard firstAddress.isEmpty == false, city.isEmpty == false, postalCode.isEmpty == false, self.state != nil, postalCode.count >= 5 else {
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
    
    func stateSearchViewController(sender: KYCStateSearchViewController, didPickState state: String) {
        
        sender.dismiss(animated: true)
        self.state = state
        let stateCode = String(state.prefix(2))
        self.stateTextControl.configureWithText(text: stateCode)
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
        let postalCode = (sender == self.postCodeTextControl ? text : self.postCodeTextControl.text)
        
        self.updateNextButtonState(firstAddress: firstAddress, secondAddress: secondAddress, city: city, postalCode: postalCode)
    }
}

