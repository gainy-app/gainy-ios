//
//  DWAPI.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 20.10.2022.
//

import GainyCommon
import GainyAPI

class DWAPI {
    
    init(network: GainyNetworkProtocol, userProfile: GainyProfileProtocol) {
        self.network = network
        self.userProfile = userProfile
    }
    
    private let network: GainyNetworkProtocol
    private let userProfile: GainyProfileProtocol
    
    struct FundingAccount {
        let id: Int
        let balance: Float
        let name: String
        
        static func demo() -> Self {
            FundingAccount.init(id: (1...100).randomElement()!, balance: 4000.0, name: "Demo \((1...100).randomElement()!)")
        }
    }
    
    //MARK: - KYC
    
    enum DWError: Error {
        case noProfileId, configLoadFailed, loadError(_ error: Error)
    }
    
    func getKycFormConfig() async throws -> KycGetFormConfigQuery.Data.KycGetFormConfig {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.fetch(query: KycGetFormConfigQuery.init(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.kycGetFormConfig else {
                        continuation.resume(throwing: DWError.configLoadFailed)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    
    //MARK: - Accounts
    
    func getFundingAccounts(isMock: Bool = false) async -> [FundingAccount] {
        guard let profileID = userProfile.profileID else {
            return [FundingAccount]()
        }
        guard !isMock else {
            return (1...3).map({_ in FundingAccount.demo()})
        }
        return await
        withCheckedContinuation { continuation in
            network.fetch(query: TradingGetFundingAccountsQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let accounts = graphQLResult.data?.appTradingFundingAccounts.compactMap({_ in FundingAccount.demo()}) else {
                        continuation.resume(returning: [FundingAccount]())
                        return
                    }
                    continuation.resume(returning: accounts)
                case .failure(let error):
                    continuation.resume(returning: [FundingAccount]())
                }
            }
        }
    }
    
    func getFundingAccountsWithBalanceReload(isMock: Bool = false) async -> [FundingAccount] {
        guard let profileID = userProfile.profileID else {
            return [FundingAccount]()
        }
        guard !isMock else {
            return (1...3).map({_ in FundingAccount.demo()})
        }
        return await
        withCheckedContinuation { continuation in
            network.fetch(query: TradingGetFundingAccountsWithUpdatedBalanceQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let accounts = graphQLResult.data?.tradingGetFundingAccounts?.compactMap({ _ in FundingAccount.demo()}) else {
                        continuation.resume(returning: [FundingAccount]())
                        return
                    }
                    continuation.resume(returning: accounts)
                case .failure(let error):
                    continuation.resume(returning: [FundingAccount]())
                }
            }
        }
    }
}


