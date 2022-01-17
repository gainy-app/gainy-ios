//
//  CollectionsManager+MatchScore.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.01.2022.
//

import UIKit


extension CollectionsManager {
    
    func loadInitialMatchScores(_ completion: @escaping (() -> Void)) {
        
        let group = DispatchGroup()
        
        let wListSymbols = UserProfileManager.shared.watchlist
        if !wListSymbols.isEmpty {
            //Loading WatchList
            group.enter()
            TickersLiveFetcher.shared.getSymbolsData(wListSymbols) {
                var wData = [(String, Int)]()
                
                for symbol in wListSymbols {
                    wData.append((symbol, TickerLiveStorage.shared.getMatchData(symbol)?.matchScore ?? 0))
                }
                TickerLiveStorage.shared.collectionsMatchScores[Constants.CollectionDetails.watchlistCollectionID] = wData
                dprint("REQ TRACK Loaded WLIST MS")
                group.leave()
            }
        }
        
        //Load Fav Matches
        let favColls = UserProfileManager.shared.favoriteCollections
        if !favColls.isEmpty {
            group.enter()
            TickersLiveFetcher.shared.getMatchScores(collectionIds: favColls) { scores in
                for scoreKey in scores.keys {
                    TickerLiveStorage.shared.collectionsMatchScores[scoreKey] = scores[scoreKey]
                }
                dprint("REQ TRACK Loaded FAVS MS")
                group.leave()
            }
        }
        
        group.notify(queue: .main, execute: {
            completion()
        })
    }
    
}
