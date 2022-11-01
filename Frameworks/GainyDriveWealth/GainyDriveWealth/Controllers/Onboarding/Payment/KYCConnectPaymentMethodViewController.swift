//
//  KYCConnectPaymentMethodViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors


final class KYCConnectPaymentMethodViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        self.showNetworkLoader()
        self.coordinator?.kycDataSource.loadKYCFromConfig({ success in
            self.hideLoader()
            if !success {
                let alertController = UIAlertController(title: nil, message: NSLocalizedString("Could not load KYC data, please try again later.", comment: ""), preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
                    self.dismiss(animated: true)
                }
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    @IBOutlet weak var nextButton: GainyButton! {
        didSet {
            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .normal)
            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .disabled)
        }
    }
    
    @IBOutlet weak var cardButton: GainyButton! {
        didSet {
            cardButton.configureWithTitle(title: "", color: UIColor.white, state: .normal)
            cardButton.configureWithTitle(title: "", color: UIColor.white, state: .disabled)
            cardButton.configureWithBackgroundColor(color: UIColor.white)
            cardButton.configureWithHighligtedBackgroundColor(color: UIColor.white)
            cardButton.configureWithBorder(borderWidth: 2.0, borderColor: UIColor(hexString: "#0062FF") ?? UIColor.blue)
        }
    }
    
    @IBOutlet weak var bankButton: GainyButton! {
        didSet {
            bankButton.configureWithTitle(title: "", color: UIColor.white, state: .normal)
            bankButton.configureWithTitle(title: "", color: UIColor.white, state: .disabled)
            bankButton.configureWithBackgroundColor(color: UIColor.white)
            bankButton.configureWithHighligtedBackgroundColor(color: UIColor.white)
        }
    }
    
    @IBOutlet weak var applePayButton: GainyButton! {
        didSet {
            applePayButton.configureWithTitle(title: "", color: UIColor.white, state: .normal)
            applePayButton.configureWithTitle(title: "", color: UIColor.white, state: .disabled)
            applePayButton.configureWithBackgroundColor(color: UIColor.white)
            applePayButton.configureWithHighligtedBackgroundColor(color: UIColor.white)
        }
    }
    
    @IBAction func cardBtnAction(_ sender: Any) {
        cardButton.configureWithBorder(borderWidth: 2.0, borderColor: UIColor(hexString: "#0062FF") ?? UIColor.blue)
        bankButton.configureWithBorder(borderWidth: 0.0, borderColor: UIColor.clear)
        applePayButton.configureWithBorder(borderWidth: 0.0, borderColor: UIColor.clear)
    }
    
    @IBAction func bankBtnAction(_ sender: Any) {
        bankButton.configureWithBorder(borderWidth: 2.0, borderColor: UIColor(hexString: "#0062FF") ?? UIColor.blue)
        cardButton.configureWithBorder(borderWidth: 0.0, borderColor: UIColor.clear)
        applePayButton.configureWithBorder(borderWidth: 0.0, borderColor: UIColor.clear)
    }
    
    @IBAction func applePayBtnAction(_ sender: Any) {
        applePayButton.configureWithBorder(borderWidth: 2.0, borderColor: UIColor(hexString: "#0062FF") ?? UIColor.blue)
        bankButton.configureWithBorder(borderWidth: 0.0, borderColor: UIColor.clear)
        cardButton.configureWithBorder(borderWidth: 0.0, borderColor: UIColor.clear)
    }
    
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        self.coordinator?.showKYCMainMenu()
    }
}

