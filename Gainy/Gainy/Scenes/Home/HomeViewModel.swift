//
//  HomeViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import Combine

final class HomeViewModel {
    
    internal init() {
        initSource()
    }
    
    private func initSource() {
        self.dataSource = HomeDataSource(viewModel: self)
        
        cancellable = Timer.publish(every: 60, on: .main, in: .default)
                .autoconnect()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {_  in
                    
                }, receiveValue: {[weak self]_  in
                    guard let self = self else {return}
                    Task {
                        let indexes = await self.getStocks(symbols: self.indexSymbols)
                        self.topIndexes = indexes.reorder(by: self.indexSymbols).compactMap({
                            HomeIndexViewModel.init(name: $0.name ?? "",
                                                    grow: $0.realtimeMetrics?.relativeDailyChange ?? 0.0,
                                                    value: $0.realtimeMetrics?.actualPrice ?? 0.0)
                        })
                        
                        await MainActor.run {
                            print("Indexes updated \(Date())")
                            self.dataSource.updateIndexes(models: self.topIndexes)
                        }
                    }
                })
    }
    
    private(set) var dataSource: HomeDataSource!
    
    deinit {
        cancellable?.cancel()
    }
    
    //MARK: - Indexes
    private var cancellable: Cancellable?
    private let indexSymbols = ["ATVI", "AAPL", "AMZN", "NFLX"]
    var topIndexes: [HomeIndexViewModel] = []
    
    //MARK: - Collections
    var favCollections: [RemoteShortCollectionDetails] = []
    
    //MARK: - Gainers
    var topGainers: [RemoteTicker] = []
    var topLosers: [RemoteTicker] = []
    
    //MARK: - Loading
    
    func loadHomeData(_ completion: @escaping (() -> Void)) {
        
        guard let profielId = UserProfileManager.shared.profileID else {
            completion()
            return
        }
        Task {
            self.favCollections = await UserProfileManager.shared.getFavCollections()
            
            let gainers = await getGainers(profileId: profielId)
            
            self.topGainers = gainers.topGainers
            self.topLosers = gainers.topLosers
            
            let indexes = await getStocks(symbols: indexSymbols)
            topIndexes = indexes.reorder(by: indexSymbols).compactMap({
                HomeIndexViewModel.init(name: $0.name ?? "",
                                        grow: $0.realtimeMetrics?.relativeDailyChange ?? 0.0,
                                        value: $0.realtimeMetrics?.actualPrice ?? 0.0)
            })
            
            await MainActor.run {
                completion()
            }
        }
    }
    
    struct TopTickers {
        var topGainers: [RemoteTicker] = []
        var topLosers: [RemoteTicker] = []
    }
    
    func getGainers(profileId: Int) async -> TopTickers {
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
    
    func getStocks(symbols: [String]) async -> [RemoteTicker] {
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
