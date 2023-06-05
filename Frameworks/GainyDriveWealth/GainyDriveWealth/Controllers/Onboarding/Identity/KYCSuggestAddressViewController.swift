//
//  KYCSuggestAddressViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 29.05.2023.
//

import UIKit
import GainyCommon
import SwiftHEXColors
import GainyAPI

final class KYCSuggestAddressViewController: DWBaseViewController {
    
    private var isNextTapped: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GainyAnalytics.logEventAMP("dw_kyc_sug_addr_s")
        self.gainyNavigationBar.configureWithItems(items: [.mainMenu, .close])
        self.gainyNavigationBar.mainMenuActionHandler = { sender in
            self.coordinator?.popToViewController(vcClass: KYCMainViewController.classForCoder())
        }
        self.gainyNavigationBar.backgroundColor = self.view.backgroundColor
        if self.queryTextControl.text.isEmpty {
            self.queryTextControl.isEditing = true
        }
        self.scrollView.isScrollEnabled = true
        self.updateNextButtonState()
    }
    
    @IBOutlet private weak var queryTextControl: GainyTextFieldControl! {
        didSet {
            var defaultValue = self.coordinator?.kycDataSource.kycFormConfig?.addressStreet1?.placeholder ?? ""
            if let cache = self.coordinator?.kycDataSource.kycFormCache {
                defaultValue = [cache.address_street1, cache.address_street2, cache.address_city, cache.address_province, cache.address_postal_code].compactMap({$0}).filter({!$0.isEmpty}).joined(separator: ", ")
            }
            queryTextControl.delegate = self
            queryTextControl.configureWithText(text: defaultValue, placeholder: "Enter street address", smallPlaceholder: "Enter street address")
        }
    }
    
    private var suggestions: [KycSuggestAddressesQuery.Data.KycSuggestAddress] = []
    @IBOutlet private weak var sugestionsView: UIView!
    @IBOutlet private weak var suggestionsTableView: UITableView! {
        didSet {
            suggestionsTableView.dataSource = self
            suggestionsTableView.delegate = self
        }
    }
    

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
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.coordinator?.showKYCResidentalAddressView()
        isNextTapped = true
        GainyAnalytics.logEventAMP("dw_kyc_sug_addr_e")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.coordinator?.pop()
    }
    
    private var state: KycSuggestAddressesQuery.Data.KycSuggestAddress? = nil
    
    private func updateNextButtonState() {
        self.nextButton.isEnabled = true
    }
    
    private func updateContentOffset(value: CGFloat) {
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentOffset = CGPoint(x: 0.0, y: value)
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Keyboard
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        scrollView.contentInset = .init(top: 0, left: 0, bottom: keyboardSize?.height ?? 0.0, right: 0)
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: - API Calls
    
    //Search
    private var searchBlock: DispatchWorkItem?
    private var apiCallTask: Task<Void, Never>?
    
    private func searchAddress(_ query: String) {
        searchBlock = DispatchWorkItem.init { [weak self] in
            guard let self = self else {return}
            guard !query.isEmpty else {
                return
            }
            
            suggestions.removeAll()
            DispatchQueue.main.async {
                self.suggestionsTableView.reloadData()
                self.sugestionsView.isHidden = true
            }
            apiCallTask?.cancel()
            
            apiCallTask = Task {
                guard Task.isCancelled == false else {
                    await MainActor.run {
                        self.suggestionsTableView.reloadData()
                    }
                    return
                }
                let addresses = try? await self.dwAPI.suggestAddress(query: query)
                self.suggestions = addresses ?? []
                await MainActor.run {
                    self.sugestionsView.isHidden = self.suggestions.isEmpty
                    self.suggestionsTableView.reloadData()
                }
            }
            
        }
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1.0, execute: searchBlock!)
    }
}

extension KYCSuggestAddressViewController: GainyTextFieldControlDelegate {
    
    func gainyTextFieldDidStartEditing(sender: GainyTextFieldControl) {
        self.updateContentOffset(value: 150.0)
    }
    
    func gainyTextFieldDidEndEditing(sender: GainyTextFieldControl) {
        self.updateContentOffset(value: 0.0)
    }
    
    func gainyTextFieldDidUpdateText(sender: GainyTextFieldControl, text: String) {        
        self.updateNextButtonState()
        
        guard text.count > 3 else {
            suggestions.removeAll()
            suggestionsTableView.reloadData()
            sugestionsView.isHidden = true
            return
        }
        searchAddress(text)
    }
}


extension KYCSuggestAddressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "SuggestionsTableViewCell")
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = suggestions[indexPath.row].addressLine
            content.textProperties.font = .proDisplayMedium(16)
            content.textProperties.numberOfLines = 0
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.font = .proDisplayMedium(16)
            cell.textLabel!.text = suggestions[indexPath.row].addressLine
            cell.textLabel!.numberOfLines = 0
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension KYCSuggestAddressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let suggestion = suggestions[indexPath.row]
        state = suggestion
        queryTextControl.isEditing = false
        queryTextControl.setText(suggestions[indexPath.row].addressLine)
        updateContentOffset(value: 0.0)
        updateNextButtonState()
        
        suggestions.removeAll()
        suggestionsTableView.reloadData()
        sugestionsView.isHidden = true
        
        //Set actual data
        if var cache = self.coordinator?.kycDataSource.kycFormCache {
            cache.address_street1 = suggestion.street1
            cache.address_city = suggestion.city
            cache.address_province = suggestion.province
            cache.country = suggestion.country
            cache.address_postal_code = suggestion.postalCode
            self.coordinator?.kycDataSource.kycFormCache = cache
        }
    }
}

extension KycSuggestAddressesQuery.Data.KycSuggestAddress {
    var addressLine: String {
        return String([street1, city, province, postalCode].compactMap({$0}).filter({!$0.isEmpty}).joined(separator: ", "))
    }
}
