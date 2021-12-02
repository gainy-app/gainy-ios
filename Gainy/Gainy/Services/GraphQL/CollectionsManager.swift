//
//  CollectionsManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.10.2021.
//

import UIKit
import Combine

final class CollectionsManager {
    
    static let shared = CollectionsManager()
    
    //MARK: - Storage
    
    enum FetchResult {
        case fetched(model: CollectionDetailViewCellModel)
        case deleted(model: CollectionDetailViewCellModel)
        case updated(model: CollectionDetailViewCellModel)
        case fetchedFailed
    }
    
    var collections: [RemoteCollectionDetails] = []
    var watchlistCollection: RemoteCollectionDetails?
    
    private var newCollectionFetched: PassthroughSubject<FetchResult, Never> = PassthroughSubject.init()
    var newCollectionsPublisher: AnyPublisher<FetchResult, Never> {
        newCollectionFetched.share().eraseToAnyPublisher()
    }
    
    //MARK: - Manipulation
    
    func convertToModel(_ collections: [RemoteCollectionDetails]) -> [CollectionDetailViewCellModel] {
        let yourCollections = collections.map { CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections($0) }
        return yourCollections
            .map { CollectionDetailsViewModelMapper.map($0) }
    }
    
    //MARK: - Fetching

    func loadNewCollectionDetails(_ colID: Int) {
        Network.shared.apollo.fetch(query: FetchSelectedCollectionsQuery.init(ids: [colID])) {[unowned self] result in
            switch result {
            case .success(let graphQLResult):
                guard let collections = graphQLResult.data?.collections.compactMap({$0.fragments.remoteCollectionDetails}) else {
                    return
                }
                for tickLivePrice in collections.compactMap({$0.tickerCollections.compactMap({$0.ticker?.fragments.remoteTickerDetails.realtimeMetrics})}).flatMap({$0}) {
                    TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                }
                
                for newCol in collections {
                    if !self.collections.contains(where: {$0.id == newCol.id}) {
                    self.collections.append(newCol)
                    
                    let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(newCol)
                    newCollectionFetched.send(.fetched(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                    
                    
                    } else {
                        if let index = self.collections.firstIndex(where: {$0.id == newCol.id}) {
                            self.collections[index] = newCol
                            let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(newCol)
                            newCollectionFetched.send(.updated(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                        }
                    }
                    
                    if self.failedToLoad.contains(colID) {
                        self.failedToLoad.remove(colID)
                    }
                }
                
            case .failure(_):
                self.failedToLoad.insert(colID)
                newCollectionFetched.send(.fetchedFailed)
                break
            }
        }
    }
    
    func reloadTop20() {
        guard collections.contains(where: {$0.id == Constants.CollectionDetails.top20ID}) else {return}
        loadNewCollectionDetails(Constants.CollectionDetails.top20ID)
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
                
                let tickerCollection = tickers.map { remoteTicker -> RemoteCollectionDetails.TickerCollection in
                    
                    let ticker = RemoteCollectionDetails.TickerCollection.Ticker.init(unsafeResultMap: remoteTicker.resultMap)
                    return RemoteCollectionDetails.TickerCollection.init(ticker: ticker)
                }
                
                if let collectionRemoteDetails = CollectionsManager.shared.watchlistCollection {
                    let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(collectionRemoteDetails)
                    self?.newCollectionFetched.send(.deleted(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                    CollectionsManager.shared.watchlistCollection = nil
                }
                
                let collectionRemoteDetails = RemoteCollectionDetails.init(id: Constants.CollectionDetails.watchlistCollectionID, name: "Watchlist", imageUrl: "watchlistCollectionBackgroundImage", description: "", tickerCollectionsAggregate: RemoteCollectionDetails.TickerCollectionsAggregate.init(aggregate: RemoteCollectionDetails.TickerCollectionsAggregate.Aggregate.init(count: UserProfileManager.shared.watchlist.count)), tickerCollections: tickerCollection)
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
    
    @Atomic
    private(set) var failedToLoad: Set<Int> = Set<Int>()
    
    var haveUnfetchedItems: Bool {
        failedToLoad.count > 0
    }
    
    func reloadUnfetched() {
        failedToLoad.forEach({
            loadNewCollectionDetails($0)
        })
    }
}
