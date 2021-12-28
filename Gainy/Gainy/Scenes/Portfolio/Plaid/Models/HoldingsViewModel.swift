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
    private var chartsCache: [ScatterChartView.ChartPeriod : ChartData] = [:]
    private var sypChartsCache: [ScatterChartView.ChartPeriod : ChartData] = [:]
    
    func loadNewChartData(period: ScatterChartView.ChartPeriod, _ completion: ( () -> Void)? = nil) {
        if let chartCache = chartsCache[period] {

            completion?()
        } else {
        }
    }
    
    //MARK: - Network
    
    private var config = Configuration()
    
    func loadHoldingsAndSecurities(_ completion: (() -> Void)?) {
        DispatchQueue.global().async {
            if let profileID = UserProfileManager.shared.profileID {
                
                let loadGroup = DispatchGroup()
                loadGroup.enter()
                print("\(Date()) Holdings load start")
                Network.shared.apollo.fetch(query: GetPlaidHoldingsQuery.init(profileId: profileID)) {[weak self] result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let holdingsCount = graphQLResult.data?.profileHoldingGroups, let portfolioGains = graphQLResult.data?.portfolioGains  else {
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
                    print("\(Date()) Holdings load end")
                    loadGroup.leave()
                }
                
                print("\(Date()) Holdings charts start")
                for range in [ScatterChartView.ChartPeriod.d1]{
                    loadGroup.enter()
                    HistoricalChartsLoader.shared.loadPlaidPortfolioChart(profileID: profileID, range: range) {[weak self] chartData in
                        self?.chartsCache[range] = chartData
                        loadGroup.leave()
                    }
                    
                    loadGroup.enter()
                    HistoricalChartsLoader.shared.loadChart(symbol: Constants.Chart.sypSymbol, range: range) {[weak self] chartData, _ in
                        self?.sypChartsCache[range] = chartData
                        loadGroup.leave()
                    }
                }
                
                loadGroup.notify(queue: .main) {[weak self] in
                    guard let self = self else {
                        completion?()
                        return
                    }
                    print("\(Date()) Holdings charts enede")
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
                    
                    print("\(Date()) Holdings match score start")
                    TickersLiveFetcher.shared.getMatchScores(symbols: tickSymbols) {
                        
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
                        print("\(Date()) Holdings match score end")
                        self.dataSource.chartViewModel = live
                        self.dataSource.profileGains = [.d1 : today]
                        self.dataSource.originalHoldings = originalHoldings
                        self.dataSource.holdings = originalHoldings
                        if let settings = settings {
                            self.dataSource.sortAndFilterHoldingsBy(settings)
                        }
                        print("\(Date()) Holdings fianl end")
                        completion?()
                    }
                }
            }
        }
    }
    
    init() {
        //dataSource.delegate = self
    }
}
