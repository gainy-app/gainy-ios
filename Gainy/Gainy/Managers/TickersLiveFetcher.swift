//
//  TickersLiveFetcher.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.09.2021.
//

import UIKit
import Apollo

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

final class TickersLiveFetcher {
    
   static let shared = TickersLiveFetcher()
    
    //MARK: - Inner
 
    //MARK: - Public
    
    func getSymbolsData(_ symbols: [String], _ completion: @escaping (() -> Void)){
        //Getting only not laoded symbols
        let batchSymbols = TickerLiveStorage.shared.missingSymbolsFrom(symbols).chunked(into: 100)
        
        let group = DispatchGroup.init()
        
        for batch in batchSymbols {
            group.enter()
            Network.shared.apollo.fetch(query: FetchLiveTickersDataQuery(symbols: batch)) { result in
                switch result {
                case .success(let graphQLResult):
                    for data in (graphQLResult.data?.fetchLivePrices ?? []) {
                        if let data = data {
                            TickerLiveStorage.shared.setSymbolData(data.symbol ?? "", data: data)
                        }
                    }
                    group.leave()
                case .failure(let error):
                    print("Failure when making GraphQL request. Error: \(error)")
                    group.leave()
                }
            }
        }
        group.notify(queue: DispatchQueue(label: "TickersLiveFetcher")) {
            DispatchQueue.main.async {
                completion()
            }
        }        
    }
}
