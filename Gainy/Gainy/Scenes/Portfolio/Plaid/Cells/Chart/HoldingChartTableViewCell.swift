//
//  HoldingChartTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import Foundation
import UIKit

protocol HoldingChartTableViewCellDelegate: AnyObject {
    func onSortButtonTapped()
    func onSettingsButtonTapped()
}

final class HoldingChartTableViewCell: HoldingRangeableCell {
    
    weak var delegate: HoldingChartTableViewCellDelegate?
    
    @IBOutlet private weak var sortButton: ResponsiveButton! {
        didSet {
            sortButton.layer.cornerRadius = 12.0
            sortButton.clipsToBounds = true
        }
    }
    @IBOutlet private weak var settingsButton: ResponsiveButton! {
        didSet {
            settingsButton.layer.cornerRadius = 12.0
            settingsButton.clipsToBounds = true
        }
    }
    
    @IBOutlet private weak var settingsLabel: UILabel!
    @IBOutlet private weak var sortLabel: UILabel!
    
    
    func updateButtons() {
        updateSortButton()
        updateFilterButtonTitle()
    }
    
    private func updateSortButton() {
        
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        let title = settings.sorting.title
        sortLabel.text = title
    }
    
    private func updateFilterButtonTitle() {
        
        guard let userID = UserProfileManager.shared.profileID else {
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
            self.settingsLabel.text = "All"
            return
        }
        
        let selectedSum = (selectedInterests.count) + (selectedCategories.count) + (selectedSecurityTypes.count) + settings.disabledAccounts.count
        self.settingsLabel.text = selectedSum > 0 ? "Filter applied" : "All"
    }
    
    //MARK: - Actions
    
    @IBAction func sortAction() {
        delegate?.onSortButtonTapped()
    }
    
    @IBAction func settingsButtonAction() {
        delegate?.onSettingsButtonTapped()
    }
}
