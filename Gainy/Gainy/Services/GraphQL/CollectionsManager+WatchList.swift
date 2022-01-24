//
//  CollectionsManager+MatchScore.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.01.2022.
//

import UIKit


extension CollectionsManager {
     
    func loadWatchlistCollection() async -> RemoteCollectionDetails? {
        return await
        withCheckedContinuation { continuation in
            guard UserProfileManager.shared.watchlist.count > 0 else {
                
                if let collectionRemoteDetails = CollectionsManager.shared.watchlistCollection {
                    let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(collectionRemoteDetails)
                    self.newCollectionFetched.send(.deleted(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                    CollectionsManager.shared.watchlistCollection = nil
                }
                continuation.resume(returning: nil)
                return
            }
            
            Network.shared.apollo.fetch(query: FetchTickersQuery.init(symbols: UserProfileManager.shared.watchlist)) { [weak self] result in
                switch result {
                case .success(let graphQLResult):
                    guard let tickers = graphQLResult.data?.tickers else {
                        continuation.resume(returning: nil)
                        return
                    }
                    
                    for tickLivePrice in tickers.compactMap({$0.fragments.remoteTickerDetails.realtimeMetrics}) {
                        TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                    }
                    
                    for tickMatch in tickers.compactMap({$0.fragments.remoteTickerDetails.matchScore}) {
                        TickerLiveStorage.shared.setMatchData(tickMatch.symbol ?? "", data: tickMatch)
                    }
                    
                    self?.prefetchedCollectionsData[Constants.CollectionDetails.watchlistCollectionID] = tickers.compactMap({CollectionDetailsDTOMapper.mapTickerDetails($0.fragments.remoteTickerDetails)})
                    let collectionRemoteDetails = RemoteCollectionDetails.init(id: Constants.CollectionDetails.watchlistCollectionID,
                                                                               name: "Watchlist",
                                                                               imageUrl: "watchlistCollectionBackgroundImage",
                                                                               description: "",
                                                                               size: UserProfileManager.shared.watchlist.count)
                    continuation.resume(returning: collectionRemoteDetails)
                    
                case .failure(let error):
                    continuation.resume(returning: nil)
                    dprint("Failure when making GraphQL request. Error: \(error)")
                }
            }
        }
    }
    
    func loadWatchlistCollection(completion: @escaping () -> Void) {
        
        guard UserProfileManager.shared.watchlist.count > 0 else {
            
            if let collectionRemoteDetails = CollectionsManager.shared.watchlistCollection {
                let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(collectionRemoteDetails)
                self.newCollectionFetched.send(.deleted(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                CollectionsManager.shared.watchlistCollection = nil
            }
            completion()
            return
        }
        
        Network.shared.apollo.fetch(query: FetchTickersQuery.init(symbols: UserProfileManager.shared.watchlist)) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let tickers = graphQLResult.data?.tickers else {
                    completion()
                    return
                }
                //TO-DO: What to do with Tickers!!!
                
                if let collectionRemoteDetails = CollectionsManager.shared.watchlistCollection {
                    let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(collectionRemoteDetails)
                    self?.newCollectionFetched.send(.deleted(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                    CollectionsManager.shared.watchlistCollection = nil
                }
                
                let collectionRemoteDetails = RemoteCollectionDetails.init(id: Constants.CollectionDetails.watchlistCollectionID,
                                                                           name: "Watchlist",
                                                                           imageUrl: "watchlistCollectionBackgroundImage",
                                                                           description: "",
                                                                           size: UserProfileManager.shared.watchlist.count)
                CollectionsManager.shared.watchlistCollection = collectionRemoteDetails
                
                let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(collectionRemoteDetails)
                self?.newCollectionFetched.send(.fetched(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                completion()
                
            case .failure(let error):
                completion()
                dprint("Failure when making GraphQL request. Error: \(error)")
            }
        }
    }
    
}
