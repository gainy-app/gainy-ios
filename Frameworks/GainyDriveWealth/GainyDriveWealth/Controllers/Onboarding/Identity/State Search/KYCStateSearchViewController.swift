//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import GainyAPI

protocol KYCStateSearchViewControllerDelegate: AnyObject {
    func stateSearchViewController(sender: KYCStateSearchViewController, didPickState state: KycGetFormConfigQuery.Data.KycGetFormConfig.AddressProvince.Choice)
}
typealias StateChoice = KycGetFormConfigQuery.Data.KycGetFormConfig.AddressProvince.Choice

final class KYCStateSearchViewController: DWBaseViewController {
    
    weak var delegate: KYCStateSearchViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        self.allStates = self.coordinator?.kycDataSource.kycFormConfig?.addressProvince?.choices?.compactMap({$0}) ?? []
        self.states = self.allStates
        self.collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib.init(nibName: "StateCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "StateCell")

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
    
    private var states: [StateChoice] = []
    private var allStates: [StateChoice] = []
}

extension KYCStateSearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string).lowercased()
        
        if currentText.isEmpty {
            self.states = self.allStates
        } else {
            self.states = self.allStates.filter({ item in
                return item.name.lowercased().contains(updatedText) || item.value.lowercased().contains(updatedText)
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

extension KYCStateSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 56.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let state = self.states[indexPath.row]
        self.delegate?.stateSearchViewController(sender: self, didPickState: state)
        return false
    }
}

extension KYCStateSearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.states.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: StateCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StateCell", for: indexPath) as! StateCell
        cell.state = self.states[indexPath.row].name
        return cell
    }
}

