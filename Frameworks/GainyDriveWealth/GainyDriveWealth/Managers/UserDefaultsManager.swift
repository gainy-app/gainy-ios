//
//  UserDefaultsManager.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 1.11.22.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() { }
}

extension UserDefaultsManager {
    
    var selectedFundingAccount: FundingAccountRepresentale? {
        get { UserDefaults.standard[#function] }
        set { UserDefaults.standard[#function] = newValue }
    }
}
