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
        
        GainyAnalytics.logEvent("dw_kyc_phonev_s")
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        self.validateAmount()
        
        
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
    
    @IBOutlet private weak var padView: GainyPadView! {
        didSet {
            padView.delegate = self
            padView.hideDot = true
        }
    }
    
    @IBAction func sendAgainButtonAction(_ sender: Any) {
        
        // TODO: KYC - send code to phone
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
        GainyAnalytics.logEvent("dw_kyc_phonev_e")
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
        
        self.validateAmount()
    }
}

extension KYCVerifyPhoneViewController: GainyPadViewDelegate {
    
    func deleteDigit(view: GainyPadView) {
        if codeString.count <= 6 {
            codeString = String(codeString.dropLast(1))
        }
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        if codeString.count < 6 {
            codeString.append(digit)
        }
        validateAmount()
    }
    
    func validateAmount() {
 
        let count = self.codeString.count
        let valid = count == 6
        nextButton.isEnabled = valid
        
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
    }
}
