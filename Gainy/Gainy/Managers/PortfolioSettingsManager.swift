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
    
    // Check types
    let interests: [Int]
    let industries: [Int]
    let securityTypes: [Int]
    
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
    
    @UserDefault("PortfolioSettingsManager.settings")
    private var settings: [UserId : PortfolioSettings]?
    
    //All Sortings
    func sortingsForUserID(userID: Int) -> [PortfolioSortingField] {
        
        let sortingList: [PortfolioSortingField] = PortfolioSortingField.rawOrder
        return sortingList
    }

    func getSettingByUserID(_ id: Int) -> PortfolioSettings {
        if settings == nil {
            settings = [:]
        }
        if let settings = settings?[id] {
            return settings
        } else {
            let defSettigns = PortfolioSettings(sorting: PortfolioSortingField.matchScore, ascending: false, includeClosedPositions: true, onlyLongCapitalGainTax: true, interests: [], industries: [], securityTypes: [], disabledAccounts: [])
            settings?[id] = defSettigns
            return defSettigns
        }
    }
    
    func changeAscendingForUserId(_ id: Int, ascending: Bool) {
        let cur = getSettingByUserID(id)
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, industries: cur.industries, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeSortingForUserId(_ id: Int, sorting: PortfolioSortingField) {
        let cur = getSettingByUserID(id)
        settings?[id] = PortfolioSettings(sorting: sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, industries: cur.industries, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeIncludeClosedPositionsForUserId(_ id: Int, includeClosedPositions: Bool) {
        let cur = getSettingByUserID(id)
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, industries: cur.industries, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeOnlyLongCapitalGainTaxForUserId(_ id: Int, onlyLongCapitalGainTax: Bool) {
        let cur = getSettingByUserID(id)
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: onlyLongCapitalGainTax, interests: cur.interests, industries: cur.industries, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeInterestsForUserId(_ id: Int, interests: [Int]) {
        let cur = getSettingByUserID(id)
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: interests, industries: cur.industries, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
   
    func changeIndustriesForUserId(_ id: Int, industries: [Int]) {
        let cur = getSettingByUserID(id)
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, industries: industries, securityTypes: cur.securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changeSecurityTypesForUserId(_ id: Int, securityTypes: [Int]) {
        let cur = getSettingByUserID(id)
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, industries: cur.industries, securityTypes: securityTypes, disabledAccounts: cur.disabledAccounts)
    }
    
    func changedisabledAccountsForUserId(_ id: Int, disabledAccounts: [PlaidAccountData]) {
        let cur = getSettingByUserID(id)
        settings?[id] = PortfolioSettings(sorting: cur.sorting, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, industries: cur.industries, securityTypes: cur.securityTypes, disabledAccounts: disabledAccounts)
    }
}
