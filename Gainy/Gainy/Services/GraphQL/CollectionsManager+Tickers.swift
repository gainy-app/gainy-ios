//
//  CollectionsManager+Tickers.swift
//  Gainy
//
//  Created by Serhii Borysov on 1/17/22.
//

import UIKit


extension CollectionsManager {
    
    func getTickersForCollections(collectionIDs: [Int]) async ->  [Int: [CollectionCardViewCellModel]] {
        
        var result: [Int: [CollectionCardViewCellModel]] = [:]
        for collectionID in collectionIDs {
            async let viewModels = self.getTickersForCollection(collectionID: collectionID, offset: 0)
            result[collectionID] = await viewModels
        }
        
        return result
    }
    
    func getTickersForCollection(collectionID id: Int, offset: Int) async -> [CollectionCardViewCellModel] {
        
        var result: [CollectionCardViewCellModel] = []
        return await withCheckedContinuation { continuation in
            
            let settings: CollectionSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(id)
            
            let tickerMetricsOrder = CollectionsDetailsSettingsManager.shared.tickerMetricsOrderForMarketData(filed: settings.sorting, ascending: settings.ascending)
            let tickersOrder = tickers_order_by.init(tickerMetrics: tickerMetricsOrder)
            let orderBy = ticker_collections_order_by.init(ticker: tickersOrder)
            let query = GetTickersForCollectionQuery.init(collectionId: id, offset: offset, orderBy: [orderBy])
            
            Network.shared.apollo.fetch(query: query){ result in
                switch result {
                case .success(let graphQLResult):
                    
                    
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    
                    break
                }
            }
            
            continuation.resume(returning: result)
        }
    }
}
