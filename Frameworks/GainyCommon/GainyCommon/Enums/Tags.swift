//
//  Tags.swift
//  GainyCommon
//
//  Created by r10 on 23.01.2023.
//

import Foundation

public enum Tags: String, Equatable, Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
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
