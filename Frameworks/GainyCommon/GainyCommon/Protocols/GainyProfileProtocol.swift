//
//  GainyProfileProtocol.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 20.10.2022.
//

import Foundation
import Combine

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

public enum KYCErrorCode: String {
    case ageValidation = "AGE_VALIDATION"
    case poorPhotoQuality = "POOR_PHOTO_QUALITY"
    case poorDocQuality = "POOR_DOC_QUALITY"
    case suspectedDocumentFraud = "SUSPECTED_DOCUMENT_FRAUD"
    case incorrectSide = "INCORRECT_SIDE"
    case noDocInImage = "NO_DOC_IN_IMAGE"
    case twoDocsUploaded = "TWO_DOCS_UPLOADED"
    case expiredDocument = "EXPIRED_DOCUMENT"
    case missingBack = "MISSING_BACK"
    case unsupportedDocument = "UNSUPPORTED_DOCUMENT"
    case dobNotMatchOnDoc = "DOB_NOT_MATCH_ON_DOC"
    case nameNotMatchOnDoc = "NAME_NOT_MATCH_ON_DOC"
    case invalidDocument = "INVALID_DOCUMENT"
    case addressNotMatch = "ADDRESS_NOT_MATCH"
    case ssnNotMatch = "SSN_NOT_MATCH"
    case dobNotMatch = "DOB_NOT_MATCH"
    case nameNotMatch = "NAME_NOT_MATCH"
    case sanctionWatchlist = "SANCTION_WATCHLIST"
    case sanctionOFAC = "SANCTION_OFAC"
    case invalidPhoneNumber = "INVALID_PHONE_NUMBER"
    case invalidEmailAddress = "INVALID_EMAIL_ADDRESS"
    case invalidNameTooLong = "INVALID_NAME_TOO_LONG"
    case unsupportedCountry = "UNSUPPORTED_COUNTRY"
    case agedAccount = "AGED_ACCOUNT"
    case accountIntegrity = "ACCOUNT_INTEGRITY"
    case unknown = "UNKNOWN"

    public var title: String {
        switch self {
        case .ageValidation:
            return "Date of Birth"
        case .poorPhotoQuality:
            return "Re-upload photo ID"
        case .poorDocQuality:
            return "Re-upload photo ID"
        case .suspectedDocumentFraud:
            return "Re-upload document"
        case .incorrectSide:
            return "Re-upload document"
        case .noDocInImage:
            return "Re-upload document"
        case .twoDocsUploaded:
            return "Re-upload document"
        case .expiredDocument:
            return "Re-upload document"
        case .missingBack:
            return "Re-upload document"
        case .unsupportedDocument:
            return "Re-upload document"
        case .dobNotMatchOnDoc:
            return "Date of Birth"
        case .nameNotMatchOnDoc:
            return "Legal name"
        case .invalidDocument:
            return "Re-upload document"
        case .addressNotMatch:
            return "Legal address"
        case .ssnNotMatch:
            return "Social Security Number"
        case .dobNotMatch:
            return "Date of Birth"
        case .nameNotMatch:
            return "Legal name"
        case .sanctionWatchlist:
            return "Sanction watchlist"
        case .sanctionOFAC:
            return "Sanction OFAC"
        case .invalidPhoneNumber:
            return "Invalid Phone number"
        case .invalidEmailAddress:
            return "Invalid Email address"
        case .invalidNameTooLong:
            return "Legal name"
        case .unsupportedCountry:
            return "Unsupported country"
        case .agedAccount:
            return "Aged account"
        case .accountIntegrity:
            return "Account integrity"
        case .unknown:
            return "Unknown"
        }
    }
}


public protocol GainyKYCStatus {
    var kycDone: Bool? {get set}
    var depositedFunds: Bool? {get set}
    var successfullyDepositedFunds: Bool? {get set}
    var buyingPower: Float? {get set}
    var accountNo: String?  {get set}
    var withdrawableCash: Float? {get set}
    var pendingCash: Float? {get set}
    var status: KYCStatus {get}
    var pendingOrdersAmount: Float? {get set}
    var pendingOrdersCount: Int? {get set}
    var kycErrorCodes: String? {get set}
    var kycStatus: String? {get set}
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
    public var errorCodes: [KYCErrorCode] {
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
