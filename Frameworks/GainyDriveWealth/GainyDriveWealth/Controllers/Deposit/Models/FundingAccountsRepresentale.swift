//
//  FundingAccountsRepresentale.swift
//  GainyDriveWealth
//
//  Created by Евгений Таран on 1.11.22.
//

import Foundation

struct FundingAccountRepresentale: Codable, Equatable {
    let id: Int
    let name: String?
    
    static func == (lhs: FundingAccountRepresentale, rhs: FundingAccountRepresentale) -> Bool {
        return lhs.id == rhs.id
    }
}
