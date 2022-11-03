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
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.showNetworkLoader()
        self.coordinator?.kycDataSource.loadKYCFromConfig({ success in
            DispatchQueue.main.async {
                self.hideLoader()
                if success {
                    if let cache = self.coordinator?.kycDataSource.kycFormCache {
                        let howMuchDeposit = (cache.how_much_deposit != nil) ? "\(cache.how_much_deposit!)" : ""
                        self.textLabel.text = "$" + howMuchDeposit
                    } else {
                        self.coordinator?.kycDataSource.kycFormCache = DWKYCDataCache.init()
                    }
                    self.validateAmount()
                } else {
                    let alertController = UIAlertController(title: nil, message: NSLocalizedString("Could not load KYC data, please try again later.", comment: ""), preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
                        self.dismiss(animated: true)
                    }
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        })
    }
    
    @IBOutlet weak var cornerView: UIView! {
        didSet {
            cornerView.layer.borderWidth = 2.0
            cornerView.layer.borderColor = UIColor(hexString: "#0062FF")?.cgColor ?? UIColor.blue.cgColor
        }
    }
    
    @IBOutlet weak var textLabel: UILabel!
    {
        didSet {
            textLabel.textColor = UIColor(hexString: "##B1BDC8") ?? UIColor.lightGray
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
        
        // TODO: KYC Question - where to use how much deposit (no field in API)?
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.how_much_deposit = Double(String(textLabel.text!.dropFirst()))
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCPaymentMethodView()
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
        
        let valid = Double(String(textLabel.text!.dropFirst())) != nil
        textLabel.textColor =
        valid ? UIColor.black : (UIColor(hexString: "##B1BDC8") ?? UIColor.lightGray)
        nextButton.isEnabled = valid
    }
}
