//
//  WrongIndustryManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 11.02.2022.
//

import Foundation
import GainyCommon

final class WrongIndustryManager {
    
    static let shared = WrongIndustryManager()
    
    @UserDefault<Set<String>>("WrongIndustries")
    private var wrongSymbols: Set<String>?
    
    
    func isIndWrong(_ symbol: String) -> Bool {
        wrongSymbols?.contains(symbol) ?? false
    }
    
    func removeFromWrong(_ symbol: String) {
        wrongSymbols?.remove(symbol)
    }
    
    func addToWrong(_ symbol: String) {
        if wrongSymbols == nil {
            wrongSymbols = Set<String>()
        }
        wrongSymbols?.insert(symbol)
    }
}
