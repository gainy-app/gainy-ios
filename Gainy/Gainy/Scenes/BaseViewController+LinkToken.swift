//
//  BaseViewController+LinkToken.swift
//  Gainy
//
//  Created by Anton Gubarenko on 10.11.2021.
//

import UIKit
import LinkKit

extension BaseViewController {
    
    func createLinkTokenConfiguration(_ linkToken: String)  -> LinkTokenConfiguration {
        // With custom configuration using a link_token
        var linkConfiguration = LinkTokenConfiguration(token: linkToken) { success in
            dprint("public-token: \(success.publicToken) metadata: \(success.metadata)")
            guard let profileID = UserProfileManager.shared.profileID else { return }
            Network.shared.apollo.fetch(query: LinkPlaidAccountQuery(profileId: profileID, publicToken: success.publicToken)) {[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    guard let linkData = graphQLResult.data?.linkPlaidAccount else {
                        return
                    }
                    if linkData.result {
                        UserProfileManager.shared.linkPlaidID = linkData.plaidAccessTokenId
                        self?.plaidLinked()
                    } else {
                        self?.plaidLinkFailed()
                    }
                    
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    
                    self?.plaidLinkFailed()
                    break
                }
            }
        }
        linkConfiguration.onExit = { exit in
            if let error = exit.error {
                print("exit with \(error)\n\(exit.metadata)")
            } else {
                print("exit with \(exit.metadata)")
            }
        }
        return linkConfiguration
    }
    
    //MARK: - Result functions
    @objc  func plaidLinked() {
        
    }
    
    @objc  func plaidLinkFailed() {
        
    }
    
    // MARK: Start Plaid Link using a Link token
    // For details please see https://plaid.com/docs/#create-link-token
    func presentPlaidLinkUsingLinkToken(_ linkToken: String) {
        let linkConfiguration = createLinkTokenConfiguration(linkToken)
        let result = Plaid.create(linkConfiguration)
        
        switch result {
        case .failure(let error):
            dprint("Unable to create Plaid handler due to: \(error)")
        case .success(let handler):
            handler.open(presentUsing: .viewController(self))
            linkHandler = handler
        }
    }
}
