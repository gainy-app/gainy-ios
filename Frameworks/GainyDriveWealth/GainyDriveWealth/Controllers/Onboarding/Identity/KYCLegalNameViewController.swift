//
//  KYCLegalNameViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import GainyAPI

final class KYCLegalNameViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEventAMP("dw_kyc_legal_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        self.gainyNavigationBar.backgroundColor = self.view.backgroundColor
        self.firstNameTextControl.isEditing = true
        self.scrollView.isScrollEnabled = true
        if let date = self.date {
            let selectedDate: String = AppDateFormatter.shared.string(from: date, dateFormat: .MMddyyyyDot)
            self.birthdayTextControl.configureWithText(text: selectedDate)
        }
        self.updateNextButtonState(firstName: self.firstNameTextControl.text, lastName: self.lastNameTextControl.text)
    }
    
    @IBOutlet private weak var firstNameTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.firstName?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let firstName = cache.first_name {
                    defaultValue = firstName
                }
            }
            firstNameTextControl.delegate = self
            firstNameTextControl.configureWithText(text: defaultValue, placeholder: "Legal first name", smallPlaceholder: "Legal first name")
        }
    }
    
    @IBOutlet private weak var lastNameTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.lastName?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let lastName = cache.last_name {
                    defaultValue = lastName
                }
            }
            lastNameTextControl.delegate = self
            lastNameTextControl.configureWithText(text: defaultValue, placeholder: "Legal last name", smallPlaceholder: "Legal last name")
        }
    }
    
    @IBOutlet private weak var birthdayTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.birthdate?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let birthdate = cache.birthdate {
                    defaultValue = birthdate
                }
            }
            birthdayTextControl.isBirthday = true
            birthdayTextControl.delegate = self
            birthdayTextControl.keyboardType = .numberPad
            birthdayTextControl.maxNumberOfSymbols = 10
            guard let defaultDate = AppDateFormatter.shared.date(from: defaultValue, dateFormat: .MMddyyyyDot) else { return birthdayTextControl.configureWithText(text: "", placeholder: "Birthday", smallPlaceholder: "Birthday") }
            let formattedDate = AppDateFormatter.shared.string(from: defaultDate, dateFormat: .MMddyyyyDot)
            birthdayTextControl.configureWithText(text: formattedDate, placeholder: "Birthday", smallPlaceholder: "Birthday")
            self.date = defaultDate
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
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.first_name = self.firstNameTextControl.text
            cache.last_name = self.lastNameTextControl.text
            if let date = self.date {
                let selectedDate: String = AppDateFormatter.shared.string(from: date, dateFormat: .MMddyyyyDot)
                cache.birthdate = selectedDate
            }
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCResidentalAddressView()
        GainyAnalytics.logEventAMP("dw_kyc_legal_e")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate: String = AppDateFormatter.shared.string(from: sender.date, dateFormat: .MMddyyyyDot)
        self.date = sender.date
        self.birthdayTextControl.configureWithText(text: selectedDate)
        self.updateNextButtonState(firstName: self.firstNameTextControl.text, lastName: self.lastNameTextControl.text)
    }
    
    
    private var date: Date? = nil
    
    private func updateNextButtonState(firstName: String, lastName: String) {
        
        guard firstName.isEmpty == false, lastName.isEmpty == false, self.date != nil else {
            self.nextButton.isEnabled = false
            return
        }
        
        self.nextButton.isEnabled = true
    }
    
    private func setDatePickerHidden(hidden: Bool) {
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentOffset = CGPoint(x: 0.0, y: hidden ? 0.0 : 150.0)
            self.view.layoutIfNeeded()
        }
        if !hidden {
            self.birthdayTextControl.isActive = true
        }
    }
}

extension KYCLegalNameViewController: GainyTextFieldControlDelegate {
    
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        if sender == self.birthdayTextControl {
            self.setDatePickerHidden(hidden: false)
        } else {
            self.setDatePickerHidden(hidden: true)
        }
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        
        if sender == self.firstNameTextControl {
            self.lastNameTextControl.isEditing = true
        } else if sender == self.lastNameTextControl {
            self.birthdayTextControl.isEditing = true
            self.setDatePickerHidden(hidden: false)
        } else {
            if self.firstNameTextControl.text.isEmpty {
                self.firstNameTextControl.isEditing = true
            } else if self.lastNameTextControl.text.isEmpty {
                self.lastNameTextControl.isEditing = true
            } else {
                self.updateNextButtonState(firstName: self.firstNameTextControl.text, lastName: self.lastNameTextControl.text)
            }
        }
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {
        
        if sender == self.firstNameTextControl {
            self.updateNextButtonState(firstName: text, lastName: self.lastNameTextControl.text)
        } else if sender == self.lastNameTextControl {
            self.updateNextButtonState(firstName: self.firstNameTextControl.text, lastName: text)
        } else {
            print("Date text \(text)")
                        
            if text.count == 10 {
                if let newDate = AppDateFormatter.shared.date(from: text, dateFormat: .MMddyyyyDot) {
                    
                    let year = Calendar.current.dateComponents([.year], from: newDate, to: Date()).year ?? 0
                    
                    if year < 18 {
                        birthdayTextControl.setErrorBorder()
                        return
                    }
                    
                    if year > 100 {
                        birthdayTextControl.setErrorBorder()
                        return
                    }
                    
                    date = newDate
                    self.updateNextButtonState(firstName: self.firstNameTextControl.text, lastName: self.lastNameTextControl.text)
                    birthdayTextControl.isActive = true
                } else {
                    birthdayTextControl.setErrorBorder()
                }
            } else {
                birthdayTextControl.setErrorBorder()
            }
        }
    }
    
    
}

