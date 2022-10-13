//
//  KYCLegalNameViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors

final class KYCLegalNameViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        self.gainyNavigationBar.backgroundColor = self.view.backgroundColor
        self.firstNameTextControl.isEditing = true
        self.scrollView.isScrollEnabled = false
    }
    
    @IBOutlet private weak var firstNameTextControl: GainyTextFieldControl! {
        didSet {
            firstNameTextControl.delegate = self
            firstNameTextControl.configureWithText(text: "", placeholder: "Legal first name", smallPlaceholder: "Legal first name")
        }
    }
    
    @IBOutlet private weak var lastNameTextControl: GainyTextFieldControl! {
        didSet {
            lastNameTextControl.delegate = self
            lastNameTextControl.configureWithText(text: "", placeholder: "Legal last name", smallPlaceholder: "Legal last name")
        }
    }
    
    @IBOutlet private weak var birthdayTextControl: GainyTextFieldControl! {
        didSet {
            birthdayTextControl.delegate = self
            birthdayTextControl.configureWithText(text: "", placeholder: "Birthday", smallPlaceholder: "Birthday")
            birthdayTextControl.textFieldEnabled = false
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
    
    @IBOutlet private weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
            datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
            datePicker.date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
        }
    }
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var datePickerBottom: NSLayoutConstraint!
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        // TODO: KYC - save Legal Name
        self.coordinator?.showKYCResidentalAddressView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM.dd.yyyy"
        let selectedDate: String = dateFormatter.string(from: sender.date)
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
            self.datePickerBottom?.constant = hidden ? -300.0 : 0.0
            self.view.layoutIfNeeded()
        }
        self.datePicker.becomeFirstResponder()
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
        }
    }
}

