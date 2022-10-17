//
//  KYCYourCompanyViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors

final class KYCYourCompanyViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        self.gainyNavigationBar.backgroundColor = self.view.backgroundColor
        self.companyNameTextControl.isEditing = true
        self.scrollView.isScrollEnabled = true
    }
    
    @IBOutlet private weak var companyNameTextControl: GainyTextFieldControl! {
        didSet {
            companyNameTextControl.delegate = self
            companyNameTextControl.configureWithText(text: "", placeholder: "Company name", smallPlaceholder: "Company name")
        }
    }
    
    @IBOutlet private weak var companyTypeTextControl: GainyTextFieldControl! {
        didSet {
            companyTypeTextControl.delegate = self
            companyTypeTextControl.configureWithText(text: "", placeholder: "Company type", smallPlaceholder: "Company type")
            companyTypeTextControl.textFieldEnabled = false
        }
    }
    
    @IBOutlet private weak var yourJobTitleTextControl: GainyTextFieldControl! {
        didSet {
            yourJobTitleTextControl.delegate = self
            yourJobTitleTextControl.configureWithText(text: "", placeholder: "Your job title", smallPlaceholder: "Your job title")
            yourJobTitleTextControl.textFieldEnabled = false
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
        
        self.coordinator?.showKYCSourceOfFoundsView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private func updateNextButtonState(companyName: String) {
        
        guard companyName.isEmpty == false, self.companyType != nil, self.jobTitle != nil else {
            self.nextButton.isEnabled = false
            return
        }
        
        self.nextButton.isEnabled = true
    }
    
    private var companyType: String? = nil
    private var jobTitle: String? = nil
}

extension KYCYourCompanyViewController: GainyTextFieldControlDelegate {
    
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        if sender == self.companyTypeTextControl {
            self.companyTypeTextControl.isEditing = false
            self.coordinator?.showKYCCompanyTypeSearchView(delegate: self)
        } else if sender == self.yourJobTitleTextControl {
            self.yourJobTitleTextControl.isEditing = false
            self.coordinator?.showKYCCompanyPositionSearchView(delegate: self)
        }
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        
        self.updateNextButtonState(companyName: self.companyNameTextControl.text)
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {
        
        let companyName = (sender == self.companyNameTextControl ? text : self.companyNameTextControl.text)
        self.updateNextButtonState(companyName: companyName)
    }
}

extension KYCYourCompanyViewController : KYCCompanyPositionSearchViewControllerDelegate {
    
    func companyPositionSearchViewController(sender: KYCCompanyPositionSearchViewController, didPickJobTitle jobTitle: String) {
        
        sender.dismiss(animated: true)
        self.jobTitle = jobTitle
        self.yourJobTitleTextControl.configureWithText(text: jobTitle)
        self.updateNextButtonState(companyName: self.companyNameTextControl.text)
    }
}

extension KYCYourCompanyViewController : KYCCompanyTypeSearchViewControllerDelegate {
    
    func companyTypeSearchViewController(sender: KYCCompanyTypeSearchViewController, didPickCompanyType companyType: String) {
        
        sender.dismiss(animated: true)
        self.companyType = companyType
        self.companyTypeTextControl.configureWithText(text: companyType)
        self.updateNextButtonState(companyName: self.companyNameTextControl.text)
    }
}

