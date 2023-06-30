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
    let metrics: HomeTickerInnerMetrics?
    
    init(name: String, symbol: String, type: String) {
        self.name = name
        self.symbol = symbol
        self.type = type
        self.metrics = nil
    }
    
    init(ticker: AltStockTicker) {
        self.name = ticker.name ?? ""
        self.symbol = ticker.symbol
        self.type = ticker.type ?? ""
        self.metrics = .init(tickerMetrics: ticker.tickerMetrics)
    }
    
    
    
    func statsDayValueRaw(_ range: ScatterChartView.ChartPeriod) -> Float {
        switch range{
        case .d1:
            let storedData = TickerLiveStorage.shared.getSymbolData(symbol)
            let priceChange = storedData?.priceChangeToday ?? 0.0
            return priceChange
        case .w1:
            return metrics?.priceChange_1w ?? 0.0
        case .m1:
            return metrics?.priceChange_1m ?? 0.0
        case .m3:
            return metrics?.priceChange_3m ?? 0.0
        case .y1:
            return metrics?.priceChange_1y ?? 0.0
        case .y5:
            return metrics?.priceChange_5y ?? 0.0
        case .all:
            return metrics?.priceChangeAll ?? 0.0
        }
    }
}

struct HomeTickerInnerMetrics: Codable {
    
    let priceChange_1m: Float
    let priceChange_1w: Float
    let priceChange_3m: Float
    let priceChange_1y: Float
    let priceChange_5y: Float
    let priceChangeAll: Float
    
    init(tickerMetrics: RemoteTickerDetails.TickerMetric?) {
        self.priceChange_1m = tickerMetrics?.priceChange_1m ?? 0.0
        self.priceChange_1w = tickerMetrics?.priceChange_1w ?? 0.0
        self.priceChange_3m = tickerMetrics?.priceChange_3m ?? 0.0
        self.priceChange_1y = tickerMetrics?.priceChange_1y ?? 0.0
        self.priceChange_5y = tickerMetrics?.priceChange_5y ?? 0.0
        self.priceChangeAll = tickerMetrics?.priceChangeAll ?? 0.0
    }
}


