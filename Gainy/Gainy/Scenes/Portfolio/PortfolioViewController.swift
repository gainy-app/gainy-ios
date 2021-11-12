//
//  PortfolioViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit

final class PortfolioViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var plaidLinkBtn: UIButton!
    
    //MARK: - Plaid Listeners
        
    override func plaidLinked() {
        super.plaidLinked()
        if let profileID = UserProfileManager.shared.profileID {
            Network.shared.apollo.fetch(query: GetPlaidHoldingsQuery.init(profileId: profileID)) {[weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let holdingsCount = graphQLResult.data?.getPortfolioHoldings?.count else {
                    return
                }
                dprint("Got \(holdingsCount) holding from Plaid")
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                break
            }
        }
        }
    }
    
    
    //MARK: - Action
    @IBAction func plaidLinkAction(_ sender: Any) {
        if let profileID = UserProfileManager.shared.profileID {
        
        showNetworkLoader()
        
            Network.shared.apollo.fetch(query: CreatePlaidLinkQuery.init(profileId: profileID, redirectUri: Constants.Plaid.redirectURI)) {[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    guard let linkToken = graphQLResult.data?.createPlaidLinkToken?.linkToken else {
                        return
                    }
                    self?.presentPlaidLinkUsingLinkToken(linkToken)
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    break
                }
            }
        }
        
    }
}
