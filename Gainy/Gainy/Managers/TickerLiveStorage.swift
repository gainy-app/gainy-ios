//
//  TickerLiveStorage.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.09.2021.
//

import UIKit

final class TickerLiveStorage {
    
    static let shared = TickerLiveStorage()
    
    //MARK: - Inner
    
    typealias LivePrice = FetchLiveTickersDataQuery.Data.FetchLivePrice
    
    @Atomic
    private var tickerLiveData: [String: LivePrice] = [:]
 
    //MARK: - Public
    
    func missingSymbolsFrom(_ fullReq: [String]) -> [String] {
        let storedSet = Set(tickerLiveData.keys)
        let searchSet = Set(fullReq)
        return Array(searchSet.subtracting(storedSet))
    }
    
    func getSymbolData(_ symbol: String) -> LivePrice? {
        tickerLiveData[symbol]
    }
    
    func setSymbolData(_ symbol: String, data: LivePrice) {
        guard !symbol.isEmpty else {return}
        tickerLiveData[symbol] = data
    }
}
