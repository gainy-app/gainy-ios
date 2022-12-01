//
//  UserProfileManager+DW.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.10.2022.
//

import Foundation
import GainyCommon
import GainyAPI
import GainyDriveWealth

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
    
    /// Delete funding account
    /// - Parameter account: account to delete
    /// - Returns: true/false
    func deleteFundingAccount(account: GainyFundingAccount) async -> TradingDeleteFundingAccountMutation.Data.TradingDeleteFundingAccount? {
        guard let profileID = profileID else {
            return nil
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.perform(mutation: TradingDeleteFundingAccountMutation.init(profile_id: profileID, funding_account_id: account.id)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.tradingDeleteFundingAccount else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
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
            if kycStatus.kycDone ?? false {
                return kycStatus
            }
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
    
    /// Gets Profile Pending actions for DW
    /// - Returns: Pending requests if exists
    func getProfileLastPendingRequest() async -> [AppTradingMoneyFlow]? {
        guard let profileID else {
            return nil
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: TradingGetProfilePendingFlowQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.appTradingMoneyFlow.first else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: [status])
                case .failure( _):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    /// Get Profile DW transactions history
    /// - Parameter types: Profile History Types array
    /// - Returns: List of transactions
    func getProfileTradingHistory(types: [String] = GainyDriveWealth.ProfileTradingHistoryType.allCases.compactMap { item in
        item.rawValue
    }) async -> [TradingHistoryData] {
        guard let profileID else {
            return [GetProfileTradingHistoryQuery.Data.TradingHistory]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: GetProfileTradingHistoryQuery(profile_id: profileID, types: types)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let list = graphQLResult.data?.tradingHistory else {
                        continuation.resume(returning: [GetProfileTradingHistoryQuery.Data.TradingHistory]())
                        return
                    }
                    continuation.resume(returning: list)
                case .failure( _):
                    continuation.resume(returning: [GetProfileTradingHistoryQuery.Data.TradingHistory]())
                }
            }
        }
    }
    
    /// Resets KYC status to fetch from server
    func resetKycStatus() {
        kycStatus = nil
    }
    
    //MARK: - Statements
    
    
    
    /// Get's DW Docs list for Profile
    /// - Returns: Aray of Docs
    func getProfileDWStatements() async -> [TradingGetStatementsQuery.Data.AppTradingStatement] {
        typealias innerType = TradingGetStatementsQuery.Data.AppTradingStatement
        guard let profileID else {
            return [innerType]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: TradingGetStatementsQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let list = graphQLResult.data?.appTradingStatements else {
                        continuation.resume(returning: [innerType]())
                        return
                    }
                    continuation.resume(returning: list)
                case .failure( _):
                    continuation.resume(returning: [innerType]())
                }
            }
        }
    }
    
    /// Get's DW Doc url to download
    /// - Returns: Aray of Docs
    /// - Parameter statementID: document ID
    func getProfileDWStatementUrl(statementID: Int) async -> String? {
        guard let profileID else {
            return nil
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: TradingDownloadStatementQuery(profile_id: profileID, statement_id: statementID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let url = graphQLResult.data?.tradingDownloadStatement?.url else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: url)
                case .failure( _):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}



extension TradingGetProfileStatusQuery.Data.TradingProfileStatus: GainyKYCStatus {
    public var status: KYCStatus {
        KYCStatus.init(rawValue: kycStatus ?? "") ?? .notReady
    }
}

extension TradingGetProfilePendingFlowQuery.Data.AppTradingMoneyFlow : AppTradingMoneyFlow {
    
}


extension TradingGetProfilePendingFlowQuery.Data.AppTradingMoneyFlow{
    var date: Date {
        return (createdAt).toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date ?? Date()
    }
}


