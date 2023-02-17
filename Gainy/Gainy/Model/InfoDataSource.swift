//
//  InfoDataSource.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/22/21.
//

import Foundation

enum InfoDataSourceType: Int, Codable {
    
    case Interst
    case Category
    
    static let securityTypeToIconURL: Dictionary<String,String> = [
        "cash"          : "https://gainy.s3.amazonaws.com/security_types/icon+Cash.png",
        "derivative"    : "https://gainy.s3.amazonaws.com/security_types/icon+Derivative.png",
        "equity"        : "https://gainy.s3.amazonaws.com/security_types/icon+ETF-1.png",
        "etf"           : "https://gainy.s3.amazonaws.com/security_types/icon+ETF.png",
        "fixed income"  : "https://gainy.s3.amazonaws.com/security_types/icon+Fixed+income.png",
        "loan"          : "https://gainy.s3.amazonaws.com/security_types/icon+Loan.png",
        "mutual fund"   : "https://gainy.s3.amazonaws.com/security_types/icon+Mutual+fund.png",
        "other"         : "https://gainy.s3.amazonaws.com/security_types/icon+Other.png"
    ]
}

struct InfoDataSource: Codable {
    
    let type: InfoDataSourceType
    let id: Int
    let title: String
    let iconURL: String
    let selected: Bool
}
