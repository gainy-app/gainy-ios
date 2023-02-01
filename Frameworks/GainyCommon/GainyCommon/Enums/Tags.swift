//
//  Tags.swift
//  GainyCommon
//
//  Created by r10 on 23.01.2023.
//

import Foundation

public enum Tags: String, Equatable, Comparable {
    
    case buy
    case deposit
    case sell
    case ticker
    case withdraw
    case ttf
    case pending
    case pendingExecution
    case cancelled
    case canceled
    case error
    
    private var comparisonValue: Int {
        switch self {
        case .ticker, .ttf:
            return 2
        case .buy, .sell, .deposit, .withdraw:
            return 1
        case .pending, .pendingExecution, .cancelled, .canceled, .error:
            return 0
        }
    }
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.comparisonValue < rhs.comparisonValue
    }
    
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.comparisonValue > rhs.comparisonValue
    }
    
    public var tagColor: String {
        switch self {
        case .buy, .deposit:
            return "#38CF92"
        case .withdraw, .sell:
            return "#F95664"
        case .ttf, .ticker:
            return "6C5DD3"
        case .pending, .pendingExecution, .cancelled, .canceled:
            return "#B1BDC8"
        case .error:
            return "F95664"
        }
    }
}
