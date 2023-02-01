//
//  KYCKeyValueSearchViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon

protocol KYCKeyValueSearchViewControllerDelegate: AnyObject {
    func keyValueSearchViewController(sender: KYCKeyValueSearchViewController, didPickKey key: String, value: String)
}

final class KYCKeyValueSearchViewController: DWBaseViewController {
    
    weak var delegate: KYCKeyValueSearchViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        
        self.keyValues = self.allKeyValues
        self.collectionView.reloadData()
    }
    
    public func configureWithOrderedKeyValues(keyValues: [ [String : String] ]) {
        
        self.allKeyValues = keyValues
        self.keyValues = keyValues
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib.init(nibName: "KeyValueCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "KeyValueCell")
            self.collectionView.allowsSelection = true
            self.collectionView.allowsMultipleSelection = false
        }
    }

    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }

    private var allKeyValues: [ [String : String] ] = []
    private var keyValues: [ [String : String] ] = []
}

extension KYCKeyValueSearchViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string).lowercased()

        if currentText.isEmpty {
            self.keyValues = self.allKeyValues
        } else {
            self.keyValues = self.allKeyValues.filter({ item in
                if let key = item.keys.first, let value = item.values.first {
                    return key.lowercased().contains(updatedText) || value.lowercased().contains(updatedText)
                }
                return false
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

extension KYCKeyValueSearchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {

        let result = self.keyValues[indexPath.row]
        if let key = result.keys.first, let value = result.values.first {
            self.delegate?.keyValueSearchViewController(sender: self, didPickKey: key, value: value)
        }
        return false
    }
}

extension KYCKeyValueSearchViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.keyValues.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: KeyValueCell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyValueCell", for: indexPath) as! KeyValueCell
        if let value = self.keyValues[indexPath.row].values.first {
            cell.value = value
        }
        return cell
    }
}
