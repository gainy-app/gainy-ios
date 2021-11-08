//
//  PersonalInfoViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/21/21.
//

import UIKit

final class PersonalInfoViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?
    weak var authorizationManager: AuthorizationManager?
    
    public var onboardingDone: Bool?
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var registerButton: BorderButton!
    @IBOutlet private weak var firstNameTextField: GainyTextField!
    @IBOutlet private weak var lastNameTextField: GainyTextField!
    @IBOutlet private weak var emailTextField: GainyTextField!
    @IBOutlet private weak var legalAddressTextView: UITextView!
    
    @IBOutlet private weak var legalAddressPlaceholder: UILabel!
    @IBOutlet private weak var legalAddressSmallPlaceholder: UILabel!
    @IBOutlet private weak var emailSmallPlaceholder: UILabel!
    @IBOutlet private weak var lastNameSmallPlaceholder: UILabel!
    @IBOutlet private weak var firstNameSmallPlaceholder: UILabel!
    
    private weak var activeInputView: UIView?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpNavigationBar()
        self.setUpTextFields()
        self.updateRegisterButtonEnabledState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        scrollView.contentInset.bottom = 0
        self.didTapDone(sender: nil)
    }
    
    @IBAction private func formCRSTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("form_CRS_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
        if let url = URL(string: "https://www.gainy.app/form-adv") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction private func contentToEDelivatyTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_to_EDelivaty_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
        if let url = URL(string: "https://drive.google.com/file/d/1y6Llkc8wNiUetPvqd9XH9zQATR7LMAek/view?usp=sharing") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction private func privacyNoticeTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_privacy_notice_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
        if let url = URL(string: "https://www.gainy.app/privacy-notice") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction private func clientAgreementTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_client_agreement_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
        if let url = URL(string: "https://drive.google.com/file/d/1faoz7rAh6dw7wa0BQYRhokLPGou9CW-L/view?usp=sharing") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction private func privacyPolicyTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_privacy_policy_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
        if let url = URL(string: "https://www.gainy.app/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction private func termsOfServiceTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_terms_of_service_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
        if let url = URL(string: "https://www.gainy.app/terms-of-service") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction private func registerButtonTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("content_register_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
        self.coordinator?.profileInfoBuilder.firstName = self.firstNameTextField.text
        self.coordinator?.profileInfoBuilder.lastName = self.lastNameTextField.text
        self.coordinator?.profileInfoBuilder.email = self.emailTextField.text
        self.coordinator?.profileInfoBuilder.legalAddress = self.legalAddressTextView.text
        
        let onboardingFinished = self.onboardingDone ?? false
        if onboardingFinished {
            self.coordinator?.presentOnboardingFinalizingViewController()
        } else {
            self.coordinator?.setRootIntroductionViewController()
        }
    }
    
    @objc private func closeButtonTap(sender: UIBarButtonItem) {
        
        GainyAnalytics.logEvent("personalization_info_close", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPersonalInfo"])
        self.coordinator?.dismissModule()
    }
    
    @objc private func didTapDone(sender: Any?) {
        
         self.view.endEditing(true)
         scrollView.contentInset.bottom = 0
    }
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        
        guard let keyboardFrame = self.keyboardSize else { return }
        
        guard let animationDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        
        if let inputView = self.activeInputView {
            let viewHeight = self.view.bounds.height
            let keyboardHeight = view.convert(keyboardFrame, from: nil).size.height
            let inputViewMaxY = inputView.frame.maxY + scrollView.frame.origin.y
            let keyboardTopY = (viewHeight - keyboardHeight)
            let offset = CGFloat(40.0)
            var bottomEdgeOffset = CGFloat(0.0)
            if (inputViewMaxY + offset) > keyboardTopY {
                bottomEdgeOffset = (inputViewMaxY + offset) - keyboardTopY
            }
            if scrollView.frame.maxY + offset > keyboardTopY {
                scrollView.contentInset.bottom = (scrollView.frame.maxY + offset - keyboardTopY)
            }
            UIView.animate(withDuration: animationDuration.doubleValue) {
                self.scrollView.contentOffset.y = bottomEdgeOffset
            }
        }
 
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedRegular(14)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = NSLocalizedString("Welcome on board", comment: "Welcome on board").uppercased()
   
        let closeImage = UIImage(named: "iconClose")
        let closeItem = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTap(sender:)))
        closeItem.tintColor = UIColor.black
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItems = [closeItem]
    }
    
    private func setUpTextFields() {
        
        self.firstNameTextField.insets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.lastNameTextField.insets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.emailTextField.insets = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.legalAddressTextView.textContainerInset = UIEdgeInsets(top: 22.0, left: 11.0, bottom: 22.0, right: 11.0)
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.legalAddressTextView.delegate = self
        
        let doneTitle = NSLocalizedString("Done", comment: "Done")
        self.legalAddressTextView.addDoneButton(title: doneTitle, target: self, selector: #selector(didTapDone(sender:)))
        
        self.firstNameTextField.text = self.authorizationManager?.firstName
        self.lastNameTextField.text = self.authorizationManager?.lastName
        self.emailTextField.text = self.authorizationManager?.email
    }
}

extension PersonalInfoViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        self.updatePlaceholderStates(textField, updatedText)
        self.updateRegisterButtonEnabledState(textField, updatedText)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        self.updatePlaceholderStates(textField, textField.text ?? "")
        self.updateRegisterButtonEnabledState()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.updateRegisterButtonEnabledState()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.activeInputView = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.updateRegisterButtonEnabledState()
        if textField == self.firstNameTextField {
            self.lastNameTextField.becomeFirstResponder()
        }
        if textField == self.lastNameTextField {
            self.emailTextField.becomeFirstResponder()
        }
        if textField == self.emailTextField {
            self.legalAddressTextView.becomeFirstResponder()
        }
        
        return true
    }
    
    private func updatePlaceholderStates(_ textField: UITextField, _ text: String) {
        
        var gainyTextField: GainyTextField? = nil
        var placeholderLabel: UILabel? = nil
        if textField == self.firstNameTextField {
            placeholderLabel = self.firstNameSmallPlaceholder
            gainyTextField = self.firstNameTextField
        }
        if textField == self.lastNameTextField {
            placeholderLabel = self.lastNameSmallPlaceholder
            gainyTextField = self.lastNameTextField
        }
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
    
    private func updateRegisterButtonEnabledState(_ textField: UITextField? = nil, _ updatedText: String? = nil) {
        
        var firstName = self.firstNameTextField.text
        var lastName = self.lastNameTextField.text
        var email = self.emailTextField.text
        
        if let textField = textField {
            if textField == self.firstNameTextField {
                firstName = updatedText
            }
            if textField == self.lastNameTextField {
                lastName = updatedText
            }
            if textField == self.emailTextField {
                email = updatedText
            }
        }
        
        let filled = firstName?.count ?? 0 > 0
        && lastName?.count ?? 0 > 0
        && email?.count ?? 0 > 0
        && self.legalAddressTextView.text?.count ?? 0 > 0
     
   
        let canRegister = filled && self.isValidEmailString(emailString: self.emailTextField.text ?? "")
        self.registerButton.isEnabled = canRegister
    }
    
    private func isValidEmailString(emailString: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let validEmail = emailPredicate.evaluate(with: emailString)
        
        return validEmail
    }
}

extension PersonalInfoViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        UIView.animate(withDuration: 0.25) {
            let topInset: CGFloat = ((updatedText.count > 0) ? 30.0 : 22.0)
            textView.textContainerInset = UIEdgeInsets(top: topInset, left: 11.0, bottom: 14.0, right: 11.0)
            textView.setNeedsDisplay()
            textView.setNeedsLayout()
            self.legalAddressPlaceholder.alpha = ((updatedText.count > 0) ? 0.0 : 1.0)
            self.legalAddressSmallPlaceholder.alpha = (1.0 - self.legalAddressPlaceholder.alpha)
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        self.updateRegisterButtonEnabledState()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        self.activeInputView = textView
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        self.updateRegisterButtonEnabledState()
        return true
    }
}
