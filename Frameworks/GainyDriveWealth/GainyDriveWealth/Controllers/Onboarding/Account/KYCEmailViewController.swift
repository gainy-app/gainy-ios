//
//  KYCEmailViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import GainyAPI

final class KYCEmailViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        GainyAnalytics.logEventAMP("dw_kyc_email_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        self.setUpTextFields()
        self.updateNextButtonEnabledState(self.emailTextField, self.emailTextField.text)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.emailTextField.resignFirstResponder()
    }
    
    @IBOutlet private weak var emailTextField: GainyTextField!
    @IBOutlet private weak var emailSmallPlaceholder: UILabel!
    
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
            cache.email_address = self.emailTextField.text
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        
        if self.coordinator?.isErrorCodeMode ?? false {
            if self.coordinator?.haveCodeToJump() ?? false {
                self.coordinator?.jumpToNextCode()
            } else {
                self.coordinator?.finishCodes()
            }
        } else {
            self.coordinator?.showKYCPhoneView()
        }
        GainyAnalytics.logEventAMP("dw_kyc_email_e", params: ["email" : self.emailTextField.text])
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private func setUpTextFields() {
        
        var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.emailAddress?.placeholder
        if let cache = self.coordinator?.kycDataSource.kycFormCache {
            defaultValue = cache.email_address ?? defaultValue
        }
        self.emailTextField.text = defaultValue
        self.emailTextField.insets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.emailTextField.delegate = self
    }
}

extension KYCEmailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        self.updatePlaceholderState(textField, updatedText)
        self.updateNextButtonEnabledState(textField, updatedText)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        self.updatePlaceholderState(textField, textField.text ?? "")
        self.updateNextButtonEnabledState()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.updateNextButtonEnabledState()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.updateNextButtonEnabledState()
        if self.nextButton.isEnabled {
            self.nextButtonAction(self.nextButton as Any)
        }
        return true
    }
    
    private func updatePlaceholderState(_ textField: UITextField, _ text: String) {
        
        var gainyTextField: GainyTextField? = nil
        var placeholderLabel: UILabel? = nil

        if textField == self.emailTextField {
            placeholderLabel = self.emailSmallPlaceholder
            gainyTextField = self.emailTextField
        }
        
        UIView.animate(withDuration: 0.25) {
            let topInset: CGFloat = ((text.count > 0) ? 8.0 : 0.0)
            gainyTextField?.insets = UIEdgeInsets(top: topInset, left: 16.0, bottom: 0.0, right: 16.0)
            gainyTextField?.setNeedsDisplay()
            gainyTextField?.setNeedsLayout()
            placeholderLabel?.alpha = ((text.count > 0) ? 1.0 : 0.0)
        }
    }
    
    private func updateNextButtonEnabledState(_ textField: UITextField? = nil, _ updatedText: String? = nil) {
        
        if let required = self.coordinator?.kycDataSource.kycFormConfig?.emailAddress?.required {
            if !required {
                self.nextButton.isEnabled = true
                return
            }
        }
        
        var email = self.emailTextField.text
        if let textField = textField {
            if textField == self.emailTextField {
                email = updatedText
            }
        }
        
        let filled = email?.count ?? 0 > 0
        let validEmail = filled && self.isValidEmailString(emailString: email ?? "")
        self.nextButton.isEnabled = validEmail
    }
    
    private func isValidEmailString(emailString: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let validEmail = emailPredicate.evaluate(with: emailString)
        
        return validEmail
    }
}

