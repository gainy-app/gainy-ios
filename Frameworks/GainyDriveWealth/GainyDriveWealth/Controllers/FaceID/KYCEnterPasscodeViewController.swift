//
//  KYCEnterPasscodeViewController.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 13.12.22.
//

import UIKit
import GainyCommon
import CryptoKit
import LocalAuthentication

class KYCEnterPasscodeViewController: DWBaseViewController {
    
    private var codeString: String = ""
    var passcode: String = "????"
    public var isValidEnter: BoolHandler?
    @KeychainString("passcodeSHA256")
    internal var passcodeSHA256: String?
    
    @UserDefaultBool("useFaceID")
    internal var useFaceID: Bool
    private var context = LAContext()
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet private weak var padView: GainyPadView! {
        didSet {
            padView.delegate = self
        }
    }
    
    @IBOutlet var codeSymbols: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gainyNavigationBar.isHidden = true
        welcomeLabel.text = "Nice to see you"
        
        if let firstName = coordinator?.userProfile.firstNameRepresentale {
            welcomeLabel.text = "Nice to see you, \n\(firstName)"
        }
        if useFaceID {
            let reason = "Log in with Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
                if success {
                    self?.isValidEnter?(true)
                }
                if let error = error as? LAError {
                    switch error.code {
                    case .passcodeNotSet:
                        self?.isValidEnter?(false)
                    default:
                        return
                    }
                }
            }
        }
    }
    
    @IBAction func didTapForgotPassword(_ sender: Any) {
        isValidEnter?(false)
    }
}

extension KYCEnterPasscodeViewController: GainyPadViewDelegate {
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
    
    func didSuccessBiometry() {
        isValidEnter?(true)
    }
    
    func didFailBiometry() {
        isValidEnter?(false)
    }
    
    func validateAmount() {
        let count = self.codeString.count
        var valid = count == 4
        if valid {
            if let data = self.codeString.data(using: .utf8) {
                let digest = SHA256.hash(data: data)
                if passcodeSHA256 == digest.hexStr {
                    isValidEnter?(true)
                }
            }
        }

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
