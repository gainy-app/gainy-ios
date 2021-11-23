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
                        self.dataSource.holdings = HoldingsModelMapper.modelsFor(holdings: self.holdings,
                                                                                 securities: self.securities,
                                                                                 profileHoldings: self.profileGains)
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
