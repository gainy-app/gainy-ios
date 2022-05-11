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
    var matchScore: Int {
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

//MARK: - Fetching extra fields for Tickrs from other storage
extension FetchLiveTickersDataQuery.Data.Ticker: RemotePricable {
    var currentPrice: Float {
        Float(realtimeMetrics?.actualPrice ?? 0.0)
    }
    
    var priceChangeToday: Float {
        Float(realtimeMetrics?.relativeDailyChange ?? 0.0)
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

extension RemoteShortCollectionDetails: Reorderable {
    typealias OrderElement = Int
    var orderElement: OrderElement { id ?? 0 }
}

extension RemoteTicker: Reorderable {
    typealias OrderElement = String
    var orderElement: OrderElement { symbol ?? "" }
}

extension RemoteCollectionDetails {
    var prefetchedTickers: [TickerDetails] {
        CollectionsManager.shared.prefetchedCollectionsData[id ?? -1] ?? []
    }
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

protocol ChartMergable {
    var date: Date {
        get
    }
    
    var val: Float {
        get
    }
}

extension DiscoverChartsQuery.Data.Chart: ChartMergable {
    var val: Float {
        adjustedClose ?? 0.0
    }
}



extension GetPortfolioChartsQuery.Data.GetPortfolioChart {
    var date: Date {
        return (datetime ?? "").toDate("yyy-MM-dd'T'HH:mm:ss")?.date ?? Date()
    }
}

extension GetPortfolioChartsQuery.Data.GetPortfolioChart: ChartMergable {
    var val: Float {
        Float(adjustedClose ?? 0.0)
    }
}

extension FetchStockMedianQuery.Data.IndustryMedianChart: ChartMergable {
    var val: Float {
        Float(medianPrice ?? 0.0)
    }
}

extension GetTtfChartQuery.Data.CollectionChart: ChartMergable {
    var val: Float {
        Float(adjustedClose ?? 0.0)
    }
}

typealias ChartNormalized = RemoteDateTimeConvertable & ChartMergable

func normalizeCharts(_ chart1: [ChartNormalized], _ chart2: [ChartNormalized]) -> ([ChartNormalized], [ChartNormalized]) {
    
    guard chart1.count > 3, chart2.count > 3 else {return (chart1, chart2)}
    
    let first1 = chart1.first!.date
    let first2 = chart2.first!.date
    
    guard first1 != first2 else {return (chart1, chart2)}
    
    let small = first1 < first2 ? chart2 : chart1
    var large =  first1 < first2 ? chart1 : chart2
    
    if let firstSmall = small.first?.date {
        large = Array(large.drop(while: {$0.date < firstSmall}))
    }
    var reconstructed: [ChartNormalized] = []
    
    let firstSmallDate = small.first!.date
    var largeIndex: Int = 0
    
    while largeIndex < large.count && large[largeIndex].date < firstSmallDate {
        reconstructed.append(small.first!)
        largeIndex += 1
    }
    if !reconstructed.isEmpty {
        reconstructed = reconstructed.dropLast()
        reconstructed.append(contentsOf: small)
    }
    
    return first1 < first2 ? (large, small) : (small, large)
}

extension GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Holding {
    var lovelyTitle: String {
        if let nameData = holdingDetails?.tickerName?.components(separatedBy: " "), nameData.count > 3 {
            return "\(nameData[3]) $\(nameData[2])"
        } else {
            return name ?? ""
        }
    }
    
    var expiryDateString: String {
        if let nameData = holdingDetails?.tickerName?.components(separatedBy: " "), nameData.count > 3 {
            let eventDate = nameData[1].toDate()?.date ?? Date()
            return eventDate.toFormat("MMM dd, yy")
        } else {
            return ""
        }
    }
}
