//
//  HoldingsViewModel+Collections.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.07.2022.
//

import UIKit

//extension RemoteCollectionDetails {
//    
//}

extension HoldingsViewModel {
    
    struct CollectionInfo {
        let symbol: String
        let details: RemoteCollectionDetails
    }
    
    private func getLinkedCollection(for symbol: String) async -> CollectionInfo? {
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetTickerLinkedCollectionQuery(symbol: symbol)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let collection = graphQLResult.data?.tickers.first?.tickerCollections.first?.collection?.fragments.remoteCollectionDetails else {
                        continuation.resume(returning: nil)
                        return
                    }
                    
                    continuation.resume(returning: CollectionInfo(symbol: symbol,
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
    
    private func getLinkedCollections(for symbols: [String]) async -> [CollectionInfo] {
        return await withTaskGroup(of: CollectionInfo?.self) { group in
            
            var collections = [CollectionInfo?]()
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
}
