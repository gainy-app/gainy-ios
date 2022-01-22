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
    
    @UserDefault("lastLoadDate")
    var lastLoadDate: Date?
    
    var collections: [RemoteCollectionDetails] = []
    var watchlistCollection: RemoteCollectionDetails?
    
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
    
    func loadNewCollectionDetails(_ colID: Int, completion: @escaping () -> Void) {
        Task {
            async let newCols = loadCollections([colID])
            async let tickersMap = getTickersForCollections(collectionIDs: [colID])
            let (newColsRes, tickersMapRes) = await (newCols, tickersMap)
            
            //Adding preloaded tickers
            
            for colID in tickersMapRes.keys {
                print("Got \((tickersMapRes[colID] ?? []).count) tickers for \(colID)")
                prefetchedCollectionsData[colID] = tickersMapRes[colID] ?? []
            }
            
            if newColsRes.isEmpty {
                self.failedToLoad.insert(colID)
                newCollectionFetched.send(.fetchedFailed)
                await MainActor.run {
                    completion()
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
                completion()
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
                print("Got \((tickersMapRes[colID] ?? []).count) tickers for \(colID)")
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
        loadNewCollectionDetails(Constants.CollectionDetails.top20ID) {
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
            async let watchList = loadWatchlistCollection()
            let (favsRes, tickersMapRes, watchListRes) = await (favs, tickersMap, watchList)
            
            //Adding preloaded tickers
            for colID in tickersMapRes.keys {
                print("Got \((tickersMapRes[colID] ?? []).count) tickers for \(colID)")
                prefetchedCollectionsData[colID] = tickersMapRes[colID] ?? []
            }
            
            //Favs handler
            if let index = UserProfileManager.shared.favoriteCollections.firstIndex(of: Constants.CollectionDetails.top20ID), UserProfileManager.shared.favoriteCollections.count > 1 {
                UserProfileManager.shared.favoriteCollections.swapAt(index, 0)
            }
            
            CollectionsManager.shared.collections = favsRes.reorder(by: UserProfileManager.shared.favoriteCollections)
            CollectionsManager.shared.lastLoadDate = Date()
            
            //WatchList Handler
            if let watchListRes = watchListRes {
                if let collectionRemoteDetails = CollectionsManager.shared.watchlistCollection {
                    let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(collectionRemoteDetails)
                    newCollectionFetched.send(.deleted(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                    CollectionsManager.shared.watchlistCollection = nil
                }
                
                CollectionsManager.shared.watchlistCollection = watchListRes
                
                let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(watchListRes)
                newCollectionFetched.send(.fetched(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
            }
            
            await MainActor.run {
                completion([])
            }
        }
        
    }
    
    func loadMoreTickersLoading(collectionID id: Int, offset: Int, completion: @escaping ([TickerDetails]) -> Void) {
        
        Task {
            async let tickersMap = getTickersForCollection(collectionID: id, offset: offset)
            let tickersMapRes = await tickersMap
            
            //Adding preloaded tickers
            
            print("Got \((tickersMapRes).count) more tickers for \(id)")
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
                newCollectionFetched.send(.fetched(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
            }
            
            await MainActor.run {
                completion([])
            }
        }
    }
    
    /// Loading JUST Collection details
    /// - Parameter completion: when all done
    fileprivate func loadCollections(_ ids: [Int]) async -> [RemoteCollectionDetails] {
        
        let emptyRes: [RemoteCollectionDetails] = []
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
            loadNewCollectionDetails($0) {
                
            }
        })
    }
}
