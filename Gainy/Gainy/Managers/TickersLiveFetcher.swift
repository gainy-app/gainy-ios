//
//  TickersLiveFetcher.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.09.2021.
//

import UIKit
import Apollo

typealias CollectionsScores = [Int : [(symbol: String, score: Int)]]

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
        let batchSymbols = TickerLiveStorage.shared.missingSymbolsFrom(symbols, inProgress: currentlyFetching).chunked(into: 50)
        if batchSymbols.count > 0 {
            
            let group = DispatchGroup.init()
            
            for batch in batchSymbols {
                dprint("Fetching \(batch.joined(separator: ","))")
                currentlyFetching = currentlyFetching.union(Set.init(batch))
                
                if batch.count > 0 {
                    group.enter()
                    Network.shared.apollo.fetch(query: FetchLiveTickersDataQuery(symbols: batch)) { result in
                        switch result {
                        case .success(let graphQLResult):
                            dprint("LiveData returned: \((graphQLResult.data?.tickers ?? []).compactMap{$0.symbol}.joined(separator: ", "))")
                            for data in (graphQLResult.data?.tickers.compactMap(\.realtimeMetrics) ?? []) {
                                TickerLiveStorage.shared.setSymbolData(data.symbol ?? "", data: data)
                                self.currentlyFetching.remove(data.symbol ?? "")
                            }
                            group.leave()
                        case .failure(let error):
                            dprint("Failure when making GraphQL request. Error: \(error)")
                            group.leave()
                        }
                    }
                } else {
                    dprint("Small batch")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        completion()
                    })
                }
            }
            group.notify(queue: DispatchQueue(label: "TickersLiveFetcher")) {
                dprint("All batched done")
                
                if !self.currentlyFetching.isEmpty {
                    dprint("Left after get: \(self.currentlyFetching.joined(separator: ", "))")
                    for unfetched in self.currentlyFetching {
                        TickerLiveStorage.shared.setSymbolData(unfetched, data: LivePrice(absoluteDailyChange: 0.0, actualPrice: 0.0, dailyVolume: 0.0, relativeDailyChange: 0.0, symbol: unfetched, time: ""))
                    }
                    self.currentlyFetching.removeAll()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    completion()
                })
            }
        } else {
            dprint("Nothing to fetch")
            dprint("Left: \(Array(currentlyFetching))")
            if !currentlyFetching.isEmpty {
                Network.shared.apollo.fetch(query: FetchLiveTickersDataQuery(symbols: Array(currentlyFetching))) { result in
                    switch result {
                    case .success(let graphQLResult):
                        dprint("LiveData returned: \((graphQLResult.data?.tickers ?? []).compactMap{$0.symbol}.joined(separator: ", "))")
                        for data in (graphQLResult.data?.tickers.compactMap(\.realtimeMetrics) ?? []) {                            
                            TickerLiveStorage.shared.setSymbolData(data.symbol ?? "", data: data)
                            self.currentlyFetching.remove(data.symbol ?? "")
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                            completion()
                        })
                    case .failure(let error):
                        dprint("Failure when making GraphQL request. Error: \(error)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                            completion()
                        })
                    }
                }
            } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                completion()
            })
            }
        }
    }
    
    /// Loading match score for collection
    /// - Parameters:
    ///   - profileId: User Profile ID
    ///   - collectionId: Collection ID
    ///   - completion: callback for loading end action
    func getMatchScores(collectionId: Int, _ completion: @escaping (() -> Void)) {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            dprint("Missing profileID")
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
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion()
            }
        }
    }
    
    func getMatchScores(symbols: [String], _ completion: @escaping (() -> Void)) {        
        guard let profileID = UserProfileManager.shared.profileID else {
            dprint("Missing profileID")
            completion()
            return
        }
        
        Network.shared.apollo.fetch(query: GetMatchScoreForTickersQuery.init(profileId: profileID, symbols: symbols)) { result in
            switch result {
            case .success(let graphQLResult):
                for data in (graphQLResult.data?.getMatchScoresByTickerList?.compactMap({$0?.fragments.liveMatch}) ?? []) {
                    TickerLiveStorage.shared.setMatchData(data.symbol, data: data)
                }
                completion()
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion()
            }
        }
    }
    
    /// Loading match score for collections
    /// - Parameters:
    ///   - collectionIds: collection IDs to load
    ///   - completion: when loading completed/failed
    func getMatchScores(collectionIds: [Int], _ completion: @escaping ((CollectionsScores) -> Void)) {
        guard let profileID = UserProfileManager.shared.profileID else {
            dprint("Missing profileID")
            completion([:])
            return
        }
        
        var collectionMappings: CollectionsScores = [:]
        
        let group = DispatchGroup()
        for collectionId in collectionIds {
            group.enter()
            dprint("Fetching match started \(collectionId)")
            Network.shared.apollo.fetch(query: FetchTickersMatchDataQuery(profileId: profileID, collectionId: collectionId)) { result in
                switch result {
                case .success(let graphQLResult):
                    var mapData: [(symbol: String, score: Int)] = []
                    for data in (graphQLResult.data?.getMatchScoresByCollection?.compactMap({$0?.fragments.liveMatch}) ?? []) {
                        TickerLiveStorage.shared.setMatchData(data.symbol, data: data)
                        mapData.append((data.symbol, data.matchScore))
                    }
                    collectionMappings[collectionId] = mapData
                    dprint("Fetching match ended \(collectionId)")
                    group.leave()
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    group.leave()
                }
            }
        }
        if collectionIds.count > 0 {
            group.notify(queue: .main, execute: {
                completion(collectionMappings)
            })
        } else {
            completion(collectionMappings)
        }
        
    }
}
