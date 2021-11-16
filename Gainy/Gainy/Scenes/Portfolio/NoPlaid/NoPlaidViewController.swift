//
//  NoPlaidViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.11.2021.
//

import UIKit

protocol NoPlaidViewControllerDelegate: AnyObject {
    func plaidLinked(controller: NoPlaidViewController)
}

final class NoPlaidViewController: BaseViewController {
    
    weak var delegate: NoPlaidViewControllerDelegate?
    
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
                    NotificationManager.shared.showError("Sorry, you have no holdings")
                    self?.hideLoader()
                    return
                }
                dprint("Got \(holdingsCount) holding from Plaid")
                self?.hideLoader()
                if let self = self {
                    self.delegate?.plaidLinked(controller: self)
                }
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                NotificationManager.shared.showError(error.localizedDescription)
                self?.hideLoader()
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
                self?.hideLoader()
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
