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
            let jTags = line.history.compactMap({$0.fragments.tradingHistoryFrag.tags})
            
            var tags: [String] = []
            for tag in jTags {
                for key in tag.keys {
                    if tag[key] as? Int == 1 {
                        tags.append(key.uppercased())
                    }
                }
            }
            if let historyData = line.history.compactMap({$0.fragments.tradingHistoryFrag}).first {
                newLines.append(CollectionDetailHistoryCellInfoModel.init(delta: line.targetAmountDelta,
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
            
            var tags: [String] = []
            for key in jTags.keys {
                if jTags[key] as? Int == 1 {
                    tags.append(key.uppercased())
                }
            }
            if let historyData = line.history?.fragments.tradingHistoryFrag {
                newLines.append(CollectionDetailHistoryCellInfoModel.init(delta: line.targetAmountDelta,
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
            return firstLine.tags.joined().contains("PENDING")
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
    let tags: [String]
    let isCancellable: Bool
    let historyData: TradingHistoryFrag
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.delta == rhs.delta && lhs.date == lhs.date && lhs.tags == rhs.tags
    }
    
    func colorForTag(for tag: String) -> String? {
        switch tag {
        case "buy".uppercased(), "deposit".uppercased(), "Withdraw".uppercased(), "sell".uppercased():
            return "38CF92"
        case "ttf".uppercased(), "stock".uppercased(), "ticker".uppercased():
            return "6C5DD3"
        case "pending".uppercased():
            return "FCB224"
        case "pending execution".uppercased():
            return "FCB224"
        case "cancelled".uppercased():
            return "B1BDC8"
        case "canceled".uppercased():
            return "B1BDC8"
        case "error".uppercased():
            return "F95664"
        default:
            return nil
        }
    }
}
