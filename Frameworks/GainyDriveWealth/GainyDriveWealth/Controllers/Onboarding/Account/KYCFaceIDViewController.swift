//
//  KYCFaceIDViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors


final class KYCFaceIDViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
    }
    
    @IBOutlet weak var useFaceIDBtn: GainyButton! {
        didSet {
            useFaceIDBtn.configureWithTitle(title: "Use Face ID", color: UIColor.white, state: .normal)
            useFaceIDBtn.configureWithTitle(title: "Use Face ID", color: UIColor.white, state: .disabled)
        }
    }
    
    @IBOutlet weak var noThanksBtn: GainyButton! {
        didSet {
            noThanksBtn.configureWithTitle(title: "No, thanks", color: UIColor.black, state: .normal)
            noThanksBtn.configureWithTitle(title: "No, thanks", color: UIColor.black, state: .disabled)
            noThanksBtn.configureWithBackgroundColor(color: UIColor.clear)
            noThanksBtn.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        }
    }
    
    @IBAction func useFaceIDBtnAction(_ sender: Any) {
        
        self.coordinator?.kycDataSource.useFaceID = true
        self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
    }
    
    @IBAction func noThanksBtnAction(_ sender: Any) {
        
        self.coordinator?.kycDataSource.useFaceID = false
        self.coordinator?.showKYCLegalNameView()
    }
}
