//
//  HoldingsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit

struct AccountViewModel {
    let accountID: Int
    let chartViewModel: HoldingChartViewModel
    let holdings: [HoldingViewModel]
}

final class HoldingsViewModel {
    
    let dataSource = HoldingsDataSource()
    
    private var holdingGroups: [GetPlaidHoldingsQuery.Data.ProfileHoldingGroup] = []
    private var portfolioGains: GetPlaidHoldingsQuery.Data.PortfolioGain?
    
    var settings: PortfolioSettings? {
        didSet {
            if let settings = settings {
                dataSource.sortAndFilterHoldingsBy(settings)
            }
        }
    }
    
    var haveHoldings: Bool {
        self.dataSource.originalHoldings.count > 0
    }
    
    //MARK: - Caching
    private var chartsCache: [ScatterChartView.ChartPeriod : [ChartNormalized]] = [:]
    private var sypChartsCache: [ScatterChartView.ChartPeriod : [ChartNormalized]] = [:]
    
    
    //MARK: - Network
    
    private var config = Configuration()
    
    func loadHoldingsAndSecurities(_ completion: (() -> Void)?) {
        chartsCache.removeAll()
        sypChartsCache.removeAll()
        
        DispatchQueue.global().async {
            if let profileID = UserProfileManager.shared.profileID {
                
                let loadGroup = DispatchGroup()
                loadGroup.enter()
                dprint("\(Date()) Holdings load start")
                Network.shared.apollo.fetch(query: GetPlaidHoldingsQuery.init(profileId: profileID)) {[weak self] result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let holdingsCount = graphQLResult.data?.profileHoldingGroups, let portfolioGains = graphQLResult.data?.portfolioGains  else {
                            dprint("\(graphQLResult)")
                            NotificationManager.shared.showError("Sorry, you have no holdings")
                            completion?()
                            return
                        }
                        self?.holdingGroups = holdingsCount.compactMap({$0})
                        self?.portfolioGains = portfolioGains.first
                        break
                    case .failure(let error):
                        dprint("Failure when making GraphQL request. Error: \(error)")
                        NotificationManager.shared.showError(error.localizedDescription)
                        break
                    }
                    dprint("\(Date()) Holdings load end")
                    loadGroup.leave()
                }
                
                dprint("\(Date()) Holdings charts start")
                for range in [ScatterChartView.ChartPeriod.d1]{
                    loadGroup.enter()
                    HistoricalChartsLoader.shared.loadPlaidPortfolioChart(profileID: profileID, range: range) {[weak self] chartData in
                        self?.chartsCache[range] = chartData
                        loadGroup.leave()
                    }
                    
                    loadGroup.enter()
                    HistoricalChartsLoader.shared.loadChart(symbol: Constants.Chart.sypSymbol, range: range) {[weak self] chartData, rawData in
                        self?.sypChartsCache[range] = rawData
                        loadGroup.leave()
                    }
                }
                
                loadGroup.notify(queue: .main) {[weak self] in
                    guard let self = self else {
                        completion?()
                        return
                    }
                    dprint("\(Date()) Holdings charts ended")
                    self.dataSource.chartRange = .d1
                    
                    var tickSymbols: [String] = []
                    var securityTypesRaw: [String] = []
                    var interestsRaw: [RemoteTickerDetailsFull.TickerInterest] = []
                    var categoriesRaw: [RemoteTickerDetailsFull.TickerCategory] = []
                    var realtimeMetrics: [RemoteTickerDetails.RealtimeMetric] = []
                    
                    for holdingGroup in self.holdingGroups {
                        let symbol = holdingGroup.details?.tickerSymbol ?? ""
                        if !symbol.isEmpty {
                            tickSymbols.append(symbol)
                        }
                        for holding in holdingGroup.holdings {
                            securityTypesRaw.append(holding.type ?? "")
                        }
                        
                        interestsRaw.append(contentsOf:  holdingGroup.ticker?.fragments.remoteTickerDetailsFull.tickerInterests.compactMap({$0}) ?? [])
                        
                        categoriesRaw.append(contentsOf:  holdingGroup.ticker?.fragments.remoteTickerDetailsFull.tickerCategories.compactMap({$0}) ?? [])
                        
                        if let metric = holdingGroup.ticker?.fragments.remoteTickerDetailsFull.fragments.remoteTickerDetails.realtimeMetrics {
                            realtimeMetrics.append(metric)
                            TickerLiveStorage.shared.setSymbolData(metric.symbol ?? "", data: metric)
                            dprint("Set \(metric.actualPrice ?? 0.0) - \(metric.relativeDailyChange ?? 0.0) for \(metric.symbol ?? "")")
                        }
                        
                        if let mScore = holdingGroup.ticker?.fragments.remoteTickerDetailsFull.fragments.remoteTickerDetails.matchScore {
                            TickerLiveStorage.shared.setMatchData(mScore.symbol, data: mScore)
                        }
                    }
                    securityTypesRaw = securityTypesRaw.uniqued()
                    
                    var settings = PortfolioSettingsManager.shared.getSettingByUserID(profileID)
                    let securityTypes = securityTypesRaw.map { item -> InfoDataSource in
                        let selected = settings?.securityTypes.contains(where: { item in
                            item.selected
                        }) ?? false
                        return InfoDataSource.init(type: .SecurityType, id:item.hashValue, title: item, iconURL: InfoDataSourceType.securityTypeToIconURL[item] ?? "", selected: selected)
                    }.uniqueUsingKey{$0.id}
                    
                    let interests = interestsRaw.map { item -> InfoDataSource in
                        let selected = settings?.interests.contains(where: { item in
                            item.selected
                        }) ?? false
                        return InfoDataSource.init(type: .Interst, id:item.interest?.id ?? 0, title: item.interest?.name ?? "", iconURL: item.interest?.iconUrl ?? "", selected: selected)
                    }.uniqueUsingKey{$0.id}
                    
                    let categories = categoriesRaw.map { item -> InfoDataSource in
                        let selected = settings?.categories.contains(where: { item in
                            item.selected
                        }) ?? false
                        return InfoDataSource.init(type: .Category, id:item.categories?.id ?? 0, title: item.categories?.name ?? "", iconURL: item.categories?.iconUrl ?? "", selected: selected)
                    }.uniqueUsingKey{$0.id}
                    
                    let defaultSettings = PortfolioSettings.init(sorting: .matchScore,
                                                                 ascending: false,
                                                                 includeClosedPositions: true,
                                                                 onlyLongCapitalGainTax: false,
                                                                 interests: interests,
                                                                 categories: categories,
                                                                 securityTypes: securityTypes,
                                                                 disabledAccounts: [])
                    if settings == nil {
                        PortfolioSettingsManager.shared.setInitialSettingsForUserId(profileID, settings: defaultSettings)
                        settings = defaultSettings
                    } else {
                        PortfolioSettingsManager.shared.changeInterestsForUserId(profileID, interests: interests)
                        PortfolioSettingsManager.shared.changeCategoriesForUserId(profileID, categories: categories)
                        PortfolioSettingsManager.shared.changeSecurityTypesForUserId(profileID, securityTypes: securityTypes)
                    }
                    
                    
                    let today = HoldingsModelMapper.topChartGains(range: .d1,
                                                                  chartsCache: self.chartsCache,
                                                                  sypChartsCache: self.sypChartsCache,
                                                                  portfolioGains: self.portfolioGains)
                    let sypChartReal = today.sypChartData
                    
                    let live = HoldingChartViewModel.init(balance: self.portfolioGains?.actualValue ?? 0.0,
                                                          rangeGrow: today.rangeGrow,
                                                          rangeGrowBalance: today.rangeGrowBalance,
                                                          spGrow: Float(sypChartReal.startEndDiff),
                                                          chartData: today.chartData,
                                                          sypChartData: sypChartReal)
                    
                    let originalHoldings = HoldingsModelMapper.modelsFor(holdingGroups: self.holdingGroups,
                                                                         profileHoldings: self.portfolioGains)
                    dprint("\(Date()) Holdings match score end")
                    self.dataSource.chartViewModel = live
                    self.dataSource.profileGains = [.d1 : today]
                    self.dataSource.originalHoldings = originalHoldings
                    self.dataSource.holdings = originalHoldings
                    if let settings = settings {
                        self.dataSource.sortAndFilterHoldingsBy(settings)
                    }
                    dprint("\(Date()) Holdings fianl end")
                    completion?()
                }
            }
        }
    }
    
    func loadChartsForRange(range: ScatterChartView.ChartPeriod, _ completion: ((PortfolioChartGainsViewModel?) -> Void)?) {
        if let profileID = UserProfileManager.shared.profileID {
            let loadGroup = DispatchGroup()
            loadGroup.enter()
            HistoricalChartsLoader.shared.loadPlaidPortfolioChart(profileID: profileID, range: range) {[weak self] chartData in
                self?.chartsCache[range] = chartData
                loadGroup.leave()
            }
            
            loadGroup.enter()
            HistoricalChartsLoader.shared.loadChart(symbol: Constants.Chart.sypSymbol, range: range) {[weak self] chartData, rawData in
                self?.sypChartsCache[range] = rawData
                loadGroup.leave()
            }
            
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
            completion?(nil)
        }
    }
    
    init() {
        //dataSource.delegate = self
    }
}
