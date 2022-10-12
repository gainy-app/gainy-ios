//
//  KYCVerifyPhoneViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon

enum KYCPasscodeViewControllerState: Int {
    
    case create, verify
}

final class KYCPasscodeViewController: DWBaseViewController {
    
    public var state: KYCPasscodeViewControllerState = .create
    public var passcode: String = "????"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if self.state == .create {
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
            let title = self.state == .create ? "Create passcode" : "Confirm passcode"
            titleLabel.text = title
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
            self.coordinator?.showKYCVerifyPasscodeView(passcode: self.codeString)
        } else {
            // TODO: KYC - save passcode
            self.coordinator?.showKYCFaceIDView()
        }
    }
    
    private var codeString: String = ""
    private func updateUI() {
        
        self.validateAmount()
    }
}

extension KYCPasscodeViewController: GainyPadViewDelegate {
    
    func deleteDigit(view: GainyPadView) {
        codeString = String(codeString.dropLast(1))
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        codeString.append(digit)
        validateAmount()
    }
    
    func validateAmount() {
 
        let count = self.codeString.count
        var valid = count == 4
        if self.state == .verify {
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
