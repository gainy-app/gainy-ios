//
//  KYCYourCompanyViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import GainyAPI

final class KYCYourCompanyViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        self.gainyNavigationBar.backgroundColor = self.view.backgroundColor
        self.companyNameTextControl.isEditing = true
        self.scrollView.isScrollEnabled = true
        self.updateNextButtonState(companyName: self.companyNameTextControl.text)
    }
    
    @IBOutlet private weak var companyNameTextControl: GainyTextFieldControl! {
        didSet {
            var placeholder = ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let name = cache.employment_company_name {
                    placeholder = name
                }
            }
            companyNameTextControl.delegate = self
            companyNameTextControl.configureWithText(text: placeholder, placeholder: "Company name", smallPlaceholder: "Company name")
        }
    }
    
    @IBOutlet private weak var companyTypeTextControl: GainyTextFieldControl! {
        didSet {
            
            var placeholder = self.coordinator?.kycDataSource.kycFormConfig?.employmentType?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let type = cache.employment_type {
                    placeholder = type
                }
            }
            let _: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentType.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.employmentType?.choices?.compactMap({ item in
                if let item = item, item.name == placeholder || item.value == placeholder {
                    self.employmentType = item
                }
                return item
            }) ?? []
            companyTypeTextControl.delegate = self
            companyTypeTextControl.configureWithText(text: self.employmentType?.name ?? "", placeholder: "Company type", smallPlaceholder: "Company type")
            companyTypeTextControl.textFieldEnabled = false
        }
    }
    
    @IBOutlet private weak var yourJobTitleTextControl: GainyTextFieldControl! {
        didSet {
            
            var placeholder = self.coordinator?.kycDataSource.kycFormConfig?.employmentPosition?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                if let position = cache.employment_position {
                    placeholder = position
                }
            }
            let _: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentPosition.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.employmentPosition?.choices?.compactMap({ item in
                if let item = item, item.name == placeholder || item.value == placeholder {
                    self.employmentPosition = item
                }
                return item
            }) ?? []
            yourJobTitleTextControl.delegate = self
            yourJobTitleTextControl.configureWithText(text: self.employmentPosition?.name ?? "", placeholder: "Your job title", smallPlaceholder: "Your job title")
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
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.employment_company_name = self.companyNameTextControl.text
            cache.employment_position = self.employmentPosition?.value ?? self.yourJobTitleTextControl.text
            cache.employment_type = self.employmentType?.value ?? self.companyTypeTextControl.text
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        self.coordinator?.showKYCSourceOfFoundsView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private func updateNextButtonState(companyName: String) {
        
        guard companyName.isEmpty == false, self.employmentType != nil, self.employmentPosition != nil else {
            self.nextButton.isEnabled = false
            return
        }
        
        self.nextButton.isEnabled = true
    }
    
    private var employmentType: KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentType.Choice? = nil
    private var employmentPosition: KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentPosition.Choice? = nil
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
    
    func companyPositionSearchViewController(sender: KYCCompanyPositionSearchViewController, didPickJobTitle jobTitle: KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentPosition.Choice) {
        
        sender.dismiss(animated: true)
        self.employmentPosition = jobTitle
        self.yourJobTitleTextControl.configureWithText(text: jobTitle.name)
        self.updateNextButtonState(companyName: self.companyNameTextControl.text)
    }
}

extension KYCYourCompanyViewController : KYCCompanyTypeSearchViewControllerDelegate {
    
    func companyTypeSearchViewController(sender: KYCCompanyTypeSearchViewController, didPickCompanyType companyType: KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentType.Choice) {
        
        sender.dismiss(animated: true)
        self.employmentType = companyType
        self.companyTypeTextControl.configureWithText(text: companyType.name)
        self.updateNextButtonState(companyName: self.companyNameTextControl.text)
    }
}

