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
    earningsDate
    
    var title: String {
        switch self {
        case .purchasedDate:
            return "Purchased Date"
        case .priceChangeForPeriod:
            return "Price Change For Period"
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
        }
    }
    
    /// Order to place on sorting
    static let rawOrder: [PortfolioSortingField] = [purchasedDate, priceChangeForPeriod, percentOFPortfolio, matchScore, name, marketCap, earningsDate]
}
