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
        
        cancellable = Timer.publish(every: 60, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_  in
                
            }, receiveValue: {[weak self]_  in
                guard let self = self else {return}
                Task {
                    let indexes = await self.getRealtimeMetrics(symbols: self.indexSymbols)
                    
                    self.topIndexes.removeAll()
                    
                    for (ind, val) in self.indexNames.enumerated() {
                        
                        if let metric = indexes.first(where: { $0.symbol == self.indexSymbols[ind]}) {
                            
                            self.topIndexes.append(HomeIndexViewModel.init(name: val,
                                                                           grow: metric.relativeDailyChange ?? 0.0,
                                                                           value: metric.actualPrice ?? 0.0))
                        } else  {
                            self.topIndexes.append(HomeIndexViewModel.init(name: val,
                                                                           grow: 0.0,
                                                                           value: 0.0))
                        }
                    }
                    
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
    private let indexNames = ["Dow Jones", "S&P 500", "Nasdaq", "Bitcoin"]
    private let indexSymbols = ["DJI.INDX", "GSPC.INDX", "IXIC.INDX", "BTC.CC"]
    var topIndexes: [HomeIndexViewModel] = []
    
    //MARK: - Collections
    var favCollections: [RemoteShortCollectionDetails] = []
    var watchlist: [RemoteTicker] = []     
    
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
            let (colAsync, gainsAsync, articlesAsync, indexesAsync) = await (UserProfileManager.shared.getFavCollections().reorder(by: UserProfileManager.shared.favoriteCollections),
                                                                             getPortfolioGains(profileId: profielId),
                                                                             getArticles(),
                                                                             getRealtimeMetrics(symbols: indexSymbols))
            self.favCollections = colAsync
            self.gains = gainsAsync
            self.articles = articlesAsync
            
            let indexes = indexesAsync
            topIndexes.removeAll()
            
            for (ind, val) in indexNames.enumerated() {

                if let metric = indexes.first(where: { $0.symbol == indexSymbols[ind]}) {

                    topIndexes.append(HomeIndexViewModel.init(name: val,
                                                              grow: metric.relativeDailyChange ?? 0.0,
                                                              value: metric.actualPrice ?? 0.0))
                } else  {
                    topIndexes.append(HomeIndexViewModel.init(name: val,
                                                              grow: 0.0,
                                                              value: 0.0))
                }
            }
            await MainActor.run {
                self.dataSource.updateIndexes(models: self.topIndexes)
                completion()
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
