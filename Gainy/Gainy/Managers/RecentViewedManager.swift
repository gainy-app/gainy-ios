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
        if !recent.contains(where: {$0.ttf?.id == model.id}) {
            if recent.count >= maxCount {
                recent = Array(recent.dropFirst())
                recent.append(RecentViewedData(date: Date(),
                                               ttf: model))
            } else {
                recent.append(RecentViewedData(date: Date(),
                                               ttf: model))
            }
        }
    }
    
}

/// Recent visit data
struct RecentViewedData: Codable {
    let date: Date
    
    let ttf: RecommendedCollectionViewCellModel?
    //let ticker: RemoteTickerDetails?
}
