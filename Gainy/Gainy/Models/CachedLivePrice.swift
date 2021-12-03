//
//  CachedLivePrice.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit

struct CachedLivePrice: Codable {
    let symbol: String
    let dateTime: String
    let currentPrice: Float
    let priceChangeToday: Float
    
    init(remotePrice: LivePrice) {
        symbol = remotePrice.symbol ?? ""
        dateTime = remotePrice.datetime ?? ""
        currentPrice = Float(remotePrice.close ?? 0.0)
        priceChangeToday = Float(remotePrice.dailyChangeP ?? 0.0)
    }
    
    init(remotePrice: RealtimePrice) {
        symbol = remotePrice.symbol ?? ""
        dateTime = remotePrice.time ?? ""
        currentPrice = Float(remotePrice.actualPrice ?? 0.0)
        priceChangeToday = Float(remotePrice.relativeDailyChange ?? 0.0)
    }
    
    init(remotePrice: RemoteTickerDetailsFull.RealtimeMetric) {
        symbol = remotePrice.symbol ?? ""
        dateTime = remotePrice.time ?? ""
        currentPrice = Float(remotePrice.actualPrice ?? 0.0)
        priceChangeToday = Float(remotePrice.relativeDailyChange ?? 0.0)
    }
    
    init(remotePrice: RemoteTickerExtraDetails.RealtimeMetric) {
        symbol = remotePrice.symbol ?? ""
        dateTime = remotePrice.time ?? ""
        currentPrice = Float(remotePrice.actualPrice ?? 0.0)
        priceChangeToday = Float(remotePrice.relativeDailyChange ?? 0.0)
    }
}
