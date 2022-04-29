import Foundation

final class DiscoverCollectionsViewModel: NSObject, DiscoverCollectionsViewModelProtocol {
    var noCollections: [NoCollectionViewModel] = [NoCollectionViewModel()]
    var watchlistCollections: [YourCollectionViewCellModel] = []
    var yourCollections: [YourCollectionViewCellModel] = []
    var recommendedCollections: [RecommendedCollectionViewCellModel] = []
    
    //Temp cache of removed items
    var addedRecs: [Int : RecommendedCollectionViewCellModel] = [:]
    
    //MARK: - Gainers
    var topGainers: [RemoteTicker] = []
    var topLosers: [RemoteTicker] = []
    
    struct TopTickers {
        var topGainers: [RemoteTicker] = []
        var topLosers: [RemoteTicker] = []
    }
    
    internal func getGainers(profileId: Int) async -> TopTickers {
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: HomeFetchGainersQuery.init(profileId: profileId)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let gainersList = graphQLResult.data?.profileCollectionTickersPerformanceRanked  else {
                        dprint("GetFavoriteCollectionsQuery empty \(graphQLResult)")
                        continuation.resume(returning: TopTickers())
                        return
                    }
                    let gainersTopSymbols = Array(gainersList.sorted(by: {($0.gainerRank ?? 0) < ($1.gainerRank ?? 0)}).prefix(10)).compactMap({$0.symbol})
                    let losersTopSymbols = Array(gainersList.sorted(by: {($0.gainerRank ?? 0) > ($1.gainerRank ?? 0)}).prefix(10)).compactMap({$0.symbol})
                    
                    Task {
                        async let gainers = self.getStocks(symbols: gainersTopSymbols)
                        async let losers = self.getStocks(symbols: losersTopSymbols)
                        let (gainersList, losersList) = await (gainers, losers)
                        continuation.resume(returning: TopTickers(topGainers: gainersList.reorder(by: gainersTopSymbols), topLosers: losersList.reorder(by: losersTopSymbols)))
                    }
                    
                    break
                case .failure(let error):
                    dprint("Failure when making GetFavoriteCollectionsQuery request. Error: \(error)")
                    continuation.resume(returning: TopTickers())
                    break
                }
            }
        }
    }
    
    internal func getStocks(symbols: [String]) async -> [RemoteTicker] {
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: FetchTickersQuery.init(symbols: symbols)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let tickers = graphQLResult.data?.tickers.compactMap({$0.fragments.remoteTickerDetails}) else {
                        continuation.resume(returning: [RemoteTicker]())
                        return
                    }
                    
                    for tickLivePrice in tickers.compactMap({$0.realtimeMetrics}) {
                        TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                    }
                    
                    for tickMatch in tickers.compactMap({$0.matchScore}) {
                        TickerLiveStorage.shared.setMatchData(tickMatch.symbol, data: tickMatch)
                    }
                    
                    continuation.resume(returning: tickers)
                    break
                case .failure(let error):
                    dprint("Failure when making FetchTickersQuery request. Error: \(error)")
                    continuation.resume(returning: [RemoteTicker]())
                    break
                }
            }
        }
    }

}
