//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import GainyAPI

protocol KYCCompanyTypeSearchViewControllerDelegate: AnyObject {
    func companyTypeSearchViewController(sender: KYCCompanyTypeSearchViewController, didPickCompanyType companyType: KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentType.Choice)
}

final class KYCCompanyTypeSearchViewController: DWBaseViewController {
    
    weak var delegate: KYCCompanyTypeSearchViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        
        let placeholder = self.coordinator?.kycDataSource.kycFormConfig?.employmentType?.placeholder ?? ""
        let choices: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentType.Choice] = self.coordinator?.kycDataSource.kycFormConfig?.employmentType?.choices?.compactMap({ item in
            return item
        }) ?? []
        
        self.allCompanyTypes = choices
        self.companyTypes = self.allCompanyTypes
        self.collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib.init(nibName: "CompanyTypeSearchCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "CompanyTypeSearchCell")

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
    
    private var companyTypes: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentType.Choice] = []
    private var allCompanyTypes: [KycGetFormConfigQuery.Data.KycGetFormConfig.EmploymentType.Choice] = []
}

extension KYCCompanyTypeSearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string).lowercased()
        
        if currentText.isEmpty {
            self.companyTypes = self.allCompanyTypes
        } else {
            self.companyTypes = self.allCompanyTypes.filter({ item in
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

extension KYCCompanyTypeSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 56.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let companyType = self.companyTypes[indexPath.row]
        self.delegate?.companyTypeSearchViewController(sender: self, didPickCompanyType: companyType)
        return false
    }
}

extension KYCCompanyTypeSearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.companyTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CompanyTypeSearchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyTypeSearchCell", for: indexPath) as! CompanyTypeSearchCell
        cell.companyTypeText = self.companyTypes[indexPath.row].name
        return cell
    }
}

