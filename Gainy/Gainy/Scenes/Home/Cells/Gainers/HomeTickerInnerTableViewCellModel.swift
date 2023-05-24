//
//  HomeTickerInnerTableViewCellModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.05.2023.
//

import Foundation
import GainyAPI

/// New model for Alt Stock
struct HomeTickerInnerTableViewCellModel: Codable {
    let name: String
    let symbol: String
    let type: String
    
    init(name: String, symbol: String, type: String) {
        self.name = name
        self.symbol = symbol
        self.type = type
    }
    
    init(ticker: AltStockTicker) {
        self.name = ticker.name ?? ""
        self.symbol = ticker.symbol
        self.type = ticker.type ?? ""
    }
}

