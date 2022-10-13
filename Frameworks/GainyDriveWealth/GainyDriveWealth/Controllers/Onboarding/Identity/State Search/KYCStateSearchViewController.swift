//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon

protocol KYCStateSearchViewControllerDelegate: AnyObject {
    func stateSearchViewController(sender: KYCStateSearchViewController, didPickState state: String)
}

final class KYCStateSearchViewController: DWBaseViewController {
    
    weak var delegate: KYCStateSearchViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        
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
    
    private var states: [String] = []
    private let allStates = [ "AK - Alaska",
                    "AL - Alabama",
                    "AR - Arkansas",
                    "AS - American Samoa",
                    "AZ - Arizona",
                    "CA - California",
                    "CO - Colorado",
                    "CT - Connecticut",
                    "DC - District of Columbia",
                    "DE - Delaware",
                    "FL - Florida",
                    "GA - Georgia",
                    "GU - Guam",
                    "HI - Hawaii",
                    "IA - Iowa",
                    "ID - Idaho",
                    "IL - Illinois",
                    "IN - Indiana",
                    "KS - Kansas",
                    "KY - Kentucky",
                    "LA - Louisiana",
                    "MA - Massachusetts",
                    "MD - Maryland",
                    "ME - Maine",
                    "MI - Michigan",
                    "MN - Minnesota",
                    "MO - Missouri",
                    "MS - Mississippi",
                    "MT - Montana",
                    "NC - North Carolina",
                    "ND - North Dakota",
                    "NE - Nebraska",
                    "NH - New Hampshire",
                    "NJ - New Jersey",
                    "NM - New Mexico",
                    "NV - Nevada",
                    "NY - New York",
                    "OH - Ohio",
                    "OK - Oklahoma",
                    "OR - Oregon",
                    "PA - Pennsylvania",
                    "PR - Puerto Rico",
                    "RI - Rhode Island",
                    "SC - South Carolina",
                    "SD - South Dakota",
                    "TN - Tennessee",
                    "TX - Texas",
                    "UT - Utah",
                    "VA - Virginia",
                    "VI - Virgin Islands",
                    "VT - Vermont",
                    "WA - Washington",
                    "WI - Wisconsin",
                    "WV - West Virginia",
                    "WY - Wyoming"]
}

extension KYCStateSearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("1 \(String(describing: textField.text))")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string).lowercased()
        
        if currentText.isEmpty {
            self.states = self.allStates
        } else {
            self.states = self.allStates.filter({ item in
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
        cell.state = self.states[indexPath.row]
        return cell
    }
}

