//
//  MarketDataFields.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.09.2021.
//

import Foundation

enum MarketDataField: Int, Codable {
    case dividendGrowth = 0, evs, marketCap, monthToDay, netProfit, growsRateYOY, matchScore
    
    var title: String {
        switch self {
        case .dividendGrowth:
            return "Dividend Growth"
        case .evs:
            return "EV/S"
        case .marketCap:
            return "Market Capitalization"
        case .monthToDay:
            return "30 days price change"
        case .netProfit:
            return "Net Profit Margin"
        case .growsRateYOY:
            return "Revenue Growth"
        case .matchScore:
            return "Match Score"
        }
    }
    
    var shortTitle: String {
        switch self {
        case .dividendGrowth:
            return "Dividend Growth".uppercased()
        case .evs:
            return "EV/S\n".uppercased()
        case .marketCap:
            return "Market\nCap".uppercased()
        case .monthToDay:
            return "30 Days\nprice change".uppercased()
        case .netProfit:
            return "Net\nProfit".uppercased()
        case .growsRateYOY:
            return "Rev\nGrowth".uppercased()
        case .matchScore:
            return "Match\nScore"
        }
    }
    
    var isPercent: Bool {
        switch self {
        case .dividendGrowth:
            return false
        case .evs:
            return false
        case .marketCap:
            return false
        case .monthToDay:
            return false
        case .netProfit:
            return true
        case .growsRateYOY:
            return false
        case .matchScore:
            return false
        }
    }
    
    func sortFunc (isAsc: Bool, _ lhs: CollectionCardViewCellModel, _ rhs: CollectionCardViewCellModel) -> Bool {
        if isAsc {
            switch self {
            case .dividendGrowth:
                return lhs.rawTicker.tickerFinancials.last!.dividendGrowth ?? 0.0 < rhs.rawTicker.tickerFinancials.last!.dividendGrowth ?? 0.0
            case .evs:
                return (lhs.rawTicker.tickerFinancials.last!.enterpriseValueToSales ?? 0.0) < (rhs.rawTicker.tickerFinancials.last!.enterpriseValueToSales ?? 0.0)
            case .marketCap:
                return lhs.rawTicker.tickerFinancials.last!.marketCapitalization ?? 0.0 < rhs.rawTicker.tickerFinancials.last!.marketCapitalization ?? 0.0
            case .monthToDay:
                return lhs.rawTicker.tickerFinancials.last!.monthPricePerformance ?? 0.0 < rhs.rawTicker.tickerFinancials.last!.monthPricePerformance ?? 0.0
            case .netProfit:
                return lhs.rawTicker.tickerFinancials.last!.netProfitMargin ?? 0.0 < rhs.rawTicker.tickerFinancials.last!.netProfitMargin ?? 0.0
            case .growsRateYOY:
                return lhs.rawTicker.tickerFinancials.last!.quarterlyRevenueGrowthYoy ?? 0.0 < rhs.rawTicker.tickerFinancials.last!.quarterlyRevenueGrowthYoy ?? 0.0
            case .matchScore:
                return lhs.rawTicker.matchScore < rhs.rawTicker.matchScore
            }
        } else {
            switch self {
            case .dividendGrowth:
                return lhs.rawTicker.tickerFinancials.last!.dividendGrowth ?? 0.0 > rhs.rawTicker.tickerFinancials.last!.dividendGrowth ?? 0.0
            case .evs:
                return (lhs.rawTicker.tickerFinancials.last!.enterpriseValueToSales ?? 0.0) > (rhs.rawTicker.tickerFinancials.last!.enterpriseValueToSales ?? 0.0)
            case .marketCap:
                return lhs.rawTicker.tickerFinancials.last!.marketCapitalization ?? 0.0 > rhs.rawTicker.tickerFinancials.last!.marketCapitalization ?? 0.0
            case .monthToDay:
                return lhs.rawTicker.tickerFinancials.last!.monthPricePerformance ?? 0.0 > rhs.rawTicker.tickerFinancials.last!.monthPricePerformance ?? 0.0
            case .netProfit:
                return lhs.rawTicker.tickerFinancials.last!.netProfitMargin ?? 0.0 > rhs.rawTicker.tickerFinancials.last!.netProfitMargin ?? 0.0
            case .growsRateYOY:
                return lhs.rawTicker.tickerFinancials.last!.quarterlyRevenueGrowthYoy ?? 0.0 > rhs.rawTicker.tickerFinancials.last!.quarterlyRevenueGrowthYoy ?? 0.0
            case .matchScore:
                return lhs.rawTicker.matchScore > rhs.rawTicker.matchScore
            }
        }
    }
    
    /// Order to place on sorting
    static let rawOrder: [MarketDataField] = [matchScore, growsRateYOY, evs, marketCap, monthToDay, netProfit, growsRateYOY, dividendGrowth]
    
    static let metricsOrder: [MarketDataField] = [matchScore, growsRateYOY, evs, marketCap, monthToDay, netProfit]
}
