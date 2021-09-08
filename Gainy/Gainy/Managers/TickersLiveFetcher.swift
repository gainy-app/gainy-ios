//
//  TickersLiveFetcher.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.09.2021.
//

import UIKit
import Apollo

final class TickersLiveFetcher {
    
   static let shared = TickersLiveFetcher()
    
    //MARK: - Inner
 
    //MARK: - Public
    
    func getSymbolsData(_ symbols: [String], _ completion: @escaping (() -> Void)){
        //Getting only not laoded symbols
        let onleNewSymbols = Array(TickerLiveStorage.shared.missingSymbolsFrom(symbols).prefix(20))
        Network.shared.apollo.fetch(query: FetchLiveTickersDataQuery(symbols: onleNewSymbols)) { result in
            switch result {
            case .success(let graphQLResult):
                for data in (graphQLResult.data?.fetchLivePrices ?? []) {
                    if let data = data {
                        TickerLiveStorage.shared.setSymbolData(data.symbol ?? "", data: data)
                    }
                }
                completion()
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                completion()
            }
        }
    }
}
