//
//  KYCVerifyPhoneViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import CryptoKit

enum KYCPasscodeViewControllerState: Int {
    
    case create, confirm, enter
}

final class KYCPasscodeViewController: DWBaseViewController {
    
    public var state: KYCPasscodeViewControllerState = .create
    public var passcode: String = "????"
    
    public var passcodeValidatedHandler: (() -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GainyAnalytics.logEvent("dw_kyc_passcode_s")
        if self.state == .create || self.state == .enter  {
            self.gainyNavigationBar.configureWithItems(items: [.close])
        } else {
            self.gainyNavigationBar.configureWithItems(items: [.back, .close])
            self.gainyNavigationBar.backActionHandler = { sender in
                self.coordinator?.pop()
            }
        }
        self.validateAmount()
    }
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            switch self.state {
            case .create:
                titleLabel.text = "Create passcode"
                break
            case .confirm:
                titleLabel.text = "Confirm passcode"
                break
            case .enter:
                titleLabel.text = "Enter passcode"
                break
            }
        }
    }
    
    @IBOutlet var codeSymbols: [UILabel]!
    
    @IBOutlet private weak var nextButton: GainyButton! {
        didSet {
            let title = self.state == .create ? "Create" : "Confirm"
            nextButton.configureWithTitle(title: title, color: UIColor.white, state: .normal)
            nextButton.configureWithTitle(title: title, color: UIColor.white, state: .disabled)
            nextButton.configureWithCornerRadius(radius: 16.0)
            nextButton.configureWithBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.configureWithHighligtedBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.isEnabled = false
        }
    }
    
    @IBOutlet private weak var padView: GainyPadView! {
        didSet {
            padView.delegate = self
            padView.hideDot = true
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if self.state == .create {
            GainyAnalytics.logEvent("dw_kyc_passcode_create")
            self.coordinator?.showKYCVerifyPasscodeView(passcode: self.codeString)
        } else if self.state == .confirm {
            GainyAnalytics.logEvent("dw_kyc_passcode_confirm")
            if let data = self.codeString.data(using: .utf8) {
                let digest = SHA256.hash(data: data)
                self.coordinator?.kycDataSource.passcodeSHA256 = digest.hexStr
            }
            self.coordinator?.showKYCFaceIDView()
        } else if self.state == .enter {
            GainyAnalytics.logEvent("dw_kyc_passcode_enter")
            if let data = self.codeString.data(using: .utf8), let passcodeSHA256 = self.coordinator?.kycDataSource.passcodeSHA256 {
                let digest = SHA256.hash(data: data)
                if digest.hexStr != passcodeSHA256 {
                    let alertController = UIAlertController(title: nil, message: NSLocalizedString("Passcode is invalid, please try again.", comment: ""), preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
                        
                    }
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                self.passcodeValidatedHandler?()
            }
        }
    }
    
    private var codeString: String = ""
    private func updateUI() {
        
        self.validateAmount()
    }
}

extension KYCPasscodeViewController: GainyPadViewDelegate {
    
    func deleteDigit(view: GainyPadView) {
        if codeString.count <= 4 {
            codeString = String(codeString.dropLast(1))
        }
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        if codeString.count < 4 {
            codeString.append(digit)
        }
        validateAmount()
    }
    
    func validateAmount() {
 
        let count = self.codeString.count
        var valid = count == 4
        if self.state == .enter {
            valid = (self.passcode == self.codeString)
        }
        nextButton.isEnabled = valid
        
        var string = self.codeString
        for i in 0..<self.codeSymbols.count {
            let label = self.codeSymbols[i]
            let first = String(string.prefix(1))
            if first.isEmpty {
                label.text = "・"
                label.textColor = UIColor(hexString: "#B1BDC8")
            } else {
                label.text = "・"
                label.textColor = UIColor(hexString: "#0062FF")
            }
            string = String(string.dropFirst())
        }
    }
}

extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}
