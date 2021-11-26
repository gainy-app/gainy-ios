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
    private var securities: [GetPlaidTransactionsQuery.Data.GetPortfolioTransaction] = []
    private var profileGains: GetProfileGainsQuery.Data.AppProfile?
    
    //MARK: - Caching
    private var chartsCache: [ScatterChartView.ChartPeriod : [GetPortfolioChartsQuery.Data.PortfolioChart]] = [:]
    
    //MARK: - Network
    
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
                        self?.securities = holdingsCount.compactMap({$0})
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
                    Network.shared.apollo.fetch(query: GetPortfolioChartsQuery.init(profileID: profileID, period: range.rawValue)) {[weak self] result in
                        switch result {
                        case .success(let graphQLResult):
                            self?.chartsCache[range] = graphQLResult.data?.portfolioChart ?? []
                        case .failure(let error):
                            dprint("Failure when making GraphQL request. Error: \(error)")
                            NotificationManager.shared.showError(error.localizedDescription)
                            break
                        }
                        loadGroup.leave()
                    }
                }
                
                loadGroup.notify(queue: .main) {[weak self] in
                    guard let self = self else {
                        completion?()
                        return
                    }
                    self.dataSource.chartRange = .d1
                    
                    let tickSymbols = self.holdings.compactMap({$0.security.first?.tickerSymbol})
                    print(tickSymbols)
                    
                    //TO-DO: Serhii it's for you
                    let securityType = self.holdings.compactMap({$0.security.first?.type}).uniqued()
                    print(securityType)
                    
                    let industries = self.holdings.compactMap({$0.security.first?.tickers?.fragments.remoteTickerDetails.tickerIndustries}).flatMap({$0})
                    print(industries)
                    
                    let interests = self.holdings.compactMap({$0.security.first?.tickers?.fragments.remoteTickerDetails.tickerCategories}).flatMap({$0})
                    print(interests)
                    
                    TickersLiveFetcher.shared.getSymbolsData(tickSymbols) {
                        TickersLiveFetcher.shared.getMatchScores(symbols: tickSymbols) {
                            let topChartGains = HoldingsModelMapper.topChartGains(chartsCache: self.chartsCache, portfolioGains: self.profileGains)
                            
                            //Loading Today
                            let today = topChartGains[.d1]
                            
                            let demo = HoldingChartViewModel.init(balance: 156225, rangeGrow: 12.05, rangeGrowBalance: 2228.50, spGrow: 1.13, chartData: ChartData.init(points: [32, 45, 56, 32, 20, 15, 25, 35, 45, 60, 50, 40]))
                            let live = HoldingChartViewModel.init(balance: self.profileGains?.portfolioGains?.actualValue ?? 0.0, rangeGrow: today?.rangeGrow ?? 0.0, rangeGrowBalance: today?.rangeGrowBalance ?? 0.0, spGrow: 0.0, chartData: today?.chartData ?? ChartData.init(points: [32, 45, 56, 32, 20, 15, 25, 35, 45, 60, 50, 40]))
                            self.dataSource.chartViewModel = live
                            self.dataSource.profileGains = topChartGains
                            self.dataSource.holdings = HoldingsModelMapper.modelsFor(holdings: self.holdings,
                                                                                     transactions: self.securities,
                                                                                     profileHoldings: self.profileGains)
                            completion?()
                        }
                    }
                    
                }
                
            }
        }
    }
    
    init() {
        //dataSource.delegate = self
    }
}
