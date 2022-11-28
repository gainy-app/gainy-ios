//
//  GainyProfileProtocol.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 20.10.2022.
//

import Foundation
import Combine

public protocol GainyFundingAccount {
    var id: Int {get set}
    var balance: Float? {get set}
    var name: String? {get set}
    
    init(id: Int, balance: Float?, name: String?)
}

public protocol GainyKYCStatus {
    var kycDone: Bool? {get set}
    var depositedFunds: Bool? {get set}
    var buyingPower: Float? {get set}
    var accountNo: String?  {get set}
    var withdrawableCash: Float? {get set}
    var pendingCash: Float? {get set}
}

public protocol GainyProfileProtocol: AnyObject {
    var profileID: Int? {get}
    
    //MARK: - Funding Accounts
    var currentFundingAccounts: [GainyFundingAccount] {get set}
    var selectedFundingAccount: GainyFundingAccount? {get set}
    
    @discardableResult func getFundingAccounts() async -> [GainyFundingAccount]
    @discardableResult func getFundingAccountsWithBalanceReload() async -> [GainyFundingAccount]
    
    func addFundingAccount(_ account: GainyFundingAccount)
    
    var fundingAccountsPublisher: CurrentValueSubject<[GainyFundingAccount], Never> {get}
    
    //MARK: - KYC Info
    
    @discardableResult func getProfileStatus() async -> GainyKYCStatus?
    func resetKycStatus()
}
