//
//  UserProfileManager+DW.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.10.2022.
//

import Foundation
import GainyCommon
import GainyAPI

extension UserProfileManager: GainyProfileProtocol {
    
    var selectedFundingAccount: GainyCommon.GainyFundingAccount? {
        get {
            if let selectedFundingAccountIndex = selectedFundingAccountIndex {
                if selectedFundingAccountIndex < currentFundingAccounts.count {
                    return currentFundingAccounts[selectedFundingAccountIndex]
                } else {
                    return nil
                }
            } else {
                if currentFundingAccounts.isEmpty {
                    return nil
                } else {
                    return currentFundingAccounts.first
                }
            }
        }
        set(newValue) {
            if let index = currentFundingAccounts.firstIndex(where: {$0.id == newValue?.id}) {
                selectedFundingAccountIndex = index
            }
        }
    }
    
    
    //MARK: - Accounts
    
    /// Get funding acccount for transactions without balance reload
    /// - Parameter isMock: is demo data returned
    /// - Returns: list of accounts
    @discardableResult func getFundingAccounts() async -> [GainyFundingAccount] {
        guard let profileID = profileID else {
            return [GainyFundingAccount]()
        }
        return await
        withCheckedContinuation {[weak fundingAccountsPublisher, weak self] continuation in
            Network.shared.fetch(query: TradingGetFundingAccountsQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let accounts = graphQLResult.data?.appTradingFundingAccounts.compactMap({TradingLinkBankAccountWithPlaidMutation.Data.TradingLinkBankAccountWithPlaid.FundingAccount.init(id:$0.id, balance: $0.balance, name: $0.name)}) else {
                        continuation.resume(returning: [GainyFundingAccount]())
                        return
                    }
                    self?.currentFundingAccounts = accounts
                    fundingAccountsPublisher?.send(accounts)
                    continuation.resume(returning: accounts)
                case .failure( _):
                    continuation.resume(returning: [GainyFundingAccount]())
                }
            }
        }
    }
    
    /// Get funding acccount for transactions *with* balance reload
    /// - Parameter isMock: is demo data returned
    /// - Returns: list of accounts
    @discardableResult func getFundingAccountsWithBalanceReload() async -> [GainyFundingAccount] {
        guard let profileID = profileID else {
            return [GainyFundingAccount]()
        }
        return await
        withCheckedContinuation {[weak fundingAccountsPublisher, weak self] continuation in
            Network.shared.fetch(query: TradingGetFundingAccountsWithUpdatedBalanceQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let accounts = graphQLResult.data?.tradingGetFundingAccounts?.compactMap({$0?.fundingAccount}).compactMap({TradingLinkBankAccountWithPlaidMutation.Data.TradingLinkBankAccountWithPlaid.FundingAccount.init(id:$0.id, balance: $0.balance, name: $0.name)}) else {
                        continuation.resume(returning: [GainyFundingAccount]())
                        return
                    }
                    self?.currentFundingAccounts = accounts
                    fundingAccountsPublisher?.send(accounts)
                    continuation.resume(returning: accounts)
                case .failure( _):
                    continuation.resume(returning: [GainyFundingAccount]())
                }
            }
        }
    }
    
    /// Adds funding account if it's not listed to current one
    /// - Parameter account: account ot add
    func addFundingAccount(_ account: GainyFundingAccount) {
        if !currentFundingAccounts.contains(where: {$0.id == account.id}) {
            currentFundingAccounts.append(account)
            fundingAccountsPublisher.send(currentFundingAccounts)
        }
    }
    
    //MARK: - KYC Status for Profile
    
    /// Get current KYC status
    /// - Returns: Status data if exists
    @discardableResult func getProfileStatus() async -> GainyKYCStatus? {
        guard let profileID else {
            return nil
        }
        if let kycStatus {
            return kycStatus
        }
        return await
        withCheckedContinuation {[weak self] continuation in
            Network.shared.fetch(query: TradingGetProfileStatusQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.tradingProfileStatus.first else {
                        continuation.resume(returning: nil)
                        return
                    }
                    self?.kycStatus = status
                    continuation.resume(returning: status)
                case .failure( _):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    /// Resets KYC status to fetch from server
    func resetKycStatus() {
        kycStatus = nil
    }
}

extension TradingGetProfileStatusQuery.Data.TradingProfileStatus: GainyKYCStatus {
}
