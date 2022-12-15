//
//  RemoteTicker+DW.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.12.2022.
//

import Foundation

extension TickerInfo {
    
    /// Show or hide Invest
    var isTradingEnabled: Bool {
        ticker.isTradingEnabled ?? false
    }
    
    /// Is Stock Purchased
    var isPurchased: Bool {
        guard isTradingEnabled else {return false}
        if let tradeStatus {
            return (tradeStatus.actualValue ?? 0.0) > 0.0
        }
        return false
    }
    
    /// If we do have trade history
    var haveHistory: Bool {
        guard isTradingEnabled else {return false}
        
        return !tradeHistory.isEmpty
        
        return false
    }
}
