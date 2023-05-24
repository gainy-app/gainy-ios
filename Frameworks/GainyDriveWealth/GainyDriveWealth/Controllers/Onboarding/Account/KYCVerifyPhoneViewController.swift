//
//  KYCVerifyPhoneViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon

final class KYCVerifyPhoneViewController: DWBaseViewController {
    
    public var last4Digits: String = "••••"
    public var phoneNumber: String = ""
    public var email: String = ""
    
    enum Mode {
        case email, phone
    }
    
    var mode: Mode = .phone
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEventAMP("dw_kyc_phone_verify_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        _ = self.validate(text: "")
        
        loadState()
        self.textField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.textField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    private func loadState() {
        if mode == .phone {
            descriptionLabel.text = "We sent a code to (•••) ••• \(self.last4Digits).\nEnter it here."
            sendVerifyPhoneCode()
        } else {
            descriptionLabel.text = "We sent a code to (•••) ••• \(self.last4Digits).\nEnter it here."
            sendVerifyEmailCode()
        }
    }
    
    //MARK: - Validation
    
    private var sendCodeId: String = ""
    
    /// Sending verify code
    private func sendVerifyPhoneCode() {
        showNetworkLoader()
        Task {
            do {
                let codeSendRes = try await dwAPI.sendVerifyMessageChannel(channel: .sms, address: phoneNumber)
                sendCodeId = codeSendRes.verificationCodeId
                await MainActor.run {
                    hideLoader()
                }
            } catch {
                await MainActor.run {
                    showAlert(message: "\(error.localizedDescription)")
                    hideLoader()
                }
            }
        }
    }
    
    /// Sending verify code to Email
    private func sendVerifyEmailCode() {
        showNetworkLoader()
        Task {
            do {
                let codeSendRes = try await dwAPI.sendVerifyMessageChannel(channel: .email, address: phoneNumber)
                sendCodeId = codeSendRes.verificationCodeId
                await MainActor.run {
                    hideLoader()
                }
            } catch {
                await MainActor.run {
                    showAlert(message: "\(error.localizedDescription)")
                    hideLoader()
                }
            }
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            
        }
    }
    
    @IBOutlet private weak var textField: UITextField! {
        didSet {
            self.textField.delegate = self
            self.textField.keyboardType = .numberPad
        }
    }
    
    @IBOutlet var codeSymbols: [UILabel]!
    
    @IBOutlet private weak var sendAgainButton: GainyButton! {
        didSet {
            sendAgainButton.configureWithTitle(title: "Send Again", color: UIColor(hexString: "#0062FF") ?? UIColor.blue, state: .normal)
            sendAgainButton.configureWithTitle(title: "Send Again", color: UIColor(hexString: "#0062FF") ?? UIColor.blue, state: .disabled)
            sendAgainButton.configureWithBackgroundColor(color: UIColor.clear)
            sendAgainButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
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
    
    @IBAction func sendAgainButtonAction(_ sender: Any) {
        sendVerifyPhoneCode()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        validateCode()
    }
    
    private func validateCode() {
        showNetworkLoader()
        Task {
            do {
                let codeSendRes = try await dwAPI.verifyMessageChannel(verificationCodeID: sendCodeId, userInput: codeString)
                await MainActor.run {
                    commitCodeAndMove()
                    hideLoader()
                }
            } catch {
                await MainActor.run {
                    showAlert(message: "\(error.localizedDescription)")
                    hideLoader()
                }
            }
        }
    }
    
    private func commitCodeAndMove() {
        GainyAnalytics.logEventAMP("dw_kyc_phone_verify_e")
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.phone_number = self.phoneNumber
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCPasscodeView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private var codeString: String = ""
    private func updateUI() {
        
        _ = self.validate(text: self.codeString)
    }
}

extension KYCVerifyPhoneViewController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        
        return validate(text: updatedText)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func validate(text: String) -> Bool {
 
        let count = text.count
        
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        let isNumber = CharacterSet(charactersIn: text).isSubset(of: digitsCharacters)
        let valid = count <= 6 && isNumber
        nextButton.isEnabled = count >= 6 && isNumber
        
        self.codeString = text
        
        var string = self.codeString
        for i in 0..<self.codeSymbols.count {
            let label = self.codeSymbols[i]
            let first = String(string.prefix(1))
            if first.isEmpty {
                label.text = "・"
                label.textColor = UIColor(hexString: "#B1BDC8")
            } else {
                label.text = first
                label.textColor = UIColor.black
            }
            string = String(string.dropFirst())
        }
        
        return valid
    }
}

