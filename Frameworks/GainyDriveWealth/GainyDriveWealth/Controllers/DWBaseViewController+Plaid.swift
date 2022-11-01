//
//  DWBaseViewController+Plaid.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 31.10.2022.
//

import UIKit
import LinkKit
import Apollo
import GainyAPI

extension DWBaseViewController {
    
    /// Start adding account from Plaid to Trade
    /// - Parameter profileID: current Profile ID
    func startFundingAccountLink(profileID: Int) {
        GainyAnalytics.logEvent("dw_plaid_link_pressed", params: nil)
        
        showNetworkLoader()
        Task {
            do {
                let createdLinkToken = try await dwAPI.createPlaidLink()
                print("Create link done: \(createdLinkToken)")
                await MainActor.run {
                    presentPlaidLinkUsingLinkToken(profileID:profileID, linkToken: createdLinkToken)
                }
                
            } catch {
                print("Create link failed: \(error)")
                await MainActor.run {
                    hideLoader()
                }
            }            
        }
    }
    
    func createLinkTokenConfiguration(profileID: Int, linkToken: String, reLink: Bool = false, accessTokenId: Int? = nil)  -> LinkTokenConfiguration {
        // With custom configuration using a link_token
        var linkConfiguration = LinkTokenConfiguration(token: linkToken) {[weak self] success in
                Task {
                    do {
                        let linkData = try await self?.dwAPI.linkPlaidToken(publicToken: success.publicToken)                       
                        print("Link done: \(linkData?.result ?? false)")
                        await MainActor.run {
                            if let linkData = linkData {
                                if linkData.result {
                                    self?.plaidLinked(token: linkData.plaidAccessTokenId ?? 0, plaidAccounts: (linkData.accounts?.compactMap({$0}) ?? []))
                                } else {
                                    self?.plaidLinkFailed()
                                }
                            }
                        }
                    } catch {
                        print("Link failed: \(error)")
                        await MainActor.run {
                            self?.plaidLinkFailed()
                        }
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
    
    
    
    // MARK: Start Plaid Link using a Link token
    // For details please see https://plaid.com/docs/#create-link-token
    func presentPlaidLinkUsingLinkToken(profileID: Int, linkToken: String, reLink: Bool = false, accessTokenId: Int? = nil) {
        let linkConfiguration = createLinkTokenConfiguration(profileID: profileID, linkToken: linkToken, reLink:reLink, accessTokenId:accessTokenId)
        let result = Plaid.create(linkConfiguration)
        
        switch result {
        case .failure(let error):
            break
        case .success(let handler):
            handler.open(presentUsing: .viewController(self))
            linkHandler = handler
        }
    }
    
}
