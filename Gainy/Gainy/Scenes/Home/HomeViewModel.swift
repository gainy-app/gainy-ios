//
//  HomeViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import Combine

typealias WebArticle = HomeFetchArticlesQuery.Data.WebsiteBlogArticle

final class HomeViewModel {
    
    internal init() {
        initSource()
    }
    
    private func initSource() {
        self.dataSource = HomeDataSource(viewModel: self)
        
//        cancellable = Timer.publish(every: 60, on: .main, in: .default)
//            .autoconnect()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: {_  in
//                
//            }, receiveValue: {[weak self]_  in
//                guard let self = self else {return}
//                Task {
//                    let indexes = await self.getRealtimeMetrics(symbols: self.indexSymbols)
//                    
//                    self.topIndexes.removeAll()
//                    
//                    for (ind, val) in self.indexNames.enumerated() {
//                        
//                        if let metric = indexes.first(where: { $0.symbol == self.indexSymbols[ind]}) {
//                            
//                            self.topIndexes.append(HomeIndexViewModel.init(name: val,
//                                                                           grow: metric.relativeDailyChange ?? 0.0,
//                                                                           value: metric.actualPrice ?? 0.0))
//                        } else  {
//                            self.topIndexes.append(HomeIndexViewModel.init(name: val,
//                                                                           grow: 0.0,
//                                                                           value: 0.0))
//                        }
//                    }
//                    
//                    await MainActor.run {
//                        print("Indexes updated \(Date())")
//                        self.dataSource.updateIndexes(models: self.topIndexes)
//                    }
//                }
//            })
    }
    
    private(set) var dataSource: HomeDataSource!
    
    deinit {
        cancellable?.cancel()
    }
    
    //MARK: - Indexes
    private var cancellable: Cancellable?
    private let indexNames = ["Dow Jones", "S&P 500", "Nasdaq", "Bitcoin"]
    private let indexSymbols = ["DJI.INDX", "GSPC.INDX", "IXIC.INDX", "BTC.CC"]
    var topIndexes: [HomeIndexViewModel] = []
    
    //MARK: - Collections
    var favCollections: [RemoteShortCollectionDetails] = []
    
    //MARK: - Gainers
    var topGainers: [RemoteTicker] = []
    var topLosers: [RemoteTicker] = []
    
    //
    var gains: GetPlaidHoldingsQuery.Data.PortfolioGain?
    
    var articles: [WebArticle] = []
    
    //MARK: - Loading
    
    func loadHomeData(_ completion: @escaping (() -> Void)) {
        
        guard let profielId = UserProfileManager.shared.profileID else {
            completion()
            return
        }
        Task {
            self.favCollections = await UserProfileManager.shared.getFavCollections().reorder(by: UserProfileManager.shared.favoriteCollections)
            
            let gainers = await getGainers(profileId: profielId)
            
            self.gains = await getPortfolioGains(profileId: profielId)
            self.articles = await getArticles()
            
            self.topGainers = gainers.topGainers
            self.topLosers = gainers.topLosers
            
            //let indexes = await getRealtimeMetrics(symbols: indexSymbols)
            
            topIndexes.removeAll()
            
//            for (ind, val) in indexNames.enumerated() {
//
//                if let metric = indexes.first(where: { $0.symbol == indexSymbols[ind]}) {
//
//                    topIndexes.append(HomeIndexViewModel.init(name: val,
//                                                              grow: metric.relativeDailyChange ?? 0.0,
//                                                              value: metric.actualPrice ?? 0.0))
//                } else  {
//                    topIndexes.append(HomeIndexViewModel.init(name: val,
//                                                              grow: 0.0,
//                                                              value: 0.0))
//                }
//            }
            await MainActor.run {
                //self.dataSource.updateIndexes(models: self.topIndexes)
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
    
    func getRealtimeMetrics(symbols: [String]) async -> [FetchRealtimeMetricsQuery.Data.TickerRealtimeMetric] {
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: FetchRealtimeMetricsQuery.init(symbols: symbols)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let metrics = graphQLResult.data?.tickerRealtimeMetrics.compactMap({$0}) else {
                        continuation.resume(returning: [FetchRealtimeMetricsQuery.Data.TickerRealtimeMetric]())
                        return
                    }
                    
                    continuation.resume(returning: metrics)
                    break
                case .failure(let error):
                    dprint("Failure when making FetchTickersQuery request. Error: \(error)")
                    continuation.resume(returning: [FetchRealtimeMetricsQuery.Data.TickerRealtimeMetric]())
                    break
                }
            }
        }
    }
    
    func getArticles() async -> [WebArticle] {
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: HomeFetchArticlesQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let articles = graphQLResult.data?.websiteBlogArticles.compactMap({$0}) else {
                        continuation.resume(returning: [WebArticle]())
                        return
                    }
                    
                    continuation.resume(returning: articles)
                    break
                case .failure(let error):
                    dprint("Failure when making HomeFetchArticlesQuery request. Error: \(error)")
                    continuation.resume(returning: [WebArticle]())
                    break
                }
            }
        }
    }
    
    func getPortfolioGains(profileId: Int) async -> GetPlaidHoldingsQuery.Data.PortfolioGain? {
        return await
        withCheckedContinuation { continuation in
            
            Network.shared.apollo.fetch(query: GetPlaidHoldingsQuery.init(profileId: profileId)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let portfolioGains = graphQLResult.data?.portfolioGains else {
                        continuation.resume(returning: nil)
                        return
                    }
                    if let gains = portfolioGains.first {
                        continuation.resume(returning: gains)
                    } else {
                        continuation.resume(returning: nil)
                    }
                    break
                case .failure(let error):
                    dprint("Failure when making GetPlaidHoldingsQuery request. Error: \(error)")
                    continuation.resume(returning: nil)
                    break
                }
            }
        }
    }
}
