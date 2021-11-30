//
//  PortfolioSettingsManager.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/25/21.
//

import UIKit

typealias UserId = Int

struct PortfolioSettings: Codable {

    let sorting: PortfolioSortingField
    let ascending: Bool
    let includeClosedPositions: Bool
    let onlyLongCapitalGainTax: Bool
    
    let interests: [InfoDataSource]
    let categories: [InfoDataSource]
    let securityTypes: [InfoDataSource]
    
    let disabledAccounts: [PlaidAccountData]
    
    func sortingValue() -> PortfolioSortingField {
        
        let portfolioSortingsToShow: [PortfolioSortingField] = self.portfolioSortingsToShow
        if portfolioSortingsToShow.contains(where: { item in
            item == sorting
        }) {
            return sorting
        }
        
        return portfolioSortingsToShow.first ?? .matchScore
    }
    
    func sortingText() -> String {
        
        let portfolioSortingsToShow: [PortfolioSortingField] = self.portfolioSortingsToShow
        if portfolioSortingsToShow.contains(where: { item in
            item == sorting
        }) {
            return sorting.title
        }
        
        return portfolioSortingsToShow.first?.title ?? "Match Score"
    }
    
    var portfolioSortingsToShow: [PortfolioSortingField] {
        
        var sortingList: [PortfolioSortingField] = PortfolioSortingField.rawOrder

        if let index = sortingList.firstIndex(where: {$0 == sorting}) {
            sortingList.remove(at: index)
            sortingList.insert(sorting, at: 0)
        }
        return sortingList
    }
}

final class PortfolioSettingsManager {
    
    static let shared = PortfolioSettingsManager()
    
    @UserDefault("PortfolioSettingsManager.settings_v3_test")
    private var settings: [UserId : PortfolioSettings]?
    
    //All Sortings
    func sortingsForUserID(userID: Int) -> [PortfolioSortingField] {
        
        let sortingList: [PortfolioSortingField] = PortfolioSortingField.rawOrder
        return sortingList
    }
    
    func setInitialSettingsForUserId(_ id: Int, settings: PortfolioSettings) {

        if self.getSettingByUserID(id) == nil {
            self.settings?[id] = settings
        }
    }

    func getSettingByUserID(_ id: Int) -> PortfolioSettings? {
        if self.settings == nil {
            settings = [:]
        }
        if let settings = settings?[id] {
            return settings
        }
        return nil
    }
    
    func changeAscendingForUserId(_ id: Int, ascending: Bool) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeSortingForUserId(_ id: Int, sorting: PortfolioSortingField) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeIncludeClosedPositionsForUserId(_ id: Int, includeClosedPositions: Bool) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeOnlyLongCapitalGainTaxForUserId(_ id: Int, onlyLongCapitalGainTax: Bool) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeInterestsForUserId(_ id: Int, interests: [InfoDataSource]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: interests, categories: cur.categories, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
   
    func changeCategoriesForUserId(_ id: Int, categories: [InfoDataSource]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: categories, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeSecurityTypesForUserId(_ id: Int, securityTypes: [InfoDataSource]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, securityTypes: securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changedisabledAccountsForUserId(_ id: Int, disabledAccounts: [PlaidAccountData]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, securityTypes: cur.securityTypes, disabledAccounts: disabledAccounts)
    }
}
