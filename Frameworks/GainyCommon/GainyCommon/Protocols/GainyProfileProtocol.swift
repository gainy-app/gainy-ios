//
//  GainyProfileProtocol.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 20.10.2022.
//

import Foundation
import Combine
import GainyAPI

public protocol TradingHistoryData {
    
    //TODO: Borysov - fill with properties
}

public protocol AppTradingMoneyFlow {
    
    var amount: Float? {get set}

    var createdAt: String {get set}
}

public protocol GainyFundingAccount {
    var id: Int {get set}
    var balance: Float? {get set}
    var name: String? {get set}
    var needsReauth: Bool {get set}
    init(id: Int, balance: Float?, name: String?)
}

public enum KYCStatus: String {
    case notReady = "NOT_READY"
    case ready = "READY"
    case processing = "PROCESSING"
    case approved = "APPROVED"
    case infoRequired = "INFO_REQUIRED"
    case docRequired = "DOC_REQUIRED"
    case manualReview = "MANUAL_REVIEW"
    case denied = "DENIED"
}

public enum KYCErrorCode: String, Codable {
    case ageValidation = "AGE_VALIDATION"
    var title: String {
        switch self {
        case .ageValidation:
            return "The age calculated from the documents date of birth point is greater than or equal to the minimum accepted age set at the account level"
        }
    }
}

public protocol GainyKYCStatus {
    var kycDone: Bool? {get set}
    var depositedFunds: Bool? {get set}
    var buyingPower: Float? {get set}
    var accountNo: String?  {get set}
    var withdrawableCash: Float? {get set}
    var pendingCash: Float? {get set}
    var status: KYCStatus {get}
    var pendingOrdersAmount: Float? {get set}
    var pendingOrdersCount: Int? {get set}
    var kycErrorCodes: String? {get set}
}

extension GainyKYCStatus {
    /// Do we have Pending Orders Amount
    public var havePendingOrders: Bool {
        if let pendingOrdersAmount {
            return pendingOrdersAmount > 0.0
        }
        return false
    }
    
    public var have: Bool {
        if let buyingPower {
            return buyingPower > 0.0
        }
        return false
    }
    
    /// Hoem banner error codes
    var errorCodes: [KYCErrorCode] {
        if let kycErrorCodes {
            let components = kycErrorCodes.components(separatedBy: ",")
            return components.compactMap({KYCErrorCode.init(rawValue: $0)})
        }
        return []
    }
}

public protocol GainyProfileProtocol: AnyObject {
    var profileID: Int? {get}
    var plaidEnv: String {get}
    var plaidRedirectUri: String {get}
    
    //MARK: - Funding Accounts
    var currentFundingAccounts: [GainyFundingAccount] {get set}
    var selectedFundingAccount: GainyFundingAccount? {get set}
    var firstNameRepresentale: String? { get }
    
    @discardableResult func getFundingAccounts() async -> [GainyFundingAccount]
    @discardableResult func getFundingAccountsWithBalanceReload() async -> [GainyFundingAccount]
    
    func addFundingAccount(_ account: GainyFundingAccount)
    func deleteFundingAccount(_ account: GainyFundingAccount)
    var fundingAccountsPublisher: CurrentValueSubject<[GainyFundingAccount], Never> {get}
    
    //MARK: - KYC Info
    
    @discardableResult func getProfileStatus() async -> GainyKYCStatus?
    func resetKycStatus()
    
    //MARK: - Trading History
    
    @discardableResult func getProfileTradingHistory(types: [String]) async -> [TradingHistoryData]
}
