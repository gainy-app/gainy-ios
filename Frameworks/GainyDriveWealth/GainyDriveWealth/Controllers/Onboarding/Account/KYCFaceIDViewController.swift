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
        GainyAnalytics.logEvent("dw_kyc_face_id_s")
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
        GainyAnalytics.logEvent("dw_kyc_face_id_use")
        self.makeAccountDataFilled()
        self.coordinator?.kycDataSource.useFaceID = true
        self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
    }
    
    @IBAction func noThanksBtnAction(_ sender: Any) {
        GainyAnalytics.logEvent("dw_kyc_face_id_no")
        self.makeAccountDataFilled()
        self.coordinator?.kycDataSource.useFaceID = false
        self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
    }
    
    private func makeAccountDataFilled() {
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.account_filled = true
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
    }
}
