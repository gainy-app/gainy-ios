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
            return "The age calculated from the document's date of birth point is greater than or equal to the minimum accepted age set at the account level"
        case .poorPhotoQuality:
            return "Poor photo quality. ID may be too dark, damaged, blurry, cut off, or have a glare"
        case .poorDocQuality:
            return "Abnormal document quality. ID may have obscured data points, obscured security features, a corner removed, punctures, or watermarks obscured by digital text overlay"
        case .suspectedDocumentFraud:
            return "Tampering and forgery found on the document"
        case .incorrectSide:
            return "The incorrect side of the document had been uploaded. Choose the correct side of the document and re-upload"
        case .noDocInImage:
            return "No document was found in the image, or there is a blank image"
        case .twoDocsUploaded:
            return "Two different documents were submitted as the same document type"
        case .expiredDocument:
            return "Document is expired or invalid format of expiry date"
        case .missingBack:
            return "The back of the document is missing"
        case .unsupportedDocument:
            return "Document is not supported"
        case .dobNotMatchOnDoc:
            return "The DOB listed on the customer's ID is not the same DOB listed on the customer's application"
        case .nameNotMatchOnDoc:
            return "The Name on the customer's ID is not the same Name listed on the customer's application"
        case .invalidDocument:
            return "Unable to process your document. File is corrupted and can't be opened."
        case .addressNotMatch:
            return "No match found for address or invalid format in address"
        case .ssnNotMatch:
            return "No match found for Social Security Number"
        case .dobNotMatch:
            return "No match found for Date of Birth"
        case .nameNotMatch:
            return "No match found for firstName / lastName or invalid characters found"
        case .sanctionWatchlist:
            return "User is under sanction watchlist"
        case .sanctionOFAC:
            return "User is found in OFAC SDN list"
        case .invalidPhoneNumber:
            return "The phone number listed on the customer's application is not a valid number of digits for a phone number"
        case .invalidEmailAddress:
            return "The emailID listed on the customer's application is not valid or unable to verify in Watchlist."
        case .invalidNameTooLong:
            return "The first name or last name listed on the customer's application is not valid. First name or last name should not be greater than 36 characters."
        case .unsupportedCountry:
            return "The KYC is not supported in the country."
        case .agedAccount:
            return "KYC is not verified by user within 30 days"
        case .accountIntegrity:
            return "Account information provided may not be legitimate and/or is being used by multiple account holders"
        case .unknown:
            return "Unrecognized error"
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
