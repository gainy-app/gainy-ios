//
//  HoldingsSettingsTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.07.2022.
//

import UIKit

protocol HoldingsSettingsTableViewCellDelegate: AnyObject {
    func onSortButtonTapped()
    func onSettingsButtonTapped()
}

final class HoldingsSettingsTableViewCell: HoldingRangeableCell {
    
    static let cellHeight: CGFloat = 24.0 + 24.0 + 24.0
    
    weak var delegate: HoldingsSettingsTableViewCellDelegate?
    
    @IBOutlet private weak var sortButton: ResponsiveButton! {
        didSet {
            sortButton.layer.cornerRadius = 8.0
            sortButton.clipsToBounds = true
            sortButton.fillRemoteButtonBack()
        }
    }
    @IBOutlet private weak var settingsButton: ResponsiveButton! {
        didSet {
            settingsButton.layer.cornerRadius = 8.0
            settingsButton.clipsToBounds = true
            settingsButton.fillRemoteButtonBack()
        }
    }
    
    @IBOutlet private weak var settingsLabel: UILabel!
    @IBOutlet private weak var sortLabel: UILabel!
    
    var isDemoProfile: Bool = false
    
    var profileToUse: Int? {
        if isDemoProfile {
            return Constants.Plaid.demoProfileID
        } else {
            return UserProfileManager.shared.profileID
        }
    }
    
    func updateButtons() {
        updateSortButton()
        updateFilterButtonTitle()
    }
    
    private func updateSortButton() {
        
        guard let userID = profileToUse else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        let title = settings.sorting.title
        sortLabel.text = title
    }
    
    private func updateFilterButtonTitle() {
        
        guard let userID = profileToUse else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        
        let selectedInterests = settings.interests.filter { item in
            item.selected
        }
        let selectedCategories = settings.categories.filter { item in
            item.selected
        }
        let selectedSecurityTypes = settings.securityTypes.filter { item in
            item.selected
        }
        
        if settings.interests.count == selectedInterests.count && selectedCategories.count == settings.categories.count && settings.disabledAccounts.count == 0 {
            self.settingsLabel.text = "All platforms"
            return
        }
        
        let selectedSum = (selectedInterests.count) + (selectedCategories.count) + (selectedSecurityTypes.count) + settings.disabledAccounts.count
        self.settingsLabel.text = selectedSum > 0 ? "Filter applied" : "All platforms"
    }
    
    //MARK: - Actions
    
    @IBAction func sortAction() {
        delegate?.onSortButtonTapped()
    }
    
    @IBAction func settingsButtonAction() {
        delegate?.onSettingsButtonTapped()
    }
    
}
