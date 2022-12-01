//
//  DWAPI.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 20.10.2022.
//

import GainyCommon
import GainyAPI

public typealias PlaidAccountToLink = LinkPlaidAccountQuery.Data.LinkPlaidAccount.Account
public typealias PlaidFundingAccount = TradingLinkBankAccountWithPlaidMutation.Data.TradingLinkBankAccountWithPlaid.FundingAccount

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

extension PlaidFundingAccount {
    
    static func demo() -> Self {
        PlaidFundingAccount.init(id: (1...100).randomElement()!, balance: 4000.0, name: "Demo \((1...100).randomElement()!)")
    }
}

public class DWAPI {
    
    init(network: GainyNetworkProtocol, userProfile: GainyProfileProtocol) {
        self.network = network
        self.userProfile = userProfile
    }
    
    private let network: GainyNetworkProtocol
    let userProfile: GainyProfileProtocol
    
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
    func upsertKycForm(address_city:  String? = nil,
                       address_country: String? = nil,
                       address_postal_code: String? = nil,
                       address_province: String? = nil,
                       address_street1: String? = nil,
                       address_street2: String? = nil,
                       birthdate: date? = nil,
                       citizenship: String? = nil,
                       country: String? = nil,
                       disclosures_drivewealth_customer_agreement: Bool? = nil,
                       disclosures_drivewealth_data_sharing: Bool? = nil,
                       disclosures_drivewealth_ira_agreement: Bool? = nil,
                       disclosures_drivewealth_market_data_agreement: Bool? = nil,
                       disclosures_drivewealth_privacy_policy: Bool? = nil,
                       disclosures_drivewealth_terms_of_use: Bool? = nil,
                       disclosures_extended_hours_agreement: Bool? = nil,
                       disclosures_rule14b: Bool? = nil,
                       disclosures_signed_by: String? = nil,
                       email_address: String? = nil,
                       employment_affiliated_with_a_broker: Bool? = nil,
                       employment_company_name: String? = nil,
                       employment_is_director_of_a_public_company: String? = nil,
                       employment_position: String? = nil,
                       employment_status: String? = nil,
                       employment_type: String? = nil,
                       first_name: String? = nil,
                       gender: String? = nil,
                       investor_profile_annual_income: bigint? = nil,
                       investor_profile_experience: String? = nil,
                       investor_profile_net_worth_liquid: bigint? = nil,
                       investor_profile_net_worth_total: bigint? = nil,
                       investor_profile_objectives: String? = nil,
                       investor_profile_risk_tolerance: String? = nil,
                       tax_treaty_with_us: Bool? = nil,
                       tax_id_value: String? = nil,
                       tax_id_type: String? = nil,
                       politically_exposed_names: String? = nil,
                       phone_number: String? = nil,
                       marital_status: String? = nil,
                       last_name: String? = nil,
                       language: String? = nil,
                       is_us_tax_payer: Bool? = nil,
                       irs_backup_withholdings_notified: Bool? = nil) async throws -> UpsertKycFormMutation.Data.InsertAppKycForm {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            let mutation = UpsertKycFormMutation.init(address_city:address_city,
                                                      address_country:address_country,
                                                      address_postal_code:address_postal_code,
                                                      address_province:address_province,
                                                      address_street1:address_street1,
                                                      address_street2:address_street2,
                                                      birthdate:birthdate,
                                                      citizenship:citizenship,
                                                      country:country,
                                                      disclosures_drivewealth_customer_agreement:disclosures_drivewealth_customer_agreement,
                                                      disclosures_drivewealth_data_sharing:disclosures_drivewealth_data_sharing,
                                                      disclosures_drivewealth_ira_agreement:disclosures_drivewealth_ira_agreement,
                                                      disclosures_drivewealth_market_data_agreement:disclosures_drivewealth_market_data_agreement,
                                                      disclosures_drivewealth_privacy_policy:disclosures_drivewealth_privacy_policy,
                                                      disclosures_drivewealth_terms_of_use:disclosures_drivewealth_terms_of_use,
                                                      disclosures_extended_hours_agreement: nil,
                                                      disclosures_rule14b:disclosures_rule14b,
                                                      disclosures_signed_by:disclosures_signed_by,
                                                      email_address:email_address,
                                                      employment_affiliated_with_a_broker:employment_affiliated_with_a_broker,
                                                      employment_company_name:employment_company_name,
                                                      employment_is_director_of_a_public_company:employment_is_director_of_a_public_company,
                                                      employment_position:employment_position,
                                                      employment_status:employment_status,
                                                      employment_type:employment_type,
                                                      first_name:first_name,
                                                      gender:gender,
                                                      investor_profile_annual_income:investor_profile_annual_income,
                                                      investor_profile_experience:investor_profile_experience,
                                                      investor_profile_net_worth_liquid:investor_profile_net_worth_liquid,
                                                      investor_profile_net_worth_total:investor_profile_net_worth_total,
                                                      investor_profile_objectives:investor_profile_objectives,
                                                      investor_profile_risk_tolerance:investor_profile_risk_tolerance,
                                                      tax_treaty_with_us:tax_treaty_with_us,
                                                      tax_id_value:tax_id_value,
                                                      tax_id_type:tax_id_type,
                                                      profile_id:profileID,
                                                      politically_exposed_names:politically_exposed_names,
                                                      phone_number:phone_number,
                                                      marital_status:marital_status,
                                                      last_name:last_name,
                                                      language:language,
                                                      is_us_tax_payer:is_us_tax_payer,
                                                      irs_backup_withholdings_notified:irs_backup_withholdings_notified)
            network.perform(mutation: mutation) { result in
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
    
    /// Upload file from 'getUrlForDocument' with params
    /// - Parameters:
    ///   - fileID: ID from getUrlForDocument
    ///   - type: Doc type
    ///   - side: Doc side
    /// - Returns: Upload status
    func kycSendUploadDocument(fileID: Int, type: FormType, side: FormSide) async throws -> KycAddDocumentMutation.Data.KycAddDocument {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation {[weak userProfile] continuation in
            network.perform(mutation: KycAddDocumentMutation.init(profile_id: profileID, uploaded_file_id: fileID, type: type.rawValue, side: side.rawValue)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.kycAddDocument else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    userProfile?.resetKycStatus()
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
    func getFundingAccounts(isMock: Bool = false) async -> [PlaidFundingAccount] {
        guard let profileID = userProfile.profileID else {
            return [PlaidFundingAccount]()
        }
        guard !isMock else {
            return (1...3).map({_ in PlaidFundingAccount.demo()})
        }
        return await
        withCheckedContinuation { continuation in
            network.fetch(query: TradingGetFundingAccountsQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let accounts = graphQLResult.data?.appTradingFundingAccounts.compactMap({PlaidFundingAccount.init(id:$0.id, balance: $0.balance, name: $0.name)}) else {
                        continuation.resume(returning: [PlaidFundingAccount]())
                        return
                    }
                    continuation.resume(returning: accounts)
                case .failure(let _):
                    continuation.resume(returning: [PlaidFundingAccount]())
                }
            }
        }
    }
    
    /// Get funding acccount for transactions *with* balance reload
    /// - Parameter isMock: is demo data returned
    /// - Returns: list of accounts
    func getFundingAccountsWithBalanceReload(isMock: Bool = false) async -> [PlaidFundingAccount] {
        guard let profileID = userProfile.profileID else {
            return [PlaidFundingAccount]()
        }
        guard !isMock else {
            return (1...3).map({_ in PlaidFundingAccount.demo()})
        }
        return await
        withCheckedContinuation { continuation in
            network.fetch(query: TradingGetFundingAccountsWithUpdatedBalanceQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let accounts = graphQLResult.data?.tradingGetFundingAccounts?.compactMap({$0?.fundingAccount}).compactMap({PlaidFundingAccount.init(id:$0.id, balance: $0.balance, name: $0.name)}) else {
                        continuation.resume(returning: [PlaidFundingAccount]())
                        return
                    }
                    continuation.resume(returning: accounts)
                case .failure(_):
                    continuation.resume(returning: [PlaidFundingAccount]())
                }
            }
        }
    }
    
    /// Delete funding account
    /// - Parameter account: account to delete
    /// - Returns: true/false
    func deleteFundingAccount(account: GainyFundingAccount) async throws -> TradingDeleteFundingAccountMutation.Data.TradingDeleteFundingAccount {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.perform(mutation: TradingDeleteFundingAccountMutation.init(profile_id: profileID, funding_account_id: account.id)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.tradingDeleteFundingAccount else {
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
        withCheckedThrowingContinuation {[weak userProfile] continuation in
            network.perform(mutation: TradingDepositFundsMutation.init(profile_id: profileID, amount: amount, funding_account_id: fundingAccountId)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.tradingDepositFunds else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    userProfile?.resetKycStatus()
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
    
    /// Change TTF amount
    /// - Parameters:
    ///   - collectionId: TTF ID
    ///   - delta: delta amount
    ///   - fundingAccountId: Funding account ID
    /// - Returns: result of change
    func ttfChangeFunds(collectionId: Int, delta: Double, fundingAccountId: Int) async throws -> TtfTradingWithdrawFundsMutation.Data.TradingReconfigureCollectionHolding {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.perform(mutation: TtfTradingWithdrawFundsMutation.init(profile_id: profileID, collection_id: collectionId, weights: [], target_amount_delta: delta)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let formData = graphQLResult.data?.tradingReconfigureCollectionHoldings else {
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
    
    //MARK: - Plaid
        
    private let plaidRedirectUri = "https://app.gainy.application.ios"
    private let plaidPurpose = "trading"
    
    /// Crating Plaid link
    /// - Returns: link token
    func createPlaidLink() async throws -> String {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            let query = CreatePlaidLinkQuery.init(profileId: profileID, redirectUri: plaidRedirectUri, env: "sandbox", purpose: plaidPurpose)
            network.fetch(query: query) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let linkToken = graphQLResult.data?.createPlaidLinkToken?.linkToken else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: linkToken)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    /// Link token and get accounts to link
    /// - Parameter publicToken: token from createPlaidLink
    /// - Returns: LinkPlaidAccount data
    func linkPlaidToken(publicToken: String) async throws -> LinkPlaidAccountQuery.Data.LinkPlaidAccount {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.fetch(query: LinkPlaidAccountQuery(profileId: profileID, publicToken: publicToken, env: "sandbox", purpose: plaidPurpose)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let linkData = graphQLResult.data?.linkPlaidAccount else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: linkData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    /// Relink using current token
    /// - Parameters:
    /// - Parameter publicToken: token from createPlaidLink
    ///   - accessTokenId:  current access token
    /// - Returns: LinkPlaidAccount data
    func reLinkPlaidToken(publicToken: String, accessTokenId: Int) async throws -> ReLinkPlaidAccountQuery.Data.LinkPlaidAccount {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation { continuation in
            network.fetch(query: ReLinkPlaidAccountQuery(profileId: profileID, accessTokenId: accessTokenId, publicToken: publicToken, env: "sandbox")) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let linkData = graphQLResult.data?.linkPlaidAccount else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: linkData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    func linkTradingAccount(accessToken: Int, plaidAccount: PlaidAccountToLink) async throws -> PlaidFundingAccount {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation {[weak userProfile] continuation in
            network.perform(mutation: TradingLinkBankAccountWithPlaidMutation.init(profile_id: profileID,
                                                                                   account_id: plaidAccount.accountId,
                                                                                   account_name: plaidAccount.name,
                                                                                   access_token_id: accessToken)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let account = graphQLResult.data?.tradingLinkBankAccountWithPlaid?.fundingAccount else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    let newAccount = PlaidFundingAccount.init(id: account.id,
                                                              balance: account.balance,
                                                              name: account.name)
                    userProfile?.addFundingAccount(newAccount)
                    userProfile?.resetKycStatus()
                    continuation.resume(returning: newAccount)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    //MARK: - Trade
    
    /// Buy/Sell TTF
    /// - Parameters:
    ///   - collectionId: TTF to use
    ///   - amountDelta: amount to buy/sell
    /// - Returns: true/false
    func reconfigureHolding(collectionId: Int, amountDelta: Double) async throws -> TtfTradingWithdrawFundsMutation.Data.TradingReconfigureCollectionHolding {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation {continuation in
            network.perform(mutation: TtfTradingWithdrawFundsMutation.init(profile_id: profileID, collection_id: collectionId, weights: [], target_amount_delta: amountDelta)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let res = graphQLResult.data?.tradingReconfigureCollectionHoldings else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: res)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    /// Gets TTF composition data for Invest Order Overview
    /// - Parameter collectionId: Collection ID
    /// - Returns: Array of weights
    func getTTFCompositionWeights(collectionId: Int) async throws -> [GetCollectionTickerActualWeightsQuery.Data.CollectionTickerActualWeight] {
        return try await
        withCheckedThrowingContinuation { continuation in
            network.fetch(query: GetCollectionTickerActualWeightsQuery.init(collection_id: collectionId)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let linkData = graphQLResult.data?.collectionTickerActualWeights else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: linkData)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    //MARK: - Verification
    
    enum VerificationChannel: String {
        case sms = "SMS"
        case email = "EMAIL"
    }
    
    /// Send verification code to specific channel
    /// - Parameters:
    ///   - channel: SMS or EMAIL
    ///   - address: phone number or email
    /// - Returns: Struct with code ID
    func sendVerifyMessageChannel(channel: VerificationChannel, address: String) async throws -> VerificationSendCodeMutation.Data.VerificationSendCode {
        guard let profileID = userProfile.profileID else {
            throw DWError.noProfileId
        }
        return try await
        withCheckedThrowingContinuation {continuation in
            network.perform(mutation: VerificationSendCodeMutation(profile_id: profileID, channel: channel.rawValue, address: address)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let res = graphQLResult.data?.verificationSendCode else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: res)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
    /// Verify code from sendVerifyMessageChannel
    /// - Parameters:
    ///   - verificationCodeID: code ID
    ///   - userInput: entered value
    /// - Returns: ok = true / false
    func verifyMessageChannel(verificationCodeID: String, userInput: String) async throws -> VerificationVerifyCodeMutation.Data.VerificationVerifyCode {
        return try await
        withCheckedThrowingContinuation {continuation in
            network.perform(mutation: VerificationVerifyCodeMutation(verification_code_id: verificationCodeID, user_input: userInput)) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let res = graphQLResult.data?.verificationVerifyCode else {
                        continuation.resume(throwing: DWError.noData)
                        return
                    }
                    continuation.resume(returning: res)
                case .failure(let error):
                    continuation.resume(throwing: DWError.loadError(error))
                }
            }
        }
    }
    
}

extension TradingLinkBankAccountWithPlaidMutation.Data.TradingLinkBankAccountWithPlaid.FundingAccount: GainyFundingAccount {
}

extension TradingHistoryFrag {
    
    //MARK: - FIX
    var date: Date {
        let formatter = ISO8601DateFormatter()
        // Insert .withFractionalSeconds to the current format.
        formatter.formatOptions.insert(.withFractionalSeconds)
        return formatter.date(from: (datetime ?? "")) ?? Date()
    }
}

