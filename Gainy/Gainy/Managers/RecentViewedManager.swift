//
//  RecentViewedManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 09.05.2023.
//

import UIKit
import GainyAPI
import GainyCommon

/// Recent visited TTF/Stock manager
final class RecentViewedManager {
    
    static let shared = RecentViewedManager()
    
    //MARK: - Operations
    
    @UserDefaultArray(key: "RecentViewedManager:list")
    var recent: [RecentViewedData]
    
    /// Max store count
    private let maxCount = 18
    
    /// Try to add TTF to viewed
    /// - Parameter model: RecommendedCollectionViewCellModel model
    func addViewedTTF(_ model: RecommendedCollectionViewCellModel) {
        if !recent.contains(where: {
            if case .ttf(let x) = $0, x.id == model.id {
                    return true
                }
            return false
         }) {
            if recent.count >= maxCount {
                recent = Array(recent.dropFirst())
                recent.append(.ttf(model: model))
            } else {
                recent.append(.ttf(model: model))
            }
        }
    }
    
    func addViewedStock(_ model: HomeTickerInnerTableViewCellModel) {
        if !recent.contains(where: {
            if case .stock(let x) = $0, x.symbol == model.symbol {
                    return true
                }
            return false
        }) {
            if recent.count >= maxCount {
                recent = Array(recent.dropFirst())
                recent.append(.stock(model: model))
            } else {
                recent.append(.stock(model: model))
            }
        }
    }
    
    
    func clearAll() {
        recent.removeAll()
    }
}

/// Recent visit data
enum RecentViewedData: Codable {
    case ttf(model: RecommendedCollectionViewCellModel)
    case stock(model: HomeTickerInnerTableViewCellModel)
}
