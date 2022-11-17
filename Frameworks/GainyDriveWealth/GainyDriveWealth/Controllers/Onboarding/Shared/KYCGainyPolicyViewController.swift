//
//  KYCGainyPolicyViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import CountryKit

final class KYCGainyPolicyViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    @IBOutlet private weak var textView: UITextView! {
        didSet {
            if let rtfPath = Bundle(identifier: "app.gainy.framework.GainyDriveWealth")?.path(forResource: "GainyPrivacyPolicy", ofType: "rtf") {
                  do {
                      let url = NSURL.fileURL(withPath: rtfPath)
                      let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: url, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                      self.textView.attributedText = attributedStringWithRtf
                  } catch let error {
                      print("Got an error \(error)")
                  }
              }
        }
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
            cache.disclosures_gainy_policy_agreement = true
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showCitizenshipSelector()
    }
}
