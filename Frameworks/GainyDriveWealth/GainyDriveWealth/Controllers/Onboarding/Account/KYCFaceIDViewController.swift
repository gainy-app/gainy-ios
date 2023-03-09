//
//  KYCFaceIDViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import LocalAuthentication

final class KYCFaceIDViewController: DWBaseViewController {
    
    private var context = LAContext()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        GainyAnalytics.logEventAMP("dw_kyc_face_id_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
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
        GainyAnalytics.logEvent("dw_kyc_face_id_e", params: ["permission" : "granted"])
        let reason = "Log in with Face ID"
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, error in
            guard let self else { return }
            if success {
                self.makeAccountDataFilled()
                self.coordinator?.kycDataSource.useFaceID = true
                DispatchQueue.main.async {
                    self.dismissHandler?()
                    self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
                }
            }
        }
    }
    
    @IBAction func noThanksBtnAction(_ sender: Any) {
        GainyAnalytics.logEvent("dw_kyc_face_id_e", params: ["permission" : "not_granted"])
        self.makeAccountDataFilled()
        self.coordinator?.kycDataSource.useFaceID = false
        self.dismissHandler?()
        self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
    }
    
    private func makeAccountDataFilled() {
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.account_filled = true
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
    }
}
