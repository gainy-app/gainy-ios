//
//  CollectionDetailHistoryInfoModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 11.11.2022.
//

import Foundation
import GainyAPI
import GainyCommon

struct CollectionDetailHistoryInfoModel {
    
    let lines: [CollectionDetailHistoryCellInfoModel]
    
    private(set) var rawHistory: [TradingHistoryFrag] = []
    
    init(status: [TradingGetTtfHistoryQuery.Data.AppTradingCollectionVersion]) {
        var newLines: [CollectionDetailHistoryCellInfoModel] = []
        
        for line in status {
            let jTags = line.history.compactMap({$0.fragments.tradingHistoryFrag.tags})
            rawHistory.append(contentsOf: line.history.compactMap({$0.fragments.tradingHistoryFrag}))
            var tags: [Tags] = []
            for tag in jTags {
                for key in tag.keys {
                    if tag[key] as? Int == 1, let tag = Tags(rawValue: key) {
                        tags.append(tag)
                    }
                }
            }
            if let historyData = line.history.compactMap({$0.fragments.tradingHistoryFrag}).first {
                newLines.append(CollectionDetailHistoryCellInfoModel.init(delta: line.targetAmountDelta  ?? 0.0 ,
                                                                          date: line.createdAt,
                                                                          tags: tags,
                                                                          isCancellable: line.status == "PENDING",
                                                                          historyData: historyData))
            }
        }
        self.lines = newLines
    }
    
    init(status: [TradingGetStockHistoryQuery.Data.AppTradingOrder]) {
        var newLines: [CollectionDetailHistoryCellInfoModel] = []
        
        for line in status {
            let jTags = line.history?.fragments.tradingHistoryFrag.tags ?? [:]
            
            var tags: [Tags] = []
            for key in jTags.keys {
                if jTags[key] as? Int == 1, let tag = Tags(rawValue: key) {
                    tags.append(tag)
                }
            }
            if let historyData = line.history?.fragments.tradingHistoryFrag {
                newLines.append(CollectionDetailHistoryCellInfoModel.init(delta: line.targetAmountDelta ?? 0.0 ,
                                                                          date: line.createdAt,
                                                                          tags: tags,
                                                                          isCancellable: historyData.tradingOrder?.status == "PENDING",
                                                                          historyData: historyData))
            }
        }
        self.lines = newLines
    }
    
    /// If first transaction is Pending and exists
    var showPending: Bool {
        if let firstLine = lines.first {
            return firstLine.tags.contains(.pending)
        }
        return false
    }
    
    var hasHistory: Bool {
        !lines.isEmpty
    }
}

struct CollectionDetailHistoryCellInfoModel: Equatable {
    let delta: Double
    let date: String
    var tags: [Tags]
    let isCancellable: Bool
    let historyData: TradingHistoryFrag
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.delta == rhs.delta && lhs.date == lhs.date && lhs.tags == rhs.tags
    }
}
