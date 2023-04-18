//
//  KYCCountrySelectorViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 09.09.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import GainyAPI

typealias CountryChoice = KycGetFormConfigQuery.Data.KycGetFormConfig.AddressCountry.Choice
typealias CitizenshipChoice = KycGetFormConfigQuery.Data.KycGetFormConfig.Citizenship.Choice

protocol CountryChoicable {
    var value: String {get set}
    var name: String {get set}
}

extension CountryChoice: CountryChoicable {
    
}
extension CitizenshipChoice: CountryChoicable {
    
}

struct Country {
    
    let name: String
    let iso: String
    
    internal init(name: String, iso: String) {
        self.name = name
        self.iso = iso
    }
    
    /// Default country
    /// - Returns: US country class
    static func us() -> Self {
        Country(name: "United States",
                iso: "USA")
    }
    
    static let usISO = "USA"
    
    var isUSA: Bool {
        iso == Country.usISO
    }
    
    /// Constuctor to fill from Choice
    /// - Parameter choice: KycGetFormConfigQuery.Data.KycGetFormConfig.AddressCountry.Choice
    init(choice: CountryChoicable) {
        self.name = choice.name
        self.iso = choice.value
    }
}

extension Array where Element == CountryChoicable {
    func searchByIsoCode(_ iso: String) -> Country {
        if let found = first(where: {
            $0.value == iso
        }) {
            return Country(choice: found)
        } else {
            return Country.us()
        }
    }
}

final class KYCCountrySelectorViewController: DWBaseViewController {
    
    private var allCountries = [CountryChoicable]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEventAMP("dw_kyc_ios_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        self.allCountries = self.coordinator?.kycDataSource.kycFormConfig?.addressCountry?.choices?.compactMap({$0}) ?? []
        if let cache = self.coordinator?.kycDataSource.kycFormCache {
            if var countryISO = cache.country {
                let country = allCountries.searchByIsoCode(countryISO)
                self.country = country
            }
        }
        if self.country == nil {
            let country = allCountries.searchByIsoCode(Country.usISO)
            self.country = country
        }
        
        self.updateUI()
        
        if let attributedString: NSAttributedString = termsTextView.attributedText {
            
            if var mutableAttributedString = attributedString.mutableCopy() as? NSMutableAttributedString {
                mutableAttributedString.setAsLink(textToFind: "Terms & Conditions", linkURL: "https://www.gainy.app/legal-hub/terms-of-service")
                mutableAttributedString.setAsLink(textToFind: "Privacy Policy", linkURL: "https://www.gainy.app/legal-hub/privacy-policy")
                
                termsTextView.attributedText = mutableAttributedString.copy() as? NSAttributedString
            }
        }
    }
    
    @IBOutlet private weak var termsTextView: UITextView! {
        didSet {
            self.termsTextView.isEditable = false
            self.termsTextView.isScrollEnabled = false
        }
    }
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
        if country.isUSA {
            GainyAnalytics.logEventAMP("dw_kyc_ios_usa")
            if var cache = self.coordinator?.kycDataSource.kycFormCache {
                cache.country = Country.usISO
                self.coordinator?.kycDataSource.kycFormCache = cache
            }
            self.coordinator?.showKYCGainyPolicyView()
        } else {
            GainyAnalytics.logEventAMP("dw_kyc_ios_none_usa", params: ["code" : country.iso])
            let alertController = UIAlertController(title: nil, message: NSLocalizedString("You will be notified when the feature will be available in \(country.name)", comment: ""), preferredStyle: .alert)
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
        if country.isUSA {
            nextButton.configureWithTitle(title: "Continue", color: UIColor.white, state: .normal)
            self.termsTextView.isHidden = false
            self.notifyMeLabel.isHidden = true
        } else {
            // TODO: KYC Question - how to notify me for another country? Analitics?
            nextButton.configureWithTitle(title: "Notify Me", color: UIColor.white, state: .normal)
            self.termsTextView.isHidden = true
            self.notifyMeLabel.isHidden = false
            self.notifyMeLabel.text = "Unfortunately, we don't work in \(country.name) yet. But we are actively working on it! "
        }
        
        self.countryFlagEmojy.text = country.name
    }
}

extension KYCCountrySelectorViewController: KYCCountrySearchViewControllerDelegate {
    func countrySearchViewController(sender: KYCCountrySearchViewController, didPickCountry country: Country) {
        sender.dismiss(animated: true)
        self.country = country
        self.updateUI()
    }
}
