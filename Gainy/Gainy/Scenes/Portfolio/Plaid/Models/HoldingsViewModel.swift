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
                
                loadGroup.notify(queue: .main) {[weak self] in
                    guard let self = self else {
                        completion?()
                        return
                    }
                    self.dataSource.chartRange = .d1
                    self.dataSource.holdings = HoldingsModelMapper.modelsFor(holdings: self.holdings,
                                                                             securities: self.securities)
                    completion?()
                }
                
            }
        }
    }
    
    init() {
        //dataSource.delegate = self
    }
}
