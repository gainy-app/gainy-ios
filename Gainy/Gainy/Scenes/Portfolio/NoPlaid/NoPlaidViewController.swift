//
//  NoPlaidViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.11.2021.
//

import UIKit
import GainyAPI

protocol NoPlaidViewControllerDelegate: AnyObject {
    func plaidLinked(controller: BaseViewController)
}

final class NoPlaidViewController: BaseViewController {
    
    weak var delegate: NoPlaidViewControllerDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var plaidLinkBtn: UIButton!
    
    //MARK: - Plaid Listeners
        
    override func plaidLinked() {
        super.plaidLinked()
        
        GainyAnalytics.logEvent("portfolio_plaid_link_success")
        delegate?.plaidLinked(controller: self)
    }
    
    override func plaidLinkFailed() {
        super.plaidLinkFailed()
        GainyAnalytics.logEvent("portfolio_plaid_link_failed")
    }
    
    
    //MARK: - Action
    @IBAction func plaidLinkAction(_ sender: Any) {
        GainyAnalytics.logEvent("portfolio_plaid_link_pressed")
        guard let profileID = UserProfileManager.shared.profileID else {return}
        
        showNetworkLoader()
        Network.shared.apollo.fetch(query: CreatePlaidLinkQuery.init(profileId: profileID, redirectUri: Constants.Plaid.redirectURI, env: UserProfileManager.shared.plaidEnv)) {[weak self] result in
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
