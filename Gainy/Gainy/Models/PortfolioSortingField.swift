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
    totalReturn,
    todayReturn,
    percentOFPortfolio,
    matchScore,
    name,
    marketCap,
    earningsDate
    
    var title: String {
        switch self {
        case .purchasedDate:
            return "Purchased date"
        case .totalReturn:
            return "Total Return"
        case .todayReturn:
            return "Today Return"
        case .percentOFPortfolio:
            return "% of portfolio"
        case .matchScore:
            return "Match Score"
        case .name:
            return "Name"
        case .marketCap:
            return "Market cap"
        case .earningsDate:
            return "Earnings Date"
        }
    }
    
    /// Order to place on sorting
    static let rawOrder: [PortfolioSortingField] = [purchasedDate, totalReturn, todayReturn, percentOFPortfolio, matchScore, name, marketCap, earningsDate]
}
