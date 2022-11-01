//
//  KYCPhoneViewController.swift
//  GainyDriveWealth
//
//  Created by Serhii Borysov on 15.09.2022.
//

import UIKit
import GainyCommon
import CountryKit
import PhoneNumberKit

final class KYCPhoneViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.pageControl, .close])
        let countryKit = CountryKit()
        let country = countryKit.searchByIsoCode("US")
        self.country = country
        self.updateUI()
    }
    
    @IBOutlet private weak var flagLabel: UILabel!
    @IBOutlet private weak var codeLabel: UILabel!
    
    @IBOutlet private weak var placegolderLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    
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
    
    @IBOutlet private weak var searchCountriesButton: GainyButton! {
        didSet {
            searchCountriesButton.configureWithTitle(title: "", color: UIColor.clear, state: .normal)
            searchCountriesButton.configureWithTitle(title: "", color: UIColor.clear, state: .disabled)
            searchCountriesButton.configureWithCornerRadius(radius: 16.0)
            searchCountriesButton.configureWithBackgroundColor(color: UIColor.white)
            searchCountriesButton.configureWithHighligtedBackgroundColor(color: UIColor.white)
        }
    }
    
    @IBOutlet private weak var padView: GainyPadView! {
        didSet {
            padView.delegate = self
            padView.hideDot = true
        }
    }
    
    @IBAction func searchCountriesButtonAction(_ sender: Any) {
        
        self.coordinator?.showKYCCountrySearch(delegate: self)
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        self.coordinator?.kycDataSource.upsertKycForm(phone_number: self.phoneString, { success in
            if success {
                print("Success mutate phone_number: \(success)")
            } else {
                print("Failed to mutate phone_number: \(success)")
            }
        })
        let last4Digits = String(self.phoneString.suffix(4))
        self.coordinator?.showKYCVerifyPhoneView(last4Digits: last4Digits)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private var country: Country?
    private var phoneString: String = ""
    
    private func updateUI() {
        
        guard let country = self.country else {return}
        self.flagLabel.text = country.emoji
        self.codeLabel.text = (country.phoneCode != nil) ? "+\(country.phoneCode!)" : "+"
        self.validateAmount()
    }
}

extension KYCPhoneViewController: KYCCountrySearchViewControllerDelegate {
    
    func countrySearchViewController(sender: KYCCountrySearchViewController, didPickCountry country: Country) {
        sender.dismiss(animated: true)
        self.country = country
        self.updateUI()
    }
}

extension KYCPhoneViewController: GainyPadViewDelegate {
    
    func deleteDigit(view: GainyPadView) {
        phoneString = String(phoneString.dropLast(1))
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        phoneString.append(digit)
        validateAmount()
    }
    
    func validateAmount() {
        
        var valid = false
        do {
            let phoneNumberKit = PhoneNumberKit()
            let code = self.codeLabel.text ?? "+"
            let fullNumber = "\(code)\(self.phoneString)"
            let phoneNumber = try phoneNumberKit.parse(fullNumber)
            var formattedString = phoneNumberKit.format(phoneNumber, toType: .international)
            if formattedString.count > 0 {
                for _ in 0..<code.count {
                    formattedString = String(formattedString.dropFirst())
                }
                self.numberLabel.text = formattedString
                valid = true
            } else {
                self.numberLabel.text = self.phoneString
            }
        }
        catch {
            self.numberLabel.text = self.phoneString
        }
        
        self.placegolderLabel.isHidden = !self.phoneString.isEmpty
        self.numberLabel.isHidden = self.phoneString.isEmpty
        nextButton.isEnabled = valid
    }
}
