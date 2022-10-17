//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon

protocol KYCCompanyPositionSearchViewControllerDelegate: AnyObject {
    func companyPositionSearchViewController(sender: KYCCompanyPositionSearchViewController, didPickJobTitle jobTitle: String)
}

final class KYCCompanyPositionSearchViewController: DWBaseViewController {
    
    weak var delegate: KYCCompanyPositionSearchViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        
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
    
    private var jobTitles: [String] = []
    private let allJobTitles = [
        "Job title TBD",
        "Job title example 1",
        "Job title example 2",
        "Job title example 3",
        "Job title example 4",
        "Job title example 5",
        "Job title example 6",
        "Job title example 7",
        "Job title example 8",
        "Job title example 9",
        "Job title example 10",
        "Job title example 11",
        "Job title example 12",
        "Job title example 13",
        "Job title example 14",
    ]
}

extension KYCCompanyPositionSearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("1 \(String(describing: textField.text))")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string).lowercased()
        
        if currentText.isEmpty {
            self.jobTitles = self.allJobTitles
        } else {
            self.jobTitles = self.allJobTitles.filter({ item in
                return item.lowercased().contains(updatedText)
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
        cell.jobTitleText = self.jobTitles[indexPath.row]
        return cell
    }
}

