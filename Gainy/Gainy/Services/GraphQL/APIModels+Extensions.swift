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
    
//    var isMatch: Bool {
//        get
//    }
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

extension RemoteTickerDetails: RemoteMatchable {
    var matchScore: String {
        "\(TickerLiveStorage.shared.getMatchData(symbol ?? "")?.matchScore ?? 0)"
    }
    
//    var isMatch: Bool {
//        TickerLiveStorage.shared.getMatchData(symbol ?? "")?.isMatch ?? false
//    }
    
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

extension RemoteTickerExtraDetails.TickerEvent {
    var date: Date {
        return ((timestamp ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date ?? Date()).convertTo(region: Region.current).date
    }
    
    var am9Time: Date {
        let curDate = date
        return DateInRegion(year: curDate.year, month: curDate.month, day: curDate.day, hour: 9, minute: 0, second: 0, region: Region.current).date
    }
    var pm11Time: Date {
        date.startOfDay + 23.hours
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfTradingDay: Date {
        let NY = Region(calendar: SwiftDate.defaultRegion.calendar, zone: Zones.americaNewYork, locale: Locales.current)
        return DateInRegion(year: self.year, month: self.month, day: self.day, hour: 9, minute: 30, second: 0, region: NY).date
    }
}
