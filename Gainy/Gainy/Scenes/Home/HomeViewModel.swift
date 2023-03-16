//
//  HomeViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import Combine
import GainyAPI
import GainyCommon

typealias WebArticle = HomeFetchArticlesQuery.Data.WebsiteBlogArticle

final class HomeViewModel {
    
    weak var authorizationManager: AuthorizationManager?
    
    init(authorizationManager: AuthorizationManager?) {
        self.authorizationManager = authorizationManager
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
//                    self.notifications = await ServerNotificationsManager.shared.getNotifications()
//                    await MainActor.run {
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
    var favCollections: [HomeCollectionContainer] = []
    var watchlist: [RemoteTicker] = []
    var topTickers: [RemoteTicker] = []
    
    func getTopIndexBy(symbol: String) -> RemoteTicker? {
        topTickers.first(where: {$0.symbol == symbol})
    }
    
    //
    var gains: PortoGains?
    
    var articles: [WebArticle] = []
    
    private(set) var notifications: [ServerNotification] = []
    
    //MARK: - Loading
    
    func loadHomeData(_ completion: @escaping (() -> Void)) {
        guard let profileId = UserProfileManager.shared.profileID else {
            if let authorizationManager = self.authorizationManager {
                authorizationManager.refreshAuthorizationStatus { status in
                    if status == .authorizedFully {
                        guard UserProfileManager.shared.profileID != nil else {
                            SubscriptionManager.shared.login(profileId: UserProfileManager.shared.profileID ?? 0)
                            SubscriptionManager.shared.getSubscription { _ in
                                
                            }
                            completion()
                            return
                        }
                        self.loadHomeData(completion)
                    } else {
                        completion()
                        return
                    }
                }
                return
            }
            return
        }
        Network.shared.apollo.clearCache()
        UserProfileManager.shared.fetchProfile {[weak self] _ in
            self?.afterProfileLoad(profileId: profileId, completion)
        }
    }
    
    private func afterProfileLoad(profileId: Int, _ completion: @escaping (() -> Void)) {
        //Purchasing
        SubscriptionManager.shared.login(profileId: UserProfileManager.shared.profileID ?? 0)
        SubscriptionManager.shared.getSubscription { _ in
            
        }
        SubscriptionManager.shared.storage.getViewedCollections()
        
        Task {
            async let fundings = await UserProfileManager.shared.getFundingAccounts()
            async let kycStatus = await UserProfileManager.shared.getProfileStatus()
            await ServerNotificationsManager.shared.getUnreadCount()
        }
        
        Task {
            let (colAsync, gainsAsync, articlesAsync, watchlistAsync, notifsASync) = await (UserProfileManager.shared.getFavCollections().reorder(by: UserProfileManager.shared.favoriteCollections),
                                                                                                                           getPortfolioGains(profileId: profileId),
                                                                                                                           getArticles(),
                                                                                                                           getWatchlist(),
                                                                                                                           ServerNotificationsManager.shared.getNotifications())
            let ttfGains = await getCollectionStatuses(for: colAsync.compactMap({$0.id}))
            var favsData = [HomeCollectionContainer]()
            for fav in colAsync {
                if let gain = ttfGains.first(where: {$0?.collectionId == fav.id}) {
                    favsData.append(HomeCollectionContainer.init(collection: fav,
                                                                    gains: gain))
                } else {
                    favsData.append(HomeCollectionContainer.init(collection: fav,
                                                                    gains: nil))
                }
            }
            
            self.favCollections = favsData
            self.sortFavCollections()
            
            self.gains = gainsAsync
            self.articles = articlesAsync
            self.watchlist = watchlistAsync
            //self.topTickers = topTickersAsync
            self.notifications = notifsASync
            self.sortWatchlist()
            
            SharedValuesManager.shared.homeGains = gainsAsync
            topIndexes.removeAll()
            
            await MainActor.run {
                self.dataSource.updateIndexes(models: self.topIndexes)
                completion()
            }
        }
    }
    
    func sortFavCollections() {
        guard let profielId = UserProfileManager.shared.profileID else { return }
        
        if UserProfileManager.shared.collectionsReordered {
            self.favCollections = self.favCollections.reorder(by: UserProfileManager.shared.favoriteCollections)
        } else {
            let colAsyncSorted = self.favCollections.sorted { lc, rc in
                
                let lhs = lc.collection
                let rhs = rc.collection
                
                let settings = CollectionsSortingSettingsManager.shared.getSettingByID(profielId)
                let sorting = settings.sorting
                if settings.ascending {
                    switch sorting {
                    case .matchScore:
                        return lhs.matchScore?.matchScore ?? 0.0 < rhs.matchScore?.matchScore ?? 0.0
                    case .todaysGain:
                        return lhs.metrics?.relativeDailyChange ?? 0.0 < rhs.metrics?.relativeDailyChange ?? 0.0
                    case .numberOfStocks:
                        return lhs.size ?? 0 < rhs.size ?? 0
                    case .name:
                        return lhs.name ?? "" < rhs.name ?? ""
                    }
                } else {
                    switch sorting {
                    case .matchScore:
                        return lhs.matchScore?.matchScore ?? 0.0 > rhs.matchScore?.matchScore ?? 0.0
                    case .todaysGain:
                        return lhs.metrics?.relativeDailyChange ?? 0.0 > rhs.metrics?.relativeDailyChange ?? 0.0
                    case .numberOfStocks:
                        return lhs.size ?? 0 > rhs.size ?? 0
                    case .name:
                        return lhs.name ?? "" > rhs.name ?? ""
                    }
                }
            }
            
            self.favCollections = colAsyncSorted
        }
    }
    
    func swapCollections(from fromIndex: Int, to toIndex: Int) {
        favCollections.move(from: fromIndex, to: toIndex)
    }
    
    func sortWatchlist() {
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(Constants.CollectionDetails.watchlistCollectionID)
        let watchlistAsyncSorted = self.watchlist.sorted(by: { lhs, rhs in
            let llhs = CollectionDetailsViewModelMapper.map(CollectionDetailsDTOMapper.mapTickerDetails(lhs))
            let rrhs = CollectionDetailsViewModelMapper.map(CollectionDetailsDTOMapper.mapTickerDetails(rhs))
            return settings.sortingValue().sortFunc(isAsc: settings.ascending, llhs, rrhs)
        })
        self.watchlist = watchlistAsyncSorted
    }
    
    func getWatchlist() async -> [RemoteTicker] {
        return await
        withCheckedContinuation { continuation in
            
            guard !UserProfileManager.shared.watchlist.isEmpty else {
                continuation.resume(returning: [])
                return
            }
            
            Network.shared.apollo.fetch(query: FetchTickersQuery.init(symbols: UserProfileManager.shared.watchlist)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let tickers = graphQLResult.data?.tickers else {
                        continuation.resume(returning: [])
                        return
                    }
                    
                    for tickLivePrice in tickers.compactMap({$0.fragments.remoteTickerDetails.realtimeMetrics}) {
                        TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                    }
                    
                    for tickMatch in tickers.compactMap({$0.fragments.remoteTickerDetails.matchScore}) {
                        TickerLiveStorage.shared.setMatchData(tickMatch.symbol, data: tickMatch)
                    }
                    
                    let remoteTickers = tickers.compactMap({$0.fragments.remoteTickerDetails})
                    continuation.resume(returning: remoteTickers)
                    
                case .failure(let error):
                    continuation.resume(returning: [])
                    dprint("Failure when making FetchTickersQuery request. Error: \(error)")
                }
            }
        }
    }
    
    func getTopTickers() async -> [RemoteTicker] {
        return await
        withCheckedContinuation { continuation in
            
            Network.shared.apollo.fetch(query: FetchTickersQuery.init(symbols: indexSymbols)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let tickers = graphQLResult.data?.tickers else {
                        continuation.resume(returning: [])
                        return
                    }
                    
                    for tickLivePrice in tickers.compactMap({$0.fragments.remoteTickerDetails.realtimeMetrics}) {
                        TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                    }
                    
                    for tickMatch in tickers.compactMap({$0.fragments.remoteTickerDetails.matchScore}) {
                        TickerLiveStorage.shared.setMatchData(tickMatch.symbol, data: tickMatch)
                    }
                    
                    let remoteTickers = tickers.compactMap({$0.fragments.remoteTickerDetails})
                    continuation.resume(returning: remoteTickers)
                    
                case .failure(let error):
                    continuation.resume(returning: [])
                    dprint("Failure when making FetchTickersQuery request. Error: \(error)")
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
                    dprint("Failure when making FetchRealtimeMetricsQuery request. Error: \(error)")
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
    
    func getPortfolioGains(profileId: Int) async -> PortoGains? {
        return await
        withCheckedContinuation { continuation in
            
        Network.shared.apollo.fetch(query: GetPlaidProfileGainsQuery.init(profileId: profileId)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let portfolioGains = graphQLResult.data?.portfolioGains.compactMap({$0.fragments.portoGains}) else {
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
    
    /// Get TTF statuses for extra gains data
    /// - Parameter colIDs: favrite collection IDs
    /// - Returns: list of available
    private func getCollectionStatuses(for colIDs: [Int]) async -> [TTFStatus?] {
        return await withTaskGroup(of: TTFStatus?.self) { group in
            
            var collections = [TTFStatus?]()
            collections.reserveCapacity(colIDs.count)
            
            // adding tasks to the group and fetching collections
            for colID in colIDs {
                group.addTask {
                    return await CollectionsManager.shared.getCollectionStatus(collectionId: colID)
                }
            }
            
            for await coll in group {
                collections.append(coll)
            }
            
            return collections.compactMap({$0})
        }
    }
}
