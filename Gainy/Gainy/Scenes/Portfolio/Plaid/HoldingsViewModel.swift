//
//  HoldingsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit

final class HoldingsViewModel {
    
    let dataSource = HoldingsDataSource()
    
    //MARK: - Network
    
    func loadHoldingsAndSecurities(_ completion: (() -> Void)?) {
        
        if let profileID = UserProfileManager.shared.profileID {
            
            let loadGroup = DispatchGroup()
            
            loadGroup.enter()
            Network.shared.apollo.fetch(query: GetPlaidHoldingsQuery.init(profileId: profileID)) {[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    guard let holdingsCount = graphQLResult.data?.getPortfolioHoldings?.count else {
                        NotificationManager.shared.showError("Sorry, you have no holdings")
                        return
                    }
                    dprint("Got \(holdingsCount) holding from Plaid")
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
                    guard let holdingsCount = graphQLResult.data?.getPortfolioTransactions?.count else {
                        NotificationManager.shared.showError("Sorry, you have no holdings")
                        return
                    }
                    dprint("Got \(holdingsCount) transactions from Plaid")
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    NotificationManager.shared.showError(error.localizedDescription)
                    break
                }
                loadGroup.leave()
            }
            
            loadGroup.notify(queue: .main) {
                completion?()
            }
            
        }
        
    }
}
