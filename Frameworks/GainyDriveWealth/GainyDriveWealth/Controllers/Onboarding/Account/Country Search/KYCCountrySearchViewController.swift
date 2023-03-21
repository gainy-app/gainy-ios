//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon

protocol KYCCountrySearchViewControllerDelegate: AnyObject {
    func countrySearchViewController(sender: KYCCountrySearchViewController, didPickCountry country: Country)
}


final class KYCCountrySearchViewController: DWBaseViewController {
    
    weak var delegate: KYCCountrySearchViewControllerDelegate?
    
    var exceptUSA: Bool = false
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.gainyNavigationBar.closeActionHandler = { sender in
            self.dismiss(animated: true)
        }
        
        let configCountries = self.coordinator?.kycDataSource.kycFormConfig?.addressCountry?.choices?.compactMap({$0}) ?? []
        if self.exceptUSA {
            self.countries = configCountries.filter({ country in
                country.value.uppercased() != Country.usISO
            }).compactMap({Country.init(choice: $0)})
        }
        else {
            self.countries = configCountries.compactMap({Country.init(choice: $0)})
        }
        self.allCountries = self.countries
        self.collectionView.reloadData()
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(UINib.init(nibName: "CountryCell", bundle: Bundle(identifier: "app.gainy.framework.GainyDriveWealth")), forCellWithReuseIdentifier: "CountryCell")

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
    
    private var countries: [Country] = []
    private var allCountries: [Country] = []
}

extension KYCCountrySearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string).lowercased()
        
        if currentText.isEmpty {
            self.countries = self.allCountries
        } else {
            self.countries = self.allCountries.filter({ item in
                return item.name.lowercased().contains(updatedText) || item.iso.lowercased().contains(updatedText)
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

extension KYCCountrySearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width, height: 56.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        let country = self.countries[indexPath.row]
        self.delegate?.countrySearchViewController(sender: self, didPickCountry: country)
        return false
    }
}

extension KYCCountrySearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CountryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCell", for: indexPath) as! CountryCell
        cell.country = self.countries[indexPath.row]
        return cell
    }
}

