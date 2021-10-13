//
//  CollectionsDetailsSettingsManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit

typealias CollectionId = Int

struct CollectionSettings: Codable {
    enum ViewMode: Int, Codable {
        case list = 0, grid
    }
    
    let sorting: MarketDataField
    let ascending: Bool
    let viewMode: ViewMode
    
    var marketDataToShow: [MarketDataField] {
        var sortingList = MarketDataField.rawOrder
        if let index = sortingList.firstIndex(where: {$0 == sorting}) {
            sortingList.remove(at: index)
            sortingList.insert(sorting, at: 0)
        }
        return sortingList
    }
}

final class CollectionsDetailsSettingsManager {
    
    static let shared = CollectionsDetailsSettingsManager()
    
    //All Sortings
    private(set) var sortings: [String] = [MarketDataField.matchScore.title, MarketDataField.evs.title, MarketDataField.growsRateYOY.title, MarketDataField.marketCap.title, MarketDataField.monthToDay.title, MarketDataField.netProfit.title]
    
    
    
    @UserDefault("CollectionsDetailsSettingsManager.settings")
    private var settings: [CollectionId : CollectionSettings]?
    
    //MARK: - Functions
    
    func getSettingByID(_ id: Int) -> CollectionSettings {
        if settings == nil {
            settings = [:]
        }
        if let settings = settings?[id] {
            return settings
        } else {
            let defSettigns = CollectionSettings(sorting: MarketDataField.matchScore, ascending: false, viewMode: .grid)
            settings?[id] = defSettigns
            return defSettigns
        }
    }
    
    
    //MARK: - Modifiers
    func changeSortingForId(_ id: Int, sorting: MarketDataField) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(sorting: sorting, ascending: cur.ascending, viewMode: cur.viewMode)
    }
    
    func changeViewModeForId(_ id: Int, viewMode: CollectionSettings.ViewMode) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(sorting: cur.sorting, ascending: cur.ascending, viewMode: viewMode )
    }
    
    func changeAscendingForId(_ id: Int, ascending: Bool) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(sorting: cur.sorting, ascending: ascending, viewMode: cur.viewMode )
    }
}
