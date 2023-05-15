//
//  HoldingsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit
import GainyAPI

struct AccountViewModel {
    let accountID: Int
    let chartViewModel: HoldingChartViewModel
    let holdings: [HoldingViewModel]
}

final class HoldingsViewModel {
    
    let dataSource = HoldingsDataSource()
    
    private var holdingGroups: [GetPlaidHoldingsQuery.Data.ProfileHoldingGroup] = []
    private var portfolioGains: PortoGains?
    
    private var collectionTagsData: [CollectionDetailsTagsInfo] = []
    
    var settings: PortfolioSettings? {
        didSet {
            if let settings = settings {
                dataSource.sortAndFilterHoldingsBy(settings)
            }
        }
    }
    
    //TO-DO: Save all interests/categories
    var haveHoldings: Bool {
        dataSource.originalHoldings.count > 0
    }
    
    //MARK: - Caching
    private var chartsCache: [ScatterChartView.ChartPeriod : [ChartNormalized]] = [:]
    private var sypChartsCache: [ScatterChartView.ChartPeriod : [ChartNormalized]] = [:]
    private(set) var metrics: PrevDayData?
    
    func clearChats() {
        dataSource.profileGains.removeAll()
        chartsCache.removeAll()
        sypChartsCache.removeAll()
    }
    
    var interestsCount: Int = 0
    var categoriesCount: Int = 0
    
    //MARK: - Network
    
    var isDemoProfile: Bool = false {
        didSet {
            dataSource.isDemo = isDemoProfile
        }
    }
    
    var profileToUse: Int? {
        if isDemoProfile {
            return Constants.Plaid.demoProfileID
        } else {
            return UserProfileManager.shared.profileID
        }
    }
    
    private var config = Configuration()
    
    func loadHoldingsAndSecurities(_ completion: (() -> Void)?) {
        dataSource.isDemo = isDemoProfile
        chartsCache.removeAll()
        sypChartsCache.removeAll()
        Network.shared.apollo.clearCache()
        UserProfileManager.shared.resetKycStatus()
        LatestTradingSessionManager.shared.firstPortoDate = nil
        
        self.dataSource.chartViewModel.isLoading = true
        DispatchQueue.global().async {
            if let profileID = self.profileToUse {
                
                let loadGroup = DispatchGroup()
                loadGroup.enter()
                dprint("\(Date()) Holdings load start")
                Network.shared.apollo.fetch(query: GetPlaidHoldingsQuery.init(profileId: profileID)) {[weak self] result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let holdingsCount = graphQLResult.data?.profileHoldingGroups, let portfolioGains = graphQLResult.data?.portfolioGains  else {
                            dprint("\(graphQLResult)")
                            NotificationManager.shared.showError("Sorry, you have no holdings", report: true)
                            self?.dataSource.chartViewModel.isLoading = false
                            completion?()
                            return
                        }
                        self?.holdingGroups = holdingsCount.compactMap({$0})
                        self?.portfolioGains = portfolioGains.first?.fragments.portoGains
                        break
                    case .failure(let error):
                        dprint("Failure when making GraphQL request. Error: \(error)")
                        NotificationManager.shared.showError(error.localizedDescription, report: true)
                        break
                    }
                    dprint("\(Date()) Holdings load end")
                    loadGroup.leave()
                }
                
                loadGroup.enter()
                Task {
                    async let kycStatus = await UserProfileManager.shared.getProfileStatus()
                    await LatestTradingSessionManager.shared.getProfileSession(profileID: self.profileToUse)
                    loadGroup.leave()
                }
                
                self.collectionTagsData.removeAll()
                
                loadGroup.notify(queue: .main) {[weak self] in
                    guard let self = self else {
                        self?.dataSource.chartViewModel.isLoading = false
                        completion?()
                        return
                    }
                    
                    var tickSymbols: [String] = []
                    var securityTypesRaw: [String] = []
                    var interestsRaw: [UnifiedTagContainer] = []
                    var categoriesRaw: [UnifiedTagContainer] = []
                    var realtimeMetrics: [RemoteTickerDetails.RealtimeMetric] = []
                    
                    for holdingGroup in self.holdingGroups {
                                                
                        let symbol = holdingGroup.details?.tickerSymbol ?? ""
                        if !symbol.isEmpty {
                            tickSymbols.append(symbol)
                        }
                        for holding in holdingGroup.holdings {
                            securityTypesRaw.append(holding.type ?? "")
                            
                            // Map linked plaid account tokens/names and match with holdings brokers
                            let accountNames = UserProfileManager.shared.linkedBrokerAccounts.compactMap({$0.name})
                            if let brokerID = holding.broker?.uniqId,
                               let brokerName = holding.broker?.name {
                                   if accountNames.contains(brokerName) {
                                       let accounts = UserProfileManager.shared.linkedBrokerAccounts.compactMap { item in
                                           var result = PlaidAccountData(id: item.id, institutionID: item.institutionID, name: item.name, needReauthSince: item.needReauthSince, brokerName: item.brokerName, brokerUniqId: item.brokerUniqId)
                                           if item.name == brokerName {
                                               result = PlaidAccountData(id: item.id, institutionID: item.institutionID, name: item.name, needReauthSince: item.needReauthSince, brokerName: brokerName, brokerUniqId: brokerID)
                                           }
                                           return result
                                       }
                                       UserProfileManager.shared.linkedBrokerAccounts = accounts
                                   } else {
                                       var linkedAccounts = UserProfileManager.shared.linkedBrokerAccounts
                                       let fakeID = UserProfileManager.shared.linkedBrokerAccounts.count + 1
                                       let newItem = PlaidAccountData(id: -fakeID, institutionID: -fakeID, name: brokerName, needReauthSince: nil, brokerName: brokerName, brokerUniqId: brokerID)
                                       linkedAccounts.append(newItem)
                                       UserProfileManager.shared.linkedBrokerAccounts = linkedAccounts
                                   }
                               }
                        }
                        
                        interestsRaw.append(contentsOf:  holdingGroup.tags.compactMap({$0.unifiedInterest}))
                        categoriesRaw.append(contentsOf:  holdingGroup.tags.compactMap({$0.unifiedCategory}))
                        
//                        if let metric = holdingGroup.ticker?.realtimeMetrics {
//                            let localMetric = RemoteTickerDetails.RealtimeMetric.init(actualPrice: metric.actualPrice, relativeDailyChange: metric.relativeDailyChange, time: metric.time, symbol: metric.symbol)
//                            realtimeMetrics.append(localMetric)
//                            TickerLiveStorage.shared.setSymbolData(localMetric.symbol, data: localMetric)
//                        }
                        
                        if let mScore = holdingGroup.ticker?.fragments.remoteTickerDetails.matchScore {
                            TickerLiveStorage.shared.setMatchData(mScore.symbol, data: mScore)
                        }
                    }
                    securityTypesRaw = securityTypesRaw.uniqued()
                    
                    var settings = PortfolioSettingsManager.shared.getSettingByUserID(profileID)
                    
                    let interests = interestsRaw.map { item -> InfoDataSource in
                        let selected = settings?.interests.contains(where: { interestItem in
                            interestItem.selected && interestItem.id == item.id
                        }) ?? false
                        return InfoDataSource.init(type: .Interst, id: item.id, title: item.name, iconURL: item.url, selected: selected)
                    }.uniqueUsingKey{$0.id}
                    self.interestsCount = interests.count
                    
                    let categories = categoriesRaw.map { item -> InfoDataSource in
                        let selected = settings?.categories.contains(where: { categoryItem in
                            categoryItem.selected && categoryItem.id == item.id
                        }) ?? false
                        return InfoDataSource.init(type: .Category, id:item.id, title: item.name, iconURL: item.url, selected: selected)
                    }.uniqueUsingKey{$0.id}
                    self.categoriesCount = categories.count
                    
                    
                    let pieChartSorting: [PieChartMode : PortfolioSortingField] = [
                        .securityType : .weight,
                        .tickers : .weight,
                        .categories : .weight,
                        .interests : .weight,
                        .collections : .weight
                    ]
                    let pieChartAscending: [PieChartMode : Bool] = [
                        .securityType : false,
                        .tickers : false,
                        .categories : false,
                        .interests : false,
                        .collections : false
                    ]
                    let defaultSettings = PortfolioSettings.init(sorting: .matchScore,
                                                                 pieChartSorting: pieChartSorting,
                                                                 pieChartAscending: pieChartAscending,
                                                                 pieChartMode: .categories,
                                                                 ascending: false,
                                                                 includeClosedPositions: true,
                                                                 onlyLongCapitalGainTax: false,
                                                                 interests: interests,
                                                                 categories: categories,
                                                                 disabledAccounts: [],
                                                                 pieBrokers: [])
                    if settings == nil {
                        PortfolioSettingsManager.shared.setInitialSettingsForUserId(profileID, settings: defaultSettings)
                        settings = defaultSettings
                    } else {
                        PortfolioSettingsManager.shared.changeInterestsForUserId(profileID, interests: interests)
                        PortfolioSettingsManager.shared.changeCategoriesForUserId(profileID, categories: categories)
                        settings = PortfolioSettingsManager.shared.getSettingByUserID(profileID)
                    }
                    
                    let innerChartsGroup = DispatchGroup()
                    dprint("\(Date()) Holdings charts start")
                    for range in [self.dataSource.chartRange]{
                        innerChartsGroup.enter()
                        HistoricalChartsLoader.shared.loadPlaidPortfolioChart(profileID: profileID, range: range, settings: settings ?? defaultSettings, interestsCount: self.interestsCount, categoriesCount: self.categoriesCount, isDemo: self.isDemoProfile) {[weak self] chartData in
                            if range == .d1 {
                                LatestTradingSessionManager.shared.firstPortoDate = chartData.first?.date
                            }
                            self?.chartsCache[range] = chartData
                            dprint("Holdings charts last \(chartData.last?.datetime ?? "")")
                            innerChartsGroup.leave()
                        }
                        
                        innerChartsGroup.enter()
                        HistoricalChartsLoader.shared.loadChart(symbol: Constants.Chart.sypSymbol, range: range) {[weak self] chartData, rawData in
                            self?.sypChartsCache[range] = rawData
                            dprint("Holdings SPP charts last \(rawData.last?.datetime ?? "")")
                            innerChartsGroup.leave()
                        }
                    }
                    
                    innerChartsGroup.enter()
                    dprint("\(Date()) Metrics for Porto load start")
                    HistoricalChartsLoader.shared.loadPlaidPortfolioChartMetrics(profileID: profileID, settings: defaultSettings, interestsCount: self.interestsCount, categoriesCount: self.categoriesCount, isDemo: self.isDemoProfile) {[weak self] metrics in
                        if let metrics {
                            self?.metrics = PrevDayData(portoMetrics: metrics)
                        }
                        dprint("\(Date()) Metrics for Porto load end")
                        innerChartsGroup.leave()
                    }
                    
                    innerChartsGroup.notify(queue: .main) {
                        dprint("\(Date()) Holdings charts ended")
                        
                        let today = HoldingsModelMapper.topChartGains(range: self.dataSource.chartRange,
                                                                      chartsCache: self.chartsCache,
                                                                      sypChartsCache: self.sypChartsCache,
                                                                      portfolioGains: self.portfolioGains)
                        let sypChartReal = today.sypChartData
                        
                        dprint("Porto balance: \(self.portfolioGains?.actualValue ?? 0.0)")
                        var spGrow: Float = 0.0
                        if let data = TickerLiveStorage.shared.getSymbolData(Constants.Chart.sypSymbol) {
                            spGrow = Float(data.priceChangeToday) * 100.0
                        } else {
                            spGrow = Float(sypChartReal.startEndDiff)
                        }
                        
                        if self.isDemoProfile {
                            SharedValuesManager.shared.demoPortoGains = self.portfolioGains
                        } else {
                            SharedValuesManager.shared.homeGains = self.portfolioGains
                        }
                        
                        let live = HoldingChartViewModel.init(balance: SharedValuesManager.shared.portfolioBalance(forPorto: true) ?? (self.portfolioGains?.actualValue ?? 0.0),
                                                              rangeGrow: SharedValuesManager.shared.rangeGrowFor(self.dataSource.chartRange, forPorto: true) ?? today.rangeGrow,
                                                              rangeGrowBalance: SharedValuesManager.shared.rangeGrowBalanceFor(self.dataSource.chartRange, forPorto: true) ??  today.rangeGrowBalance,
                                                              spGrow: spGrow,
                                                              chartData: today.chartData,
                                                              sypChartData: sypChartReal)
                        
                        let originalHoldings = HoldingsModelMapper.modelsFor(holdingGroups: self.holdingGroups,
                                                                             profileHoldings: self.portfolioGains)
                        
                        if self.dataSource.chartViewModel == nil {
                            self.dataSource.chartViewModel = live
                        } else {
                            
//                            if !live.chartData.onlyPoints().isEmpty && !live.sypChartData.onlyPoints().isEmpty  {
//                                self.dataSource.chartViewModel.min = Double(min(live.sypChartData.onlyPoints().min() ?? 0.0, live.chartData.onlyPoints().min() ?? 0.0))
//                                self.dataSource.chartViewModel.max = Double(max(live.sypChartData.onlyPoints().max() ?? 0.0, live.chartData.onlyPoints().max() ?? 0.0))
//                            }
                            
                            //if live.sypChartData.onlyPoints().isEmpty {
                                self.dataSource.chartViewModel.min = live.chartData.onlyPoints().min() ?? 0.0
                                self.dataSource.chartViewModel.max = live.chartData.onlyPoints().max() ?? 0.0
                            //}
                            if !(settings?.isFilterApplied ?? false) {
                                self.dataSource.chartViewModel.lastDayPrice = Float(self.metrics?.lastDayPrice(range: self.dataSource.chartRange) ?? 0.0) ?? 0.0
                            } else {
                                self.dataSource.chartViewModel.lastDayPrice = 0.0
                            }
                            
                            if self.dataSource.chartViewModel.lastDayPrice != 0.0 {
                                self.dataSource.chartViewModel.min = min(Double(self.dataSource.chartViewModel.min ?? 0.0), Double(self.dataSource.chartViewModel.lastDayPrice))
                                self.dataSource.chartViewModel.max = max(Double(self.dataSource.chartViewModel.max ?? 0.0), Double(self.dataSource.chartViewModel.lastDayPrice))
                            }
                            
                            dprint("total Porto min: \(self.dataSource.chartViewModel.min)")
                            dprint("total Porto max: \(self.dataSource.chartViewModel.max)")
                            
                            self.dataSource.chartViewModel.balance = live.balance
                            self.dataSource.chartViewModel.rangeGrow = live.rangeGrow
                            self.dataSource.chartViewModel.rangeGrowBalance = live.rangeGrowBalance
                            self.dataSource.chartViewModel.spGrow = live.spGrow
                            self.dataSource.chartViewModel.chartData = live.chartData
                            self.dataSource.chartViewModel.sypChartData = live.sypChartData
                        }
                        self.dataSource.profileGains = [self.dataSource.chartRange : today]
                        self.dataSource.originalHoldings = originalHoldings
                        self.dataSource.holdings = originalHoldings
                        if let settings = settings {
                            self.dataSource.sortAndFilterHoldingsBy(settings)
                        }
                        dprint("\(Date()) Holdings final end")
                        self.dataSource.chartViewModel.isLoading = false
                        completion?()
                    }
                }
            }
        }
    }
    
    func loadChartsForRange(range: ScatterChartView.ChartPeriod, settings: PortfolioSettings, _ completion: ((PortfolioChartGainsViewModel?) -> Void)?) {
        
        if let profileID = profileToUse {
            
            let loadGroup = DispatchGroup()
            var haveSomethingToLoad = false
            
            if chartsCache[range] == nil {
                loadGroup.enter()
                HistoricalChartsLoader.shared.loadPlaidPortfolioChart(profileID: profileID, range: range, settings: settings, interestsCount: self.interestsCount, categoriesCount: self.categoriesCount, isDemo: self.isDemoProfile) {[weak self] chartData in
                    self?.chartsCache[range] = chartData
                    loadGroup.leave()
                }
                haveSomethingToLoad = true
            }
            
            if sypChartsCache[range] == nil {
                loadGroup.enter()
                HistoricalChartsLoader.shared.loadChart(symbol: Constants.Chart.sypSymbol, range: range) {[weak self] chartData, rawData in
                    self?.sypChartsCache[range] = rawData
                    loadGroup.leave()
                }
                haveSomethingToLoad = true
            }
            
            dprint("\(Date()) Metrics for Porto load start")
            loadGroup.enter()
            HistoricalChartsLoader.shared.loadPlaidPortfolioChartMetrics(profileID: profileID,
                                                                         settings: settings,
                                                                         interestsCount: self.interestsCount,
                                                                         categoriesCount: self.categoriesCount,
                                                                         isDemo: self.isDemoProfile) {[weak self] metrics in
                if let metrics {
                    self?.metrics = PrevDayData(portoMetrics: metrics)
                }
                dprint("\(Date()) Metrics for Porto load end")
                loadGroup.leave()
            }
            
            if haveSomethingToLoad {
                loadGroup.notify(queue: .main) {[weak self] in
                    guard let self = self else {
                        completion?(nil)
                        return
                    }
                    
                    let chartModel = HoldingsModelMapper.topChartGains(range: range,
                                                                       chartsCache: self.chartsCache,
                                                                       sypChartsCache: self.sypChartsCache,
                                                                       portfolioGains: self.portfolioGains)
                    completion?(chartModel)
                    
                }
            } else {
                let chartModel = HoldingsModelMapper.topChartGains(range: range,
                                                                   chartsCache: self.chartsCache,
                                                                   sypChartsCache: self.sypChartsCache,
                                                                   portfolioGains: self.portfolioGains)
                completion?(chartModel)
            }
        } else {
            completion?(nil)
        }
    }
    
    init() {
        //dataSource.delegate = self
    }
}
