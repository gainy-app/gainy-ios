//
//  PortfolioSortingField.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/25/21.
//

import Foundation

enum PortfolioSortingField: Int, Codable, CaseIterable {
    
    case
    
    purchasedDate = 0,
    priceChangeForPeriod,
    percentOFPortfolio,
    matchScore,
    name,
    marketCap,
    earningsDate,
    weight
    
    var title: String {
        switch self {
        case .purchasedDate:
            return "Purchased Date"
        case .priceChangeForPeriod:
            return "Percent change"
        case .percentOFPortfolio:
            return "% of Portfolio"
        case .matchScore:
            return "Match Score"
        case .name:
            return "Name"
        case .marketCap:
            return "Market Cap"
        case .earningsDate:
            return "Earnings Date"
        case .weight:
            return "Weight"
        }
    }
    
    /// Portfolio: Order to place on sorting for po
    static let rawOrder: [PortfolioSortingField] = [purchasedDate, priceChangeForPeriod, percentOFPortfolio, matchScore, name, marketCap, earningsDate]
    
    /// PieChart: Order to place on sorting for tickers
    static let tickersRawOrder: [PortfolioSortingField] = [purchasedDate, priceChangeForPeriod, percentOFPortfolio, matchScore, name, marketCap, earningsDate, weight]
    
    /// PieChart: Order to place on sorting for categories/interests/classes
    static let othersRawOrder: [PortfolioSortingField] = [name, weight]
}
