//
//  APIModels+Extensions.swift
//  Gainy
//
//  Created by Anton Gubarenko on 07.09.2021.
//

import UIKit

extension SearchTickersQuery.Data.Ticker: Hashable {
    public static func == (lhs: SearchTickersQuery.Data.Ticker, rhs: SearchTickersQuery.Data.Ticker) -> Bool {
        lhs.symbol == rhs.symbol
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.symbol)
    }
}

//Adding missing fields from old Model
extension SearchTickersQuery.Data.Ticker {
    var currentPrice: Float {
        return TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.currentPrice ?? 0.0
    }
    
    var priceChangeToday: Float {
        return TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.priceChangeToday ?? 0.0
    }
}

extension SearchTickersQuery.Data.Ticker.TickerFinancial {
    var currentPrice: Float {
        return TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.currentPrice ?? 0.0
    }
    
    var priceChangeToday: Float {
        return TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.priceChangeToday ?? 0.0
    }
}

//MARK: - Fetching extra fields for Tickrs from other storage
extension FetchLiveTickersDataQuery.Data.FetchLivePrice {
    var currentPrice: Float {
        return Float(close ?? 0.0) + Float(dailyChange ?? 0.0)
    }
    
    var priceChangeToday: Float {
        return Float(dailyChangeP ?? 0.0)
    }
}

extension DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker {
    var currentPrice: Float {
        return TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.currentPrice ?? 0.0
    }
    
    var priceChangeToday: Float {
        return TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.priceChangeToday ?? 0.0
    }
}

extension DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker.TickerFinancial {
    var currentPrice: Float {
        return TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.currentPrice ?? 0.0
    }
    
    var priceChangeToday: Float {
        return TickerLiveStorage.shared.getSymbolData(symbol ?? "")?.priceChangeToday ?? 0.0
    }
}


extension SearchCollectionDetailsQuery.Data.Collection : Hashable {
    public static func == (lhs: SearchCollectionDetailsQuery.Data.Collection, rhs: SearchCollectionDetailsQuery.Data.Collection) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
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

extension DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker.TickerIndustry {
    func toSearch() -> SearchTickersQuery.Data.Ticker.TickerIndustry {
        SearchTickersQuery.Data.Ticker.TickerIndustry.init(gainyIndustry: gainyIndustry.map({$0.toSearch()}))
    }
}

extension DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker.TickerIndustry.GainyIndustry {
    func toSearch() -> SearchTickersQuery.Data.Ticker.TickerIndustry.GainyIndustry {
        SearchTickersQuery.Data.Ticker.TickerIndustry.GainyIndustry.init(id: id, name: name)
    }
}

extension DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker {
    func toSearchTicker() -> SearchTickersQuery.Data.Ticker {
        SearchTickersQuery.Data.Ticker.init(symbol: symbol, name: name, description: description, tickerFinancials: tickerFinancials.compactMap({
            SearchTickersQuery.Data.Ticker.TickerFinancial.init(peRatio: $0.peRatio, marketCapitalization: $0.marketCapitalization, highlight: $0.highlight, dividendGrowth: $0.dividendGrowth, symbol: $0.symbol, createdAt: $0.createdAt)
        }),
        tickerIndustries: [])
    }
}

extension SearchTickersQuery.Data.Ticker.TickerIndustry {
    func toDiscovery() -> DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker.TickerIndustry {
        DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker.TickerIndustry.init(gainyIndustry: gainyIndustry.map({$0.toDiscovery()}))
    }
}

extension SearchTickersQuery.Data.Ticker.TickerIndustry.GainyIndustry {
    func toDiscovery() -> DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker.TickerIndustry.GainyIndustry {
        DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker.TickerIndustry.GainyIndustry.init(id: id, name: name)
    }
}
