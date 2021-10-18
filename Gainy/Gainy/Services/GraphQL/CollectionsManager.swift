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
        case fetchedFailed
    }
    
    var collections: [RemoteCollectionDetails] = []
    
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
    @Atomic
    var isFetching: Bool = false
        
    func loadNewCollectionDetails(_ colID: Int) {
        Network.shared.apollo.fetch(query: FetchSelectedCollectionsQuery.init(ids: [colID])) {[unowned self] result in
            switch result {
            case .success(let graphQLResult):
                guard let collections = graphQLResult.data?.collections.compactMap({$0.fragments.remoteCollectionDetails}) else {
                    return
                }
                for newCol in collections {
                    TickersLiveFetcher.shared.getMatchScores(collectionIds: [colID]) {
                        
                        self.collections.append(newCol)                        
                        
                        let collectionDTO = CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections(newCol)
                        newCollectionFetched.send(.fetched(model: CollectionDetailsViewModelMapper.map(collectionDTO)))
                        
                        if self.failedToLoad.contains(colID) {
                            self.failedToLoad.remove(colID)
                        }
                    }
                }
                
            case .failure(_):
                self.failedToLoad.insert(colID)
                newCollectionFetched.send(.fetchedFailed)
                break
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
