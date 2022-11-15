//
//  KYCDWPolicyViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import CountryKit

final class KYCDWPolicyViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBOutlet private weak var nextButton: GainyButton! {
        didSet {
            nextButton.configureWithTitle(title: "I accept", color: UIColor.white, state: .normal)
            nextButton.configureWithCornerRadius(radius: 16.0)
            nextButton.configureWithBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.configureWithHighligtedBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.disclosures_drivewealth_customer_agreement = true
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
    }
}
