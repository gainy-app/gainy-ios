//
//  TradeTags.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 10.12.2022.
//

import Foundation

public struct TradeTags {
    public enum TypeKey: String, CaseIterable {
        case deposit, withdraw, fee, buy, sell, ttf, ticker
        
        public static var actions: [Self] {
            [.deposit, .withdraw, .fee, .buy, .sell]
        }
    }
    
    public enum StateKey: String, CaseIterable {
        case pending, error, cancelled, pendingExecution = "Pending Execution"
    }
}
