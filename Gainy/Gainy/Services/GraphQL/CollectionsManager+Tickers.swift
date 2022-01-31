//
//  CollectionsManager+Tickers.swift
//  Gainy
//
//  Created by Serhii Borysov on 1/17/22.
//

import UIKit

extension CollectionsManager {
    
    typealias TickerModels = [Int: [TickerDetails]]
    func getTickersForCollections(collectionIDs: [Int]) async -> TickerModels {
        await withTaskGroup(
            of: (Int, [TickerDetails]).self,
            returning: TickerModels.self
        ) { [self] group in
            for collectionID in collectionIDs {
                group.addTask {
                    await (collectionID, getTickersForCollection(collectionID: collectionID, offset: 0))
                }
            }

            var models: TickerModels = [:]
            for await result in group {
                models[result.0] = result.1
            }

            return models
        }
    }
    
    func getTickersForCollection(collectionID id: Int, offset: Int) async -> [TickerDetails] {
        
        var resultModel: [TickerDetails] = []
        let settings: CollectionSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(id)
        
        let tickerMetricsOrder = CollectionsDetailsSettingsManager.shared.tickerMetricsOrderForMarketData(filed: settings.sorting, ascending: settings.ascending)
        
        
        let tickersOrder = tickers_order_by.init(tickerMetrics: tickerMetricsOrder)
        let orderBy = ticker_collections_order_by.init(ticker: tickersOrder)
        let extraOrder = ticker_collections_order_by.init(ticker: tickers_order_by.init(name: order_by.asc))
        
        let query = GetTickersForCollectionQuery.init(collectionId: id, offset: offset, orderBy: [orderBy, extraOrder])
        let msQuery = GetTickersByMsForCollectionQuery.init(collectionId: id, offset: offset, orderBy: settings.ascending ? order_by.ascNullsFirst : order_by.descNullsLast)
        
        return await
        withCheckedContinuation { continuation in
            if settings.sorting == .matchScore {
            Network.shared.apollo.fetch(query: msQuery){ result in
                switch result {
                case .success(let graphQLResult):
                    
                    guard let collections = graphQLResult.data?.tickerCollections else {
                        continuation.resume(returning: resultModel)
                        return
                    }
                    
                    for tickLivePrice in collections.compactMap({$0.ticker?.fragments.remoteTickerDetails.realtimeMetrics}).compactMap({$0}) {
                        TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                    }
                    let matchesList = collections.compactMap({$0.ticker?.fragments.remoteTickerDetails.matchScore}).compactMap({$0})
                    for tickMatch in matchesList {
                        TickerLiveStorage.shared.setMatchData(tickMatch.symbol, data: tickMatch)
                    }
                    
                    for collection in collections {
                        guard let ticker = collection.ticker else {
                            continuation.resume(returning: resultModel)
                            return
                        }
                        let tickerDetails: TickerDetails = CollectionDetailsDTOMapper.mapTickerDetails(ticker.fragments.remoteTickerDetails)
                        resultModel.append(tickerDetails)
                    }
                    
                    continuation.resume(returning: resultModel)
                    break
                case .failure(let error):
                    continuation.resume(returning: resultModel)
                    break
                }
            }
            } else {
                Network.shared.apollo.fetch(query: query){ result in
                    switch result {
                    case .success(let graphQLResult):
                        
                        guard let collections = graphQLResult.data?.tickerCollections else {
                            continuation.resume(returning: resultModel)
                            return
                        }
                        
                        for tickLivePrice in collections.compactMap({$0.ticker?.fragments.remoteTickerDetails.realtimeMetrics}).compactMap({$0}) {
                            TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                        }
                        for tickMatch in collections.compactMap({$0.ticker?.fragments.remoteTickerDetails.matchScore}).compactMap({$0}) {
                            TickerLiveStorage.shared.setMatchData(tickMatch.symbol, data: tickMatch)
                        }
                        
                        for collection in collections {
                            guard let ticker = collection.ticker else {
                                continuation.resume(returning: resultModel)
                                return
                            }
                            let tickerDetails: TickerDetails = CollectionDetailsDTOMapper.mapTickerDetails(ticker.fragments.remoteTickerDetails)
                            resultModel.append(tickerDetails)
                        }
                        
                        continuation.resume(returning: resultModel)
                        break
                    case .failure(let error):
                        continuation.resume(returning: resultModel)
                        break
                    }
                }
            }
        }
    }
}
