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
        currentPrice = Float(remotePrice.close ?? 0.0) + Float(remotePrice.dailyChange ?? 0.0)
        priceChangeToday = Float(remotePrice.dailyChangeP ?? 0.0)
    }    
}
