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
            let jTags = line.history.compactMap({$0.tags})
            
            var tags: [String] = []
            for tag in jTags {
                for key in tag.keys {
                    if tag[key] as? Int == 1 {
                        tags.append(key.uppercased())
                    }
                }
            }
            newLines.append(CollectionDetailHistoryCellInfoModel.init(delta: line.targetAmountDelta,
                                                                      date: line.createdAt,
                                                                      tags: tags))
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
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.delta == rhs.delta && lhs.date == lhs.date && lhs.tags == rhs.tags
    }
    
    func colorForTag(for tag: String) -> String? {
        switch tag {
        case "buy".uppercased(), "deposit".uppercased(), "Withdraw".uppercased(), "sell".uppercased():
            return "38CF92"
        case "ttf".uppercased():
            return "6C5DD3"
        case "pending".uppercased():
            return "FCB224"
        case "canceled".uppercased():
            return "3A4448"
        case "error".uppercased():
            return "F95664"
        default:
            return nil
        }
    }
}
