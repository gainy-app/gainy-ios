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
    
    let sorting: String
    let viewMode: ViewMode
}

final class CollectionsDetailsSettingsManager {
    
    static let shared = CollectionsDetailsSettingsManager()
    
    //All Sortings
    private(set) var sortings = ["EV/S", "Growth rate", "Market cap", "Month to day price", "Net Profit Margin, %"]
    
    
    
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
            let defSettigns = CollectionSettings(sorting: sortings.first ?? "EV/S", viewMode: .grid)
            settings?[id] = defSettigns
            return defSettigns
        }
    }
    
    func changeSortingForId(_ id: Int, sorting: String) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(sorting: sorting, viewMode: cur.viewMode)
    }
    
    func changeViewModeForId(_ id: Int, viewMode: CollectionSettings.ViewMode) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(sorting: cur.sorting, viewMode: viewMode )
    }
}
