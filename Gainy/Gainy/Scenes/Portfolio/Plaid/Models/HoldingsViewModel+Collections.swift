//
//  HoldingsViewModel+Collections.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.07.2022.
//

import UIKit
import GainyAPI
import GainyCommon

//extension RemoteCollectionDetails {
//    
//}

extension HoldingsViewModel {
    
    struct CollectionDetailsInfo {
        let symbol: String
        let details: RemoteCollectionDetails
    }
    
    struct CollectionTagsInfo {
        let uniqID: String
        let tags: [TickerTag]
    }
    
    private func getLinkedCollection(for symbol: String) async -> CollectionDetailsInfo? {
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetTickerLinkedCollectionQuery(symbol: symbol)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let collection = graphQLResult.data?.tickers.first?.tickerCollections.first?.collection?.fragments.remoteCollectionDetails else {
                        continuation.resume(returning: nil)
                        return
                    }
                    
                    continuation.resume(returning: CollectionDetailsInfo(symbol: symbol,
                                                                         details: collection))
                    break
                case .failure(let error):
                    dprint("Failure when making GetTickerLinkedCollectionQuery request. Error: \(error)")
                    continuation.resume(returning: nil)
                    break
                }
            }
        }
    }
    
    private func getLinkedCollections(for symbols: [String]) async -> [CollectionDetailsInfo] {
        return await withTaskGroup(of: CollectionDetailsInfo?.self) { group in
            
            var collections = [CollectionDetailsInfo?]()
            collections.reserveCapacity(symbols.count)
            
            // adding tasks to the group and fetching collections
            for id in symbols {
                group.addTask {
                    return await self.getLinkedCollection(for: id)
                }
            }
            
            for await coll in group {
                collections.append(coll)
            }
            
            return collections.compactMap({$0})
        }
    }
    
    
    private func loadRecTags(uniqID: String) async -> CollectionTagsInfo? {
        return await
        withCheckedContinuation { continuation in
            guard let profileID = UserProfileManager.shared.profileID else {
                continuation.resume(returning: nil)
                return
            }
            Network.shared.apollo.fetch(query: GetTtfTagsQuery(uniqID: uniqID, profileId: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    var tags = [TickerTag]()
                    
                    for expl in graphQLResult.data?.collectionMatchScoreExplanation ?? [] {
                        if let interest = expl.interest {
                            tags.append(TickerTag(name: (interest.name ?? ""), url: interest.iconUrl ?? "", collectionID: -404, id: interest.id ))
                        }
                        if let category = expl.category {
                            tags.append(TickerTag(name: (category.name ?? ""), url: category.iconUrl ?? "", collectionID: category.collectionId ?? -404, id: category.id ))
                        }
                    }
                    continuation.resume(returning: CollectionTagsInfo.init(uniqID: uniqID, tags: tags.uniqued()))
                    break
                case .failure(let error):
                    dprint("Failure when making GetTtfTagsQuery request. Error: \(error)")
                    continuation.resume(returning: nil)
                    break
                }
            }
        }
    }
    
    private func getLinkedCollectionTags(for uniqIDs: [String]) async -> [CollectionTagsInfo] {
        return await withTaskGroup(of: CollectionTagsInfo?.self) { group in
            
            var collections = [CollectionTagsInfo?]()
            collections.reserveCapacity(uniqIDs.count)
            
            // adding tasks to the group and fetching collections
            for id in uniqIDs {
                group.addTask {
                    return await self.loadRecTags(uniqID: id)
                }
            }
            
            for await coll in group {
                collections.append(coll)
            }
            
            return collections.compactMap({$0})
        }
    }
    
    
    struct CollectionDetailsTagsInfo {
        let symbol: String
        let details: RemoteCollectionDetails
        
        let uniqID: String
        let tags: [TickerTag]
    }
    
    
    /// Get list of collection - tags for symbols
    /// - Parameter symbols: Ticker symbols to search
    /// - Returns: Ticker collection data array
    internal func getTickersCollectionData(for symbols: [String]) async -> [CollectionDetailsTagsInfo] {
        //Getting collections
        let collections = await getLinkedCollections(for: symbols)
        
        //Getting tags
        //let tags = await getLinkedCollectionTags(for: collections.compactMap({$0.details.uniqId}))
        
        var info: [CollectionDetailsTagsInfo] = []
        for symbol in symbols {
            
            if let collectionInfo = collections.first(where: {$0.symbol == symbol}) {
                    info.append(CollectionDetailsTagsInfo.init(symbol: symbol,
                                                               details: collectionInfo.details,
                                                               uniqID: "tagsInfo.uniqID",
                                                               tags: []))
                }
        }
        return info
    }
}
