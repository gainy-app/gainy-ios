//
//  CollectionsManager+Tickers.swift
//  Gainy
//
//  Created by Serhii Borysov on 1/17/22.
//

import UIKit


extension CollectionsManager {
    
    func getTickersForCollections(collectionIDs: [Int], completion: @escaping ([Int: [CollectionCardViewCellModel]]) -> Void)  {
        
        var result: [Int: [CollectionCardViewCellModel]] = [:]
        let group = DispatchGroup()
        
        for collectionID in collectionIDs {
            group.enter()
            self.getTickersForCollection(collectionID: collectionID, offset: 0) { viewModels in
                result[collectionID] = viewModels
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.global()) {
            completion(result)
        }
    }
    
    func getTickersForCollection(collectionID id: Int, offset: Int, completion: @escaping ([CollectionCardViewCellModel]) -> Void) {
        
        var resultModel: [CollectionCardViewCellModel] = []
        let settings: CollectionSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(id)
        
        let tickerMetricsOrder = CollectionsDetailsSettingsManager.shared.tickerMetricsOrderForMarketData(filed: settings.sorting, ascending: settings.ascending)
        let tickersOrder = tickers_order_by.init(tickerMetrics: tickerMetricsOrder)
        let orderBy = ticker_collections_order_by.init(ticker: tickersOrder)
        let query = GetTickersForCollectionQuery.init(collectionId: id, offset: offset, orderBy: [orderBy])
        
        Network.shared.apollo.fetch(query: query){ result in
            switch result {
            case .success(let graphQLResult):
                
                guard let collections = graphQLResult.data?.tickerCollections else {
                    completion(resultModel)
                    return
                }
                
                for tickLivePrice in collections.compactMap({$0.ticker?.fragments.remoteTickerDetails.realtimeMetrics}).compactMap({$0}) {
                    TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                }
                
                for tickLivePrice in collections.compactMap({$0.ticker?.fragments.remoteTickerDetails.matchScore}).compactMap({$0}) {
                    TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                }
                
                for collection in collections {
                    guard let ticker = collection.ticker else {
                        completion(resultModel)
                        return
                    }
                    let tickerDetails: TickerDetails = CollectionDetailsDTOMapper.mapTickerDetails(ticker.fragments.remoteTickerDetails)
                    let tickerModel = CollectionDetailsViewModelMapper.map(tickerDetails)
                    resultModel.append(tickerModel)
                }
                
                completion(resultModel)
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion(resultModel)
                break
            }
        }
    }
}
