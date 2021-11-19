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
    
    let collectionID: Int
    let sorting: MarketDataField
    let ascending: Bool
    let viewMode: ViewMode
    
    func sortingValue() -> MarketDataField {
        
        let marketDataToShow: [MarketDataField] = self.marketDataToShow
        if marketDataToShow.contains(where: { item in
            item == sorting
        }) {
            return sorting
        }
        
        return marketDataToShow.first ?? .matchScore
    }
    
    func sortingText() -> String {
        
        let marketDataToShow: [MarketDataField] = self.marketDataToShow
        if marketDataToShow.contains(where: { item in
            item == sorting
        }) {
            return sorting.title
        }
        
        return marketDataToShow.first?.title ?? "Match Score"
    }
    
    var marketDataToShow: [MarketDataField] {
        
        let defaultSortingList = MarketDataField.rawOrder
        var tickerMetrics = UserProfileManager.shared.profileMetricsSettings.filter { item in
            item.collectionId == collectionID
        }
        tickerMetrics = tickerMetrics.sorted { left, right in
            left.order < right.order
        }
        var sortingList: [MarketDataField] = []
        if tickerMetrics.count == 0 {
            sortingList = defaultSortingList
        } else {
            sortingList.append(.matchScore)
            for metric in MarketDataField.allCases {
                for item in tickerMetrics {
                    if metric.fieldName == item.fieldName {
                        sortingList.append(metric)
                    }
                }
            }
        }
        
        if let index = sortingList.firstIndex(where: {$0 == sorting}) {
            sortingList.remove(at: index)
            sortingList.insert(sorting, at: 0)
        }
        return sortingList
    }
}

final class CollectionsDetailsSettingsManager {
    
    static let shared = CollectionsDetailsSettingsManager()
    
    @UserDefault("CollectionsDetailsSettingsManager.settings_v2_test")
    private var settings: [CollectionId : CollectionSettings]?
    
    //MARK: - Functions
    
    //All Sortings
    func sortingsForCollectionID(collectionID: Int) -> [String] {
        
        let defaultSortingList = MarketDataField.rawOrder
        var tickerMetrics = UserProfileManager.shared.profileMetricsSettings.filter { item in
            item.collectionId == collectionID
        }
        tickerMetrics = tickerMetrics.sorted { left, right in
            left.order < right.order
        }
        var sortingList: [MarketDataField] = []
        if tickerMetrics.count == 0 {
            sortingList = defaultSortingList
        } else {
            sortingList.append(.matchScore)
            for metric in MarketDataField.allCases {
                for item in tickerMetrics {
                    if metric.fieldName == item.fieldName {
                        sortingList.append(metric)
                    }
                }
            }
        }
        
        return sortingList.map { item in
            return item.title
        }
    }
    
    func getSettingByID(_ id: Int) -> CollectionSettings {
        if settings == nil {
            settings = [:]
        }
        if let settings = settings?[id] {
            return settings
        } else {
            let defSettigns = CollectionSettings(collectionID: id, sorting: MarketDataField.matchScore, ascending: false, viewMode: .grid)
            settings?[id] = defSettigns
            return defSettigns
        }
    }
    
    
    //MARK: - Modifiers
    func changeSortingForId(_ id: Int, sorting: MarketDataField) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(collectionID: id, sorting: sorting, ascending: cur.ascending, viewMode: cur.viewMode)
    }
    
    func changeViewModeForId(_ id: Int, viewMode: CollectionSettings.ViewMode) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(collectionID: id, sorting: cur.sorting, ascending: cur.ascending, viewMode: viewMode )
    }
    
    func changeAscendingForId(_ id: Int, ascending: Bool) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(collectionID: id, sorting: cur.sorting, ascending: ascending, viewMode: cur.viewMode )
    }
}
