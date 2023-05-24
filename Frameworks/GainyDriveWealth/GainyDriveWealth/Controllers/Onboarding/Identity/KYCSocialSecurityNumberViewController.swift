//
//  KYCSocialSecurityNumberViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon

final class KYCSocialSecurityNumberViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEventAMP("dw_kyc_ssn_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        if let cache = self.coordinator?.kycDataSource.kycFormCache {
            if let ssnCode = cache.tax_id_value {
                self.codeString = ssnCode
            }
        }
        self.updateUI()
        self.validateAmount()
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet var codeSymbols: [UILabel]!
    
    @IBOutlet var secDisclaimerBtn: UIButton! {
        didSet {
            secDisclaimerBtn.titleLabel?.font = .proDisplaySemibold(12)
        }
    }
    
    @IBOutlet private weak var showHideButton: GainyButton! {
        didSet {
            showHideButton.configureWithTitle(title: "Show", color: UIColor(hexString: "#0062FF") ?? UIColor.blue, state: .normal)
            showHideButton.configureWithTitle(title: "Show", color: UIColor(hexString: "#0062FF") ?? UIColor.blue, state: .disabled)
            showHideButton.configureWithBackgroundColor(color: UIColor.clear)
            showHideButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
            showHideButton.configureWithFont(font: UIFont.proDisplayMedium(14.0))
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
            padView.buttonRadius = 16.0
        }
    }
    
    @IBAction func showHideButtonAction(_ sender: Any) {
        
        self.shown.toggle()
        self.updateUI()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.tax_id_value = self.codeString
            cache.tax_id_type = "SSN"
            cache.identity_filled = true
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        GainyAnalytics.logEventAMP("dw_kyc_ssn_e")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private var codeString: String = ""
    private var shown: Bool = false
    private func updateUI() {
        
        let title = self.shown ? "Hide SSN" : "Show SSN"
        self.showHideButton.configureWithTitle(title: title, color: UIColor(hexString: "#0062FF") ?? UIColor.blue, state: .normal)
        self.showHideButton.configureWithTitle(title: title, color: UIColor(hexString: "#0062FF") ?? UIColor.blue, state: .disabled)
        
        self.validateAmount()
    }
    
    @IBAction func secDisclaimerAction(_ sender: Any) {
        coordinator?.showSSNDisclaimerView()
    }
}

extension KYCSocialSecurityNumberViewController: GainyPadViewDelegate {
    
    func deleteDigit(view: GainyPadView) {
        if codeString.count <= 9 {
            codeString = String(codeString.dropLast(1))
        }
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        if codeString.count < 9 {
            codeString.append(digit)
        }
        validateAmount()
    }
    
    func validateAmount() {
 
        let count = self.codeString.count
        let valid = count == 9
        nextButton.isEnabled = valid
        
        var string = self.codeString
        for i in 0..<self.codeSymbols.count {
            let label = self.codeSymbols[i]
            let first = String(string.prefix(1))
            if first.isEmpty {
                label.text = "•"
                label.textColor = UIColor(hexString: "#B1BDC8")
            } else {
                label.text = self.shown ? first : "•"
                label.textColor = UIColor.black
            }
            string = String(string.dropFirst())
        }
    }
}
