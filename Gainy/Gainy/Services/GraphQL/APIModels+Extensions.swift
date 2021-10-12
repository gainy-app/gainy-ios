//
//  APIModels+Extensions.swift
//  Gainy
//
//  Created by Anton Gubarenko on 07.09.2021.
//

import UIKit
import SwiftDate

extension RemoteTickerDetails: Hashable {
    public static func == (lhs: RemoteTickerDetails, rhs: RemoteTickerDetails) -> Bool {
        lhs.symbol == rhs.symbol
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.symbol)
    }
}

protocol RemotePricable {
    var currentPrice: Float {
        get
    }
    
    var priceChangeToday: Float {
        get
    }
}

protocol RemoteMatchable {
    var matchScore: String {
        get
    }
    
    var isMatch: Bool {
        get
    }
}

// Adding missing fields from old Model
extension RemoteTickerDetails: RemotePricable {
    var currentPrice: Float {
        TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.currentPrice ?? 0.0
    }
    
    var priceChangeToday: Float {
        TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.priceChangeToday ?? 0.0
    }
}

extension RemoteTickerDetails.TickerFinancial: RemotePricable {
    var currentPrice: Float {
        TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.currentPrice ?? 0.0
    }
    
    var priceChangeToday: Float {
        TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.priceChangeToday ?? 0.0
    }
}

extension RemoteTickerDetails: RemoteMatchable {
    var matchScore: String {
        "\(TickerLiveStorage.shared.getMatchData(symbol ?? "")?.matchScore ?? 0)"
    }
    
    var isMatch: Bool {
        TickerLiveStorage.shared.getMatchData(symbol ?? "")?.isMatch ?? false
    }
    
}

extension RemoteTickerDetails.TickerFinancial: RemoteMatchable {
    var matchScore: String {
        "\(TickerLiveStorage.shared.getMatchData(symbol ?? "")?.matchScore ?? 0)"
    }
    
    var isMatch: Bool {
        TickerLiveStorage.shared.getMatchData(symbol ?? "")?.isMatch ?? false
    }
    
}

//MARK: - Fetching extra fields for Tickrs from other storage
extension FetchLiveTickersDataQuery.Data.FetchLivePrice: RemotePricable {
    var currentPrice: Float {
        Float(close ?? 0.0) + Float(dailyChange ?? 0.0)
    }
    
    var priceChangeToday: Float {
        Float(dailyChangeP ?? 0.0)
    }
}


extension DiscoverNewsQuery.Data.FetchNewsDatum: Hashable {
    public static func == (lhs: DiscoverNewsQuery.Data.FetchNewsDatum, rhs: DiscoverNewsQuery.Data.FetchNewsDatum) -> Bool {
        lhs.datetime == rhs.datetime
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.datetime)
    }
}

extension RemoteCollectionDetails: Hashable {
    public static func == (lhs: RemoteCollectionDetails, rhs: RemoteCollectionDetails) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension RemoteCollectionDetails: Reorderable {
    typealias OrderElement = Int
        var orderElement: OrderElement { id ?? 0 }
}

extension RemoteTicker.TickerEvent {
    var date: Date {
        return (timestamp ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date ?? Date()
    }
    
    var am9Time: Date {
        date.dateAtStartOf(.day).date
    }
}
