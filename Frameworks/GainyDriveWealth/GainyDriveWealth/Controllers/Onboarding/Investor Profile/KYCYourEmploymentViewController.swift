//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import GainyAPI

final class KYCYourEmploymentViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEvent("dw_kyc_your_empl_s")
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        
        var placeholder = self.coordinator?.kycDataSource.kycFormConfig?.employmentStatus?.placeholder ?? ""
        if let cache = self.coordinator?.kycDataSource.kycFormCache {
            if let selectedEmployment = cache.employment_status {
                placeholder = selectedEmployment
            }
        }
        let choices: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentStatus.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.employmentStatus?.choices?.compactMap({ item in
            if let item = item, item.name == placeholder || item.value == placeholder {
                self.selectedEmployentState = item
                self.nextButton.isEnabled = true
            }
            return item
        }) ?? []
        self.allEmployentState = choices
        self.collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib.init(nibName: "SingleRowCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "SingleRowCell")

            self.collectionView.allowsSelection = true
            self.collectionView.allowsMultipleSelection = false
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
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let type = self.selectedEmployentState else {return}
        
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.employment_status = type.value
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
        
        if type.value == "EMPLOYED" {
            self.coordinator?.showKYCYourCompanyView()
            GainyAnalytics.logEvent("dw_kyc_your_empl_empl")
        } else {
            self.coordinator?.showKYCSourceOfFoundsView()
            GainyAnalytics.logEvent("dw_kyc_your_empl_non_empl")
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private var selectedEmployentState: KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentStatus.Choice? = nil
    private var allEmployentState: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentStatus.Choice] = []
}


extension KYCYourEmploymentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 44.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let state = self.allEmployentState[indexPath.row]
        self.nextButton.isEnabled = true
        self.selectedEmployentState = state
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        self.nextButton.isEnabled = false
        self.selectedEmployentState = nil
    }
}

extension KYCYourEmploymentViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allEmployentState.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SingleRowCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleRowCell", for: indexPath) as! SingleRowCell
        cell.text = self.allEmployentState[indexPath.row].name
        if self.selectedEmployentState?.value == self.allEmployentState[indexPath.row].value {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
        }
        return cell
    }
}

