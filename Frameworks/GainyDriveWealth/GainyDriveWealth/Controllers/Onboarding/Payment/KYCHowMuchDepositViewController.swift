//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors


final class KYCHowMuchDepositViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEvent("dw_kyc_deposit_s")
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.setupWithLoadFormConfigAsNeeded()
        validateAmount()
    }
    
    @IBOutlet weak var cornerView: UIView! {
        didSet {
            cornerView.layer.borderWidth = 2.0
            cornerView.layer.borderColor = UIColor(hexString: "#0062FF")?.cgColor ?? UIColor.blue.cgColor
        }
    }
    
    @IBOutlet weak var textLabel: UILabel! {
        didSet {
            textLabel.textColor = UIColor(hexString: "##B1BDC8") ?? UIColor.lightGray
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel! {
        didSet {
            errorLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var nextButton: GainyButton! {
        didSet {
            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .normal)
            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .disabled)
        }
    }
    
    @IBOutlet private weak var padView: GainyPadView! {
        didSet {
            padView.delegate = self
        }
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        GainyAnalytics.logEvent("dw_kyc_deposit_e", params: ["amount" : self.textLabel.text])
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.how_much_deposit = Double(String(textLabel.text!.dropFirst()))
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCMainMenu()
    }
    
    private func setupWithLoadFormConfigAsNeeded() {
        
        if self.coordinator?.kycDataSource.kycFormConfig == nil {
            self.showNetworkLoader()
            self.coordinator?.kycDataSource.loadKYCFormConfig({ success in
                if !success {
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.showErrorAlert()
                    }
                    return
                }
                self.coordinator?.kycDataSource.loadKYCFormValues({ valuesSuccess in
                    
                    DispatchQueue.main.async {
                        self.hideLoader()
                        if self.coordinator?.kycDataSource.kycFormCache == nil {
                            self.coordinator?.kycDataSource.kycFormCache = DWKYCDataCache.init()
                        }
                        self.coordinator?.kycDataSource.updateKYCCacheFromFormValues()
                        if let cache = self.coordinator?.kycDataSource.kycFormCache {
                            let howMuchDeposit = (cache.how_much_deposit != nil) ? "\(cache.how_much_deposit!)" : ""
                            self.textLabel.text = "$" + howMuchDeposit
                            self.validateAmount()
                        }
                    }
                })
            })
        } else {
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                let howMuchDeposit = (cache.how_much_deposit != nil) ? "\(cache.how_much_deposit!)" : ""
                self.textLabel.text = "$" + howMuchDeposit
                validateAmount()
            }
        }
    }
    
    private func showErrorAlert() {
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("Could not load KYC data, please try again later.", comment: ""), preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
            self.dismiss(animated: true)
        }
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        GainyAnalytics.reportNonFatalError(.popupShowned(reason: "Could not load KYC data, please try again later."))
    }
}

extension KYCHowMuchDepositViewController: GainyPadViewDelegate {
    
    func deleteDigit(view: GainyPadView) {
        guard textLabel.text!.count > 1 else {return}
        textLabel.text = String(textLabel.text!.dropLast(1))
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        textLabel.text?.append(digit)
        validateAmount()
    }
    
    func validateAmount() {
        
        var valid = false
        if let value = Double(String(textLabel.text!.dropFirst())) {
            valid = value >= 500.0
        }
        textLabel.textColor =
        Double(String(textLabel.text!.dropFirst())) != nil ? UIColor.black : (UIColor(hexString: "##B1BDC8") ?? UIColor.lightGray)
        nextButton.isEnabled = valid
        if valid {
            cornerView.layer.borderColor = UIColor(hexString: "#0062FF")?.cgColor ?? UIColor.blue.cgColor
        } else {
            cornerView.layer.borderColor = UIColor(hexString: "#F95664")?.cgColor ?? UIColor.red.cgColor
        }
        errorLabel.isHidden = valid || String(textLabel.text!.dropFirst()).count == 0
    }
}
