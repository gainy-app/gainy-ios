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
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        self.validateAmount()
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = "We sent a code to (•••) ••• \(self.last4Digits).\nEnter it here."
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
        
        // TODO: KYC - save phone
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
        codeString = String(codeString.dropLast(1))
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        codeString.append(digit)
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
