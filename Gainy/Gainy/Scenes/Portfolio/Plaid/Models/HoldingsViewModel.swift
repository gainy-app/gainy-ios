//
//  HoldingsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit

final class HoldingsViewModel {
    
    let dataSource = HoldingsDataSource()
    
    private var holdings: [GetPlaidHoldingsQuery.Data.GetPortfolioHolding] = []
    private var transactions: [GetPlaidTransactionsQuery.Data.GetPortfolioTransaction] = []
    private var profileGains: GetProfileGainsQuery.Data.AppProfile?
    
    var settings: PortfolioSettings? {
        didSet {
            if let settings = settings {
                dataSource.sortAndFilterHoldingsBy(settings)
            }
        }
    }
    
    //MARK: - Caching
    private var chartsCache: [ScatterChartView.ChartPeriod : ChartData] = [:]
    private var sypChartsCache: [ScatterChartView.ChartPeriod : ChartData] = [:]
    
    //MARK: - Network
    
    private var config = Configuration()
    
    func loadHoldingsAndSecurities(_ completion: (() -> Void)?) {
        DispatchQueue.global().async {
            if let profileID = UserProfileManager.shared.profileID {
                
                let loadGroup = DispatchGroup()
                
                loadGroup.enter()
                Network.shared.apollo.fetch(query: GetPlaidHoldingsQuery.init(profileId: profileID)) {[weak self] result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let holdingsCount = graphQLResult.data?.getPortfolioHoldings else {
                            NotificationManager.shared.showError("Sorry, you have no holdings")
                            completion?()
                            return
                        }
                        self?.holdings = holdingsCount.compactMap({$0})
                        break
                    case .failure(let error):
                        dprint("Failure when making GraphQL request. Error: \(error)")
                        NotificationManager.shared.showError(error.localizedDescription)
                        break
                    }
                    loadGroup.leave()
                }
                
                loadGroup.enter()
                Network.shared.apollo.fetch(query: GetPlaidTransactionsQuery.init(profileId: profileID)) {[weak self] result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let holdingsCount = graphQLResult.data?.getPortfolioTransactions else {
                            NotificationManager.shared.showError("Sorry, you have no holdings")
                            completion?()
                            return
                        }
                        self?.transactions = holdingsCount.compactMap({$0})
                        break
                    case .failure(let error):
                        dprint("Failure when making GraphQL request. Error: \(error)")
                        NotificationManager.shared.showError(error.localizedDescription)
                        break
                    }
                    loadGroup.leave()
                }
                
                loadGroup.enter()
                Network.shared.apollo.fetch(query: GetProfileGainsQuery.init(profileID: profileID)) {[weak self] result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let profile = graphQLResult.data?.appProfiles.first else {
                            NotificationManager.shared.showError("Sorry, you have no holdings")
                            completion?()
                            return
                        }
                        self?.profileGains = profile
                        break
                    case .failure(let error):
                        dprint("Failure when making GraphQL request. Error: \(error)")
                        NotificationManager.shared.showError(error.localizedDescription)
                        break
                    }
                    loadGroup.leave()
                }
                
                for range in ScatterChartView.ChartPeriod.allCases {
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
                    self.dataSource.chartRange = .d1
                    
                    let tickSymbols = self.transactions.compactMap({$0.security.tickerSymbol})
                    print(tickSymbols)
                    
                    
                    let securityTypesRaw = self.transactions.compactMap({$0.security.type}).uniqued()
                    let interestsRaw = self.transactions.compactMap({$0.security.tickers?.fragments.remoteTickerDetailsFull.tickerInterests}).flatMap({$0})
                    let categoriesRaw = self.transactions.compactMap({$0.security.tickers?.fragments.remoteTickerDetailsFull.tickerCategories}).flatMap({$0})
                    let realtimeMetrics = self.transactions.compactMap({$0.security.tickers?.fragments.remoteTickerDetailsFull.fragments.remoteTickerDetails.realtimeMetrics}).flatMap({$0})
                    
                    for tickLivePrice in realtimeMetrics {
                        TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                    }
                    
                    
                    var settings = PortfolioSettingsManager.shared.getSettingByUserID(profileID)
                    let securityTypes = securityTypesRaw.map { item -> InfoDataSource in
                        let selected = settings?.securityTypes.contains(where: { item in
                            item.selected
                        }) ?? true
                        return InfoDataSource.init(type: .SecurityType, id:item.hashValue, title: item, iconURL: "", selected: selected)
                    }.uniqueUsingKey{$0.id}
                    
                    let interests = interestsRaw.map { item -> InfoDataSource in
                        let selected = settings?.interests.contains(where: { item in
                            item.selected
                        }) ?? true
                        return InfoDataSource.init(type: .Interst, id:item.interest?.id ?? 0, title: item.interest?.name ?? "", iconURL: item.interest?.iconUrl ?? "", selected: selected)
                    }.uniqueUsingKey{$0.id}
                    
                    let categories = categoriesRaw.map { item -> InfoDataSource in
                        let selected = settings?.categories.contains(where: { item in
                            item.selected
                        }) ?? true
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
                    }
                    
                    
                    TickersLiveFetcher.shared.getMatchScores(symbols: tickSymbols) {
                        let topChartGains = HoldingsModelMapper.topChartGains(chartsCache: self.chartsCache, sypChartsCache: self.sypChartsCache, portfolioGains: self.profileGains)
                        
                        //Loading Today
                        let today = topChartGains[.d1]
                        
                        let demoChartData = ChartData.init(points: [32, 45, 56, 32, 20, 15, 25, 35, 45, 60, 50, 40].shuffled())
                        let demoSypChartData = ChartData.init(points: [32, 45, 56, 32, 20, 15, 25, 35, 45, 60, 50, 40].shuffled())
                        
                        let sypChartReal = today?.sypChartData ?? demoSypChartData
                        
                        let live = HoldingChartViewModel.init(balance: self.profileGains?.portfolioGains?.actualValue ?? 0.0,
                                                              rangeGrow: today?.rangeGrow ?? 0.0,
                                                              rangeGrowBalance: today?.rangeGrowBalance ?? 0.0,
                                                              spGrow: Float(sypChartReal.startEndDiff),
                                                              chartData: today?.chartData ?? demoChartData,
                                                              sypChartData: sypChartReal)
                      
                        self.dataSource.chartViewModel = live
                        self.dataSource.profileGains = topChartGains
                        self.dataSource.originalHoldings = HoldingsModelMapper.modelsFor(holdings: self.holdings,
                                                                                         transactions: self.transactions,
                                                                                         profileHoldings: self.profileGains)
                        self.dataSource.holdings = self.dataSource.originalHoldings
                        if let settings = settings {
                            self.dataSource.sortAndFilterHoldingsBy(settings)
                        }
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
