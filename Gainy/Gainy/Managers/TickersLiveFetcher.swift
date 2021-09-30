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
    
    @Atomic
    private var currentlyFetching: Set<String> = []
    
    //MARK: - Public
    
    func getSymbolsData(_ symbols: [String], _ completion: @escaping (() -> Void)){
        guard symbols.count > 0 else {return completion()}
        //Getting only not laoded symbols
        let batchSymbols = TickerLiveStorage.shared.missingSymbolsFrom(symbols, inProgress: currentlyFetching).chunked(into: 100)
        
        if batchSymbols.count > 0 {
            
            let group = DispatchGroup.init()
            
            for batch in batchSymbols {
                print("Fetching \(batch.joined(separator: ","))")
                batch.forEach({
                    currentlyFetching.insert($0)
                })
                if batch.count > 0 {
                    group.enter()
                    Network.shared.apollo.fetch(query: FetchLiveTickersDataQuery(symbols: batch)) { result in
                        switch result {
                        case .success(let graphQLResult):
                            for data in (graphQLResult.data?.fetchLivePrices ?? []) {
                                if let data = data {
                                    TickerLiveStorage.shared.setSymbolData(data.symbol ?? "", data: data)
                                    self.currentlyFetching.remove(data.symbol ?? "")
                                }
                            }
                            group.leave()
                        case .failure(let error):
                            print("Failure when making GraphQL request. Error: \(error)")
                            group.leave()
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        completion()
                    })
                }
            }
            group.notify(queue: DispatchQueue(label: "TickersLiveFetcher")) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    completion()
                })
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                completion()
            })
        }
    }
    
    /// Loading match score for collection
    /// - Parameters:
    ///   - profileId: User Profile ID
    ///   - collectionId: Collection ID
    ///   - completion: callback for loading end action
    func getMatchScores(collectionId: Int, _ completion: @escaping (() -> Void)) {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            print("Missing profileID")
            completion()
            return
        }
        
        Network.shared.apollo.fetch(query: FetchTickersMatchDataQuery(profileId: profileID, collectionId: collectionId)) { result in
            switch result {
            case .success(let graphQLResult):
                for data in (graphQLResult.data?.getMatchScoresByCollection?.compactMap({$0?.fragments.liveMatch}) ?? []) {
                    TickerLiveStorage.shared.setMatchData(data.symbol, data: data)                    
                }
                completion()
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                completion()
            }
        }
    }
}
