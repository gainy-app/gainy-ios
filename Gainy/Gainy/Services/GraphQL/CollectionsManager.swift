//
//  CollectionsManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.10.2021.
//

import UIKit
import Combine
import GainyAPI
import GainyCommon

final class CollectionsManager {
    
    static let shared = CollectionsManager()
    
    //MARK: - Storage
    
    enum FetchResult {
        case fetched(model: CollectionDetailViewCellModel)
        case deleted(model: CollectionDetailViewCellModel)
        case updated(model: CollectionDetailViewCellModel)
        case fetchedFailed
    }
    
    @UserDefault("lastLoadDate")
    var lastLoadDate: Date?
    
    var collections: [RemoteCollectionDetails] = [] {
        didSet {
            print("Hello there")
        }
    }
    var watchlistCollection: RemoteCollectionDetails?
    var topTickers: TopTickers?
    
    internal(set) var prefetchedCollectionsData: [Int : [TickerDetails]] = [:]
    
    var newCollectionFetched: PassthroughSubject<FetchResult, Never> = PassthroughSubject.init()
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
    
    func loadNewCollectionDetails(_ colID: Int, completion: @escaping ([TickerDetails]) -> Void) {
        Network.shared.apollo.clearCache()
        Task {
            async let newCols = loadCollections([colID])
            async let tickersMap = getTickersForCollections(collectionIDs: [colID])
            let (newColsRes, tickersMapRes) = await (newCols, tickersMap)
            
            //Adding preloaded tickers
            for colID in tickersMapRes.keys {
                prefetchedCollectionsData[colID] = tickersMapRes[colID] ?? []
            }
            
            let remoteTickersMap = await tickersMap[colID] ?? []
            if newColsRes.isEmpty {
                if !Constants.CollectionDetails.loadingCellIDs.contains(colID) {
                    self.failedToLoad.insert(colID)
                    newCollectionFetched.send(.fetchedFailed)
                }
                await MainActor.run {
                    completion([])
                }
                return
            }
            
            for newCol in newColsRes {
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
            await MainActor.run {
                completion(remoteTickersMap)
            }
        }
    }
    
    func reloadNewCollectionsDetails(_ colIDs: [Int], completion: @escaping ([RemoteCollectionDetails]) -> Void) {
        Task {
            async let newCols = loadCollections(colIDs)
            async let tickersMap = getTickersForCollections(collectionIDs: colIDs)
            let (newColsRes, tickersMapRes) = await (newCols, tickersMap)
            
            //Adding preloaded tickers
            
            for colID in tickersMapRes.keys {
                prefetchedCollectionsData[colID] = tickersMapRes[colID] ?? []
            }
            
            if newColsRes.isEmpty {
                await MainActor.run {
                    completion([])
                }
                return
            }
            await MainActor.run {
                completion(newColsRes)
            }
        }
    }
    
    func reloadTop20(completion: @escaping () -> Void) {
        guard collections.contains(where: {$0.id == Constants.CollectionDetails.top20ID}) else {
            completion()
            return
        }
        loadNewCollectionDetails(Constants.CollectionDetails.top20ID) {_ in 
            completion()
        }
    }
    
    //MARK: - Speed up Migration
    
    /// This will be our new initla loading
    /// - Parameter completion: when all done
    func initialCollectionsLoading(completion: @escaping ([CollectionDetailViewCellModel]) -> Void) {
        
        Task {
            async let favs = loadCollections(UserProfileManager.shared.favoriteCollections)
            async let tickersMap = getTickersForCollections(collectionIDs: UserProfileManager.shared.favoriteCollections)
            let (favsRes, tickersMapRes) = await (favs, tickersMap)
            
            //Adding preloaded tickers
            for colID in tickersMapRes.keys {
                prefetchedCollectionsData[colID] = tickersMapRes[colID] ?? []
            }
            
            //Favs handler
            if let index = UserProfileManager.shared.favoriteCollections.firstIndex(of: Constants.CollectionDetails.top20ID), UserProfileManager.shared.favoriteCollections.count > 1 {
                UserProfileManager.shared.favoriteCollections.swapAt(index, 0)
            }
            
            CollectionsManager.shared.collections = favsRes.uniqued().reorder(by: UserProfileManager.shared.favoriteCollections)
            CollectionsManager.shared.lastLoadDate = Date()
            
            //WatchList Handler
//            if let watchListRes = watchListRes {
//                if let collectionRemoteDetails = CollectionsManager.shared.watchlistCollection {
//                    let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(collectionRemoteDetails)
//                    newCollectionFetched.send(.deleted(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
//                    CollectionsManager.shared.watchlistCollection = nil
//                }
//                
//                CollectionsManager.shared.watchlistCollection = watchListRes
//                
//                let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(watchListRes)
//                //newCollectionFetched.send(.fetched(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
//            }
            
            await MainActor.run {
                completion([])
            }
        }
        
    }
    
    func loadMoreTickersLoading(collectionID id: Int, offset: Int, completion: @escaping ([TickerDetails]) -> Void) {
        
        Task {
            let tickersMapRes = await getTickersForCollection(collectionID: id, offset: offset)
            
            //Adding preloaded tickers
            print(tickersMapRes.compactMap({$0.tickerSymbol}))
            var curTickers = prefetchedCollectionsData[id]
            curTickers?.append(contentsOf: tickersMapRes)
            prefetchedCollectionsData[id] = curTickers
            
            
            await MainActor.run {
                completion(tickersMapRes)
            }
        }
    }
    
    func watchlistCollectionsLoading(completion: @escaping ([CollectionDetailViewCellModel]) -> Void) {
        
        Task {
            async let watchList = loadWatchlistCollection()
            
            //WatchList Handler
            if let watchListRes = await watchList {
                if let collectionRemoteDetails = CollectionsManager.shared.watchlistCollection {
                    let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(collectionRemoteDetails)
                    newCollectionFetched.send(.deleted(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                    CollectionsManager.shared.watchlistCollection = nil
                }
                
                CollectionsManager.shared.watchlistCollection = watchListRes
                
                let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(watchListRes)
                let collectionDetailsViewCellModel = CollectionDetailsViewModelMapper.map(collectionDTO)
                newCollectionFetched.send(.fetched(model: collectionDetailsViewCellModel))
                
                await MainActor.run {
                    completion([collectionDetailsViewCellModel])
                }
            } else {
                
                await MainActor.run {
                    completion([])
                }
            }
        }
    }
    
    /// Loading JUST Collection details
    /// - Parameter completion: when all done
    fileprivate func loadCollections(_ ids: [Int]) async -> [RemoteCollectionDetails] {
        
        var oSet = Set(ids).subtracting(Set(Constants.CollectionDetails.loadingCellIDs))
        
        let emptyRes: [RemoteCollectionDetails] = []
        
        if oSet.isEmpty {
            return emptyRes
        }
        return await
        withCheckedContinuation { continuation in
            
            Network.shared.apollo.fetch(query: FetchSelectedCollectionsQuery(ids: ids)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let collections = graphQLResult.data?.collections.compactMap({$0.fragments.remoteCollectionDetails}) else {
                        continuation.resume(returning: emptyRes)
                        return
                    }
                    continuation.resume(returning: collections)
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    continuation.resume(returning: emptyRes)
                }
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
            loadNewCollectionDetails($0) { remoteTickers in
                
            }
        })
    }
}
