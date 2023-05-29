//
//  KYCSuggestAddressViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 29.05.2023.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import GainyAPI

final class KYCSuggestAddressViewController: DWBaseViewController {
    
    private var isNextTapped: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEventAMP("dw_kyc_sug_addr_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        self.gainyNavigationBar.backgroundColor = self.view.backgroundColor
        if self.queryTextControl.text.isEmpty {
            self.queryTextControl.isEditing = true
        }
        self.scrollView.isScrollEnabled = true
        self.updateNextButtonState()
    }
    
    @IBOutlet private weak var queryTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressStreet1?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let address = cache.address_street1 {
                    defaultValue = address
                }
            }
            queryTextControl.delegate = self
            queryTextControl.configureWithText(text: defaultValue, placeholder: "Address line 1", smallPlaceholder: "Address line 1")
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
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.coordinator?.showKYCSocialSecurityNumberView()
        isNextTapped = true
        GainyAnalytics.logEventAMP("dw_kyc_sug_addr_e")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }

    
    private var state: KycSuggestAddressesQuery.Data.KycSuggestAddress? = nil
    
    private func updateNextButtonState() {
        
        guard state != nil else {
            self.nextButton.isEnabled = false
            return
        }
        
        self.nextButton.isEnabled = true
    }
    
    private func updateContentOffset(value: CGFloat) {
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentOffset = CGPoint(x: 0.0, y: value)
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Keyboard
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        scrollView.contentInset = .init(top: 0, left: 0, bottom: keyboardSize?.height ?? 0.0, right: 0)
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension KYCSuggestAddressViewController: GainyTextFieldControlDelegate {
    
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        self.updateContentOffset(value: 150.0)
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        self.updateContentOffset(value: 0.0)
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {        
        self.updateNextButtonState()
    }
}
