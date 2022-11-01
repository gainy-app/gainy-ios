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
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        
        let placeholder = self.coordinator?.kycDataSource.kycFormConfig?.employmentStatus?.placeholder ?? ""
        let choices: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentStatus.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.employmentStatus?.choices?.compactMap({ item in
            if let item = item, item.name == placeholder {
                self.selectedEmployentState = item
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
        
        self.coordinator?.kycDataSource.upsertKycForm(employment_status: type.value, { success in
            if success {
                print("Success mutate employment_status: \(success)")
            } else {
                print("Failed to mutate employment_status: \(success)")
            }
        })
        
        if type.value == "EMPLOYED" {
            self.coordinator?.showKYCYourCompanyView()
        } else {
            self.coordinator?.showKYCSourceOfFoundsView()
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
        return cell
    }
}

