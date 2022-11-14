//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import CountryKit

final class KYCCountrySelectorViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        let countryKit = CountryKit()
        if let cache = self.coordinator?.kycDataSource.kycFormCache {
            if var countryISO = cache.country {
                if countryISO == "USA" {
                    countryISO = "US"
                }
                let country = countryKit.searchByIsoCode(countryISO)
                self.country = country
            }
        } else if self.country == nil {
            let country = countryKit.searchByIsoCode("US")
            self.country = country
        }
        self.updateUI()
    }
    
    @IBOutlet private weak var termsLabel: UILabel!
    @IBOutlet private weak var notifyMeLabel: UILabel!
    
    @IBOutlet weak var countryFlagEmojy: UILabel!
    
    @IBOutlet private weak var searchCountriesButton: GainyButton! {
        didSet {
            searchCountriesButton.configureWithTitle(title: "", color: UIColor.clear, state: .normal)
            searchCountriesButton.configureWithTitle(title: "", color: UIColor.clear, state: .disabled)
            searchCountriesButton.configureWithCornerRadius(radius: 16.0)
            searchCountriesButton.configureWithBackgroundColor(color: UIColor.white)
            searchCountriesButton.configureWithHighligtedBackgroundColor(color: UIColor.white)
        }
    }
    
    @IBOutlet private weak var nextButton: GainyButton! {
        didSet {

            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .normal)
            nextButton.configureWithCornerRadius(radius: 16.0)
            nextButton.configureWithBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
            nextButton.configureWithHighligtedBackgroundColor(color: UIColor(hexString: "#0062FF") ?? UIColor.blue)
        }
    }
    
    @IBAction func searchCountriesButtonAction(_ sender: Any) {
        
        self.coordinator?.showKYCCountrySearch(delegate: self)
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        guard let country = self.country else {return}
        if country.iso.contains("US") {
            if var cache = self.coordinator?.kycDataSource.kycFormCache {
                cache.country = "USA"
                self.coordinator?.kycDataSource.kycFormCache = cache
            }
            self.coordinator?.showCitizenshipSelector()
        } else {
            let alertController = UIAlertController(title: nil, message: NSLocalizedString("You will be notified when the feature will be available in \(country.localizedName)", comment: ""), preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { (action) in
                if var cache = self.coordinator?.kycDataSource.kycFormCache {
                    cache.country = country.iso
                    self.coordinator?.kycDataSource.kycFormCache = cache
                }
                self.dismiss(animated: true)
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private var country: Country?
    
    private func updateUI() {
        
        guard let country = self.country else {return}
        if country.iso.contains("US") {
            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .normal)
            self.termsLabel.isHidden = false
            self.notifyMeLabel.isHidden = true
        } else {
            // TODO: KYC Question - how to notify me for another country? Analitics?
            nextButton.configureWithTitle(title: "Notify Me", color: UIColor.white, state: .normal)
            self.termsLabel.isHidden = true
            self.notifyMeLabel.isHidden = false
            self.notifyMeLabel.text = "Unfortunately, we don't work in \(country.localizedName) yet. But we are actively working on it! "
        }
        
        self.countryFlagEmojy.text = country.emoji + " " + country.localizedName
    }
}

extension KYCCountrySelectorViewController: KYCCountrySearchViewControllerDelegate {
    func countrySearchViewController(sender: KYCCountrySearchViewController, didPickCountry country: Country) {
        sender.dismiss(animated: true)
        self.country = country
        self.updateUI()
    }
}
