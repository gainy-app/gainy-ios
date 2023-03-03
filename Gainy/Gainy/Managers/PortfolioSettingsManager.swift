//
//  PortfolioSettingsManager.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/25/21.
//

import UIKit
import GainyCommon

typealias UserId = Int

struct PortfolioSettings: Codable {

    let sorting: PortfolioSortingField
    let pieChartSorting: [PieChartMode : PortfolioSortingField]
    let pieChartAscending: [PieChartMode : Bool]
    let pieChartMode: PieChartMode
    let ascending: Bool
    let includeClosedPositions: Bool
    let onlyLongCapitalGainTax: Bool
    
    let interests: [InfoDataSource]
    let categories: [InfoDataSource]
    
    let disabledAccounts: [PlaidAccountData]
    
    let pieBrokers: [PlaidAccountData]
    
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
        
        let isOnboarded = UserProfileManager.shared.isOnboarded
        let defaultValue = isOnboarded ? "Match Score" : "Default"
        return portfolioSortingsToShow.first?.title ?? defaultValue
    }
    
    var portfolioSortingsToShow: [PortfolioSortingField] {
        
        var sortingList: [PortfolioSortingField] = PortfolioSortingField.rawOrder

        if let index = sortingList.firstIndex(where: {$0 == sorting}) {
            sortingList.remove(at: index)
            sortingList.insert(sorting, at: 0)
        }
        return sortingList
    }
    
    
    func sortingValue(mode: PieChartMode) -> PortfolioSortingField {
        
        let portfolioSortingsToShow: [PortfolioSortingField] = self.portfolioPieChartSecurityTypeSortingsToShow(mode: mode)
        if let field = pieChartSorting[mode] {
            if portfolioSortingsToShow.contains(where: { item in
                item == field
            }) {
                return field
            }
        }
        
        return portfolioSortingsToShow.first ?? .weight
    }
    
    func ascending(mode: PieChartMode) -> Bool {
        
        return pieChartAscending[mode] ?? false
    }
    
    func sortingText(mode: PieChartMode) -> String {
        
        let portfolioSortingsToShow: [PortfolioSortingField] = self.portfolioPieChartSecurityTypeSortingsToShow(mode: mode)
        if let field = pieChartSorting[mode] {
            if portfolioSortingsToShow.contains(where: { item in
                item == field
            }) {
                return field.title
            }
        }
        
        return portfolioSortingsToShow.first?.title ?? "Weight"
    }
    
    func portfolioPieChartSecurityTypeSortingsToShow(mode: PieChartMode) -> [PortfolioSortingField] {
        
        var sortingList: [PortfolioSortingField] = PortfolioSortingField.othersRawOrder
        if mode == .tickers {
            sortingList = PortfolioSortingField.tickersRawOrder
        }
        if let field = pieChartSorting[mode] {
            if let index = sortingList.firstIndex(where: {$0 == field}) {
                sortingList.remove(at: index)
                sortingList.insert(field, at: 0)
            }
        }
        return sortingList
    }
    
    var isFilterApplied: Bool {
        let intersIDs = interests.filter { item in
            item.selected
        }.compactMap({$0.id})
        
        let catsIDs = categories.filter { item in
            item.selected
        }.compactMap({$0.id})
        
        if interests.count == intersIDs.count && catsIDs.count == categories.count {
            return false
        }
        
        let selectedSum = (intersIDs.count) + (catsIDs.count)
        return selectedSum > 0
    }
}

final class PortfolioSettingsManager {
    
    static let shared = PortfolioSettingsManager(defaultsString: "PortfolioSettingsManager.settings_v1.0.1_prod")
    static let pieShared = PortfolioSettingsManager(defaultsString: "PiePortfolioSettingsManager.settings_v1.0.1_prod")
    
    private let defaultsString: String
    private var settings: [UserId : PortfolioSettings]? {
        get {
            guard let data = UserDefaults.standard.object(forKey: defaultsString) as? Data else { return nil }
            return try? JSONDecoder().decode([UserId : PortfolioSettings].self, from: data)
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: defaultsString)
        }
    }
    
    private init(defaultsString: String) {
        self.defaultsString = defaultsString
    }
    
    //All Sortings
    func sortingsForUserID(userID: Int) -> [PortfolioSortingField] {
        
        let sortingList: [PortfolioSortingField] = PortfolioSortingField.rawOrder
        return sortingList
    }
    
    func sortingsForUserID(userID: Int, mode: PieChartMode) -> [PortfolioSortingField] {
        
        if mode == .tickers { return PortfolioSortingField.tickersRawOrder }
        return PortfolioSortingField.othersRawOrder
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
    
    func changePieChartModeForUserId(_ id: Int, pieChartMode: PieChartMode) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending, pieChartMode: pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changePieChartAscendingForUserId(_ id: Int, pieChartAscending: [PieChartMode : Bool]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: pieChartAscending, pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changePieChartSortingForUserId(_ id: Int, pieChartSorting: [PieChartMode : PortfolioSortingField]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: pieChartSorting, pieChartAscending: cur.pieChartAscending, pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changeAscendingForUserId(_ id: Int, ascending: Bool) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: cur.pieChartMode, ascending: ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changeSortingForUserId(_ id: Int, pieChartMode: PieChartMode) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changeSortingForUserId(_ id: Int, sorting: PortfolioSortingField) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changeIncludeClosedPositionsForUserId(_ id: Int, includeClosedPositions: Bool) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changeOnlyLongCapitalGainTaxForUserId(_ id: Int, onlyLongCapitalGainTax: Bool) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changeInterestsForUserId(_ id: Int, interests: [InfoDataSource]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changePieBrokersForUserId(_ id: Int, brokers: [PlaidAccountData]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: cur.disabledAccounts, pieBrokers: brokers)
    }
   
    func changeCategoriesForUserId(_ id: Int, categories: [InfoDataSource]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: categories, disabledAccounts: cur.disabledAccounts, pieBrokers: cur.pieBrokers)
    }
    
    func changeDisabledAccountsForUserId(_ id: Int, disabledAccounts: [PlaidAccountData]) {
        guard let cur = getSettingByUserID(id) else { return }
        settings?[id] = PortfolioSettings(sorting: cur.sorting, pieChartSorting: cur.pieChartSorting, pieChartAscending: cur.pieChartAscending,  pieChartMode: cur.pieChartMode, ascending: cur.ascending, includeClosedPositions: cur.includeClosedPositions, onlyLongCapitalGainTax: cur.onlyLongCapitalGainTax, interests: cur.interests, categories: cur.categories, disabledAccounts: disabledAccounts, pieBrokers: cur.pieBrokers)
    }
}
