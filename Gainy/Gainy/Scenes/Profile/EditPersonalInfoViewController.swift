//
//  EditPersonalInfoViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/27/21.
//

import UIKit

protocol EditPersonalInfoViewControllerDelegate: AnyObject {
    func didUpdateProfile(with firstName:String, lastName:String, email:String, legalAddress:String)
}

final class EditPersonalInfoViewController: BaseViewController {
    
    weak var delegate: EditPersonalInfoViewControllerDelegate?
    
    @IBOutlet private weak var scrollView: UIScrollView!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        fillTextFields()
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        scrollView.contentInset.bottom = 0
        self.didTapDone(sender: nil)
    }
    
    @objc private func backButtonTap(sender: UIBarButtonItem) {
        
        self.finishEditing()
        self.dismiss(animated: true, completion: nil)
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
    
    private func finishEditing() {
        
        guard
        let firstName = self.firstNameTextField.text,
        let lastName = self.lastNameTextField.text,
        let email = self.emailTextField.text,
        let legalAddress = self.legalAddressTextView.text else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        if hasValidChanges() {
            delegate?.didUpdateProfile(with: firstName, lastName: lastName, email: email, legalAddress: legalAddress)
        }
    }
    
    private func fillTextFields() {
       
        guard let firstName = UserProfileManager.shared.firstName,
        let lastName = UserProfileManager.shared.lastName,
        let email = UserProfileManager.shared.email,
        let legalAddress = UserProfileManager.shared.address else {
            return
        }
        
        guard self.firstNameTextField.text?.count == 0,
              self.lastNameTextField.text?.count == 0,
              self.emailTextField.text?.count == 0,
              self.legalAddressTextView.text?.count == 0 else {
            return
        }
        
        self.firstNameTextField.text = firstName
        self.lastNameTextField.text = lastName
        self.emailTextField.text = email
        self.legalAddressTextView.text = legalAddress
    }
    
    private func setUpNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.compactRoundedSemibold(14),
            NSAttributedString.Key.kern: 1.25]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let backImage = UIImage(named: "iconClose")
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTap(sender:)))
        backItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItems = [backItem]
        self.title = NSLocalizedString("Personal information", comment: "Personal information").uppercased()
    }
    
    private func setUpTextFields() {
        
        self.firstNameTextField.insets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.lastNameTextField.insets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.emailTextField.insets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 0.0, right: 16.0)
        self.legalAddressTextView.textContainerInset = UIEdgeInsets(top: 30.0, left: 11.0, bottom: 22.0, right: 11.0)
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.emailTextField.isEnabled = false
        self.emailTextField.alpha = 0.5
        self.legalAddressTextView.delegate = self
        
        self.legalAddressPlaceholder.alpha = 0.0
        self.legalAddressSmallPlaceholder.alpha = 1.0
        self.emailSmallPlaceholder.alpha = 0.5
        self.firstNameSmallPlaceholder.alpha = 1.0
        self.lastNameSmallPlaceholder.alpha = 1.0
        
        let doneTitle = NSLocalizedString("Done", comment: "Done")
        self.legalAddressTextView.addDoneButton(title: doneTitle, target: self, selector: #selector(didTapDone(sender:)))
    }
}

extension EditPersonalInfoViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        self.updatePlaceholderStates(textField, updatedText)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        self.updatePlaceholderStates(textField, textField.text ?? "")
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.activeInputView = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.firstNameTextField {
            self.lastNameTextField.becomeFirstResponder()
        }
        if textField == self.lastNameTextField {
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
    
    private func hasValidChanges() -> Bool {
        
        let firstName = self.firstNameTextField.text
        let lastName = self.lastNameTextField.text
        let email = self.emailTextField.text
        let legalAddress = self.legalAddressTextView.text
        
        let filled = firstName?.count ?? 0 > 0
        && lastName?.count ?? 0 > 0
        && email?.count ?? 0 > 0
        && legalAddress?.count ?? 0 > 0
        
        let changedFromStored = UserProfileManager.shared.firstName != firstName ||  UserProfileManager.shared.lastName != lastName || UserProfileManager.shared.email != email || UserProfileManager.shared.address != legalAddress
     
        let hasValidChanges = filled && self.isValidEmailString(emailString: self.emailTextField.text ?? "") && changedFromStored
        return hasValidChanges
    }
    
    private func isValidEmailString(emailString: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let validEmail = emailPredicate.evaluate(with: emailString)
        
        return validEmail
    }
}

extension EditPersonalInfoViewController: UITextViewDelegate {
    
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
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        self.activeInputView = textView
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        return true
    }
}
