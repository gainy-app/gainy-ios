//
//  CollectionDetailHistoryInfoModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 11.11.2022.
//

import Foundation
import GainyAPI

struct CollectionDetailHistoryInfoModel {
    
    let lines: [CollectionDetailHistoryCellInfoModel]
    
    init(status: [TradingGetTtfHistoryQuery.Data.AppTradingCollectionVersion]) {
        var newLines: [CollectionDetailHistoryCellInfoModel] = []
        
        for line in status {
            newLines.append(CollectionDetailHistoryCellInfoModel.init(delta: line.targetAmountDelta, date: line.createdAt, tags: line.history.compactMap({$0.tags})))
        }
        self.lines = newLines
    }
    
    /// If first transaction is Pending and exists
    var showPending: Bool {
        if let firstLine = lines.first {
            return firstLine.tags.joined().contains("PENDING")
        }
        return false
    }
}

struct CollectionDetailHistoryCellInfoModel: Equatable {
    let delta: Double
    let date: String
    let tags: [String]
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.delta == rhs.delta && lhs.date == lhs.date && lhs.tags == rhs.tags
    }
}
