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
    
    /// Intermidiate model for Funding Account
    struct FundingAccount {
        let id: Int
        let balance: Float
        let name: String
        
        static func demo() -> Self {
            FundingAccount.init(id: (1...100).randomElement()!, balance: 4000.0, name: "Demo \((1...100).randomElement()!)")
        }
    }
    
    //MARK: - KYC
    
    /// Custom error for DW requests
    enum DWError: Error {
        case noProfileId, noData, loadError(_ error: Error)
    }
    
    /// KYC from values for pickers
    /// - Returns: picker values
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
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    /// Load our large KYC from partially
    /// - Returns: filled data struct
    func upsertKycForm() async throws -> UpsertKycFormMutation.Data.InsertAppKycForm {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.perform(mutation: UpsertKycFormMutation.init(profile_id: profileID)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.insertAppKycForm else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    /// Get current filled form data from server
    /// - Returns: filled data struct
    func getKycForm() async throws -> GetKycFormQuery.Data.AppKycFormByPk {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.fetch(query: GetKycFormQuery.init(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.appKycFormByPk else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    /// Send already uploaded form to DW
    /// - Returns: result of upload
    func kycSendForm() async throws -> KycSendFormMutation.Data.KycSendForm {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.perform(mutation: KycSendFormMutation.init(profile_id: profileID)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.kycSendForm else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    
    /// Get KYC form status
    /// - Returns: result of upload
    func getKycStatus() async throws -> KycGetStatusQuery.Data.KycGetStatus {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.fetch(query: KycGetStatusQuery.init(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.kycGetStatus else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    /// Generate URL for file upload - will be used later
    /// - Parameters:
    ///   - uploadType: always KYC
    ///   - contentType: UNKNOWN
    /// - Returns: ID, URL
    func getUrlForDocument(uploadType: String = "kyc", contentType: String) async throws -> GetUrlForDocumentMutation.Data.GetPreSignedUploadForm {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.perform(mutation: GetUrlForDocumentMutation.init(profile_id: profileID, upload_type: uploadType, content_type: contentType)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.getPreSignedUploadForm else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    enum FormType: String {
        case driverLicense = "DRIVER_LICENSE"
        case passport = "PASSPORT"
        case nationalID = "NATIONAL_ID_CARD"
        case voterID = "VOTER_ID"
        case workPermit = "WORK_PERMIT"
        case visa = "VISA"
        case residencePermit = "RESIDENCE_PERMIT"
    }
    
    enum FormSide: String {
        case front = "FRONT"
        case back = "BACK"
    }
    
    /// Upload file from 'getUrlForDocument' with params
    /// - Parameters:
    ///   - fileID: ID from getUrlForDocument
    ///   - type: Doc type
    ///   - side: Doc side
    /// - Returns: Upload status
    func kycSendForm(fileID: Int, type: FormType, side: FormSide) async throws -> KycAddDocumentMutation.Data.KycAddDocument {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.perform(mutation: KycAddDocumentMutation.init(profile_id: profileID, uploaded_file_id: fileID, type: type.rawValue, side: side.rawValue)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.kycAddDocument else {
                        continuation.resume(throwing: DWError.noData)
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
    
    /// Get funding acccount for transactions without balance reload
    /// - Parameter isMock: is demo data returned
    /// - Returns: list of accounts
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
    
    /// Get funding acccount for transactions *with* balance reload
    /// - Parameter isMock: is demo data returned
    /// - Returns: list of accounts
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
    
    //MARK: - Deposit
    
    /// Deposit values to trading account
    /// - Parameters:
    ///   - amount: Values to transfer
    ///   - fundingAccountId: Funding account ID
    /// - Returns: trading_money_flow_id
    func depositFunds(amount: Double, fundingAccountId: Int) async throws -> TradingDepositFundsMutation.Data.TradingDepositFund {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.perform(mutation: TradingDepositFundsMutation.init(profile_id: profileID, amount: amount, funding_account_id: fundingAccountId)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.tradingDepositFunds else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    //MARK: - Withdraw
    
    /// Withdraw values tfrom trading account
    /// - Parameters:
    ///   - amount: Values to transfer
    ///   - fundingAccountId: Funding account ID
    /// - Returns: trading_money_flow_id
    func withdrawFunds(amount: Double, fundingAccountId: Int) async throws -> TradingWithdrawFundsMutation.Data.TradingWithdrawFund {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.perform(mutation: TradingWithdrawFundsMutation.init(profile_id: profileID, amount: amount, funding_account_id: fundingAccountId)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.tradingWithdrawFunds else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: formData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
}


