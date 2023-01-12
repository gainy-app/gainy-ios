//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import GainyAPI

protocol KYCCompanyPositionSearchViewControllerDelegate: AnyObject {
    func companyPositionSearchViewController(sender: KYCCompanyPositionSearchViewController, didPickJobTitle jobTitle: KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentPosition.Choice)
}

final class KYCCompanyPositionSearchViewController: DWBaseViewController {
    
    weak var delegate: KYCCompanyPositionSearchViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        self.gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        
        let placeholder = self.coordinator?.kycDataSource.kycFormConfig?.employmentPosition?.placeholder ?? ""
        let choices: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentPosition.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.employmentPosition?.choices?.compactMap({ item in
            return item
        }) ?? []
        
        self.allJobTitles = choices
        self.jobTitles = self.allJobTitles
        self.collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib.init(nibName: "CompanyPositionSearchCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "CompanyPositionSearchCell")

            self.collectionView.allowsSelection = true
            self.collectionView.allowsMultipleSelection = false
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    {
        didSet {
            searchTextField.delegate = self
        }
    }
    
    private var jobTitles: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentPosition.Choice] = []
    private var allJobTitles: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentPosition.Choice] = []
}

extension KYCCompanyPositionSearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("1 \(String(describing: textField.text))")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string).lowercased()
        
        if updatedText.isEmpty {
            self.jobTitles = self.allJobTitles
        } else {
            self.jobTitles = self.allJobTitles.filter({ item in
                return item.value.lowercased().contains(updatedText) || item.name.lowercased().contains(updatedText)
            })
        }
        self.collectionView.reloadData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

extension KYCCompanyPositionSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 56.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let jobTitle = self.jobTitles[indexPath.row]
        self.delegate?.companyPositionSearchViewController(sender: self, didPickJobTitle: jobTitle)
        return false
    }
}

extension KYCCompanyPositionSearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.jobTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CompanyPositionSearchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyPositionSearchCell", for: indexPath) as! CompanyPositionSearchCell
        cell.jobTitleText = self.jobTitles[indexPath.row].name
        return cell
    }
}

