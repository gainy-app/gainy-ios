//
//  ProfileInfo.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/20/21.
//

import Foundation

public final class ProfileInfoBuilder: NSObject {
    
    public var avatarURLString: String?
    public var firstName: String?
    public var lastName: String?
    public var email: String?
    public var gender: Int?
    public var legalAddress: String?
    public var userID: String?
    public var profileInterestIDs: [Int]?
    
    public var averageMarketReturn: Int? //  # 6, 15, 25, 50
    public var damageOfFailure: Float? // # 0 - ok, 1 - disaster
    public var ifMarketDrops20IWillBuy: Float? // # 0 - sell, 1 - buy
    public var ifMarketDrops40IWillBuy: Float? //# 0 - sell, 1 - buy
    public var investmentHorizon: Float? // # 0 - short, 1 - long
    public var riskLevel: Float? // # 0 - less risky, 1 - more reward
    public var stockMarketRiskLevel: String? // # one of ['very_risky', 'somewhat_risky', 'neutral', 'somewhat_safe', 'very_safe']
    public var tradingExperience: String? // # one of ['never_tried', 'very_little', 'companies_i_believe_in', 'etfs_and_safe_stocks', 'advanced', 'daily_trader', 'investment_funds', 'professional', 'dont_trade_after_bad_experience']
    public var unexpectedPurchasesSource: String? // # one of ['checking_savings', 'stock_investments', 'credit_card', 'other_loans']
    
    public func buildProfileInfo() -> ProfileInfo? {
        
        guard let avatarURLString = self.avatarURLString,
              let firstName = self.firstName,
              let lastName = self.lastName,
              let email = self.email,
              let gender = self.gender,
              let legalAddress = self.legalAddress,
              let userID = self.userID,
              let profileInterestIDs = self.profileInterestIDs,
              let averageMarketReturn = self.averageMarketReturn,
              let damageOfFailure = self.damageOfFailure,
              let ifMarketDrops20IWillBuy = self.ifMarketDrops20IWillBuy,
              let ifMarketDrops40IWillBuy = self.ifMarketDrops40IWillBuy,
              let investmentHorizon = self.investmentHorizon,
              let riskLevel = self.riskLevel,
              let stockMarketRiskLevel = self.stockMarketRiskLevel,
              let tradingExperience = self.tradingExperience,
              let unexpectedPurchasesSource = self.unexpectedPurchasesSource
        else {
            return nil
        }
        
        return ProfileInfo.init(avatarURLString: avatarURLString,
                                firstName: firstName,
                                lastName: lastName,
                                email: email,
                                gender: gender,
                                legalAddress: legalAddress,
                                userID: userID,
                                profileInterestIDs: profileInterestIDs,
                                averageMarketReturn: averageMarketReturn,
                                damageOfFailure: damageOfFailure,
                                ifMarketDrops20IWillBuy: ifMarketDrops20IWillBuy,
                                ifMarketDrops40IWillBuy: ifMarketDrops40IWillBuy,
                                investmentHorizon: investmentHorizon,
                                riskLevel: riskLevel,
                                stockMarketRiskLevel: stockMarketRiskLevel,
                                tradingExperience: tradingExperience,
                                unexpectedPurchasesSource: unexpectedPurchasesSource)
    }
}

public final class ProfileInfo: NSObject {
    
    public let avatarURLString: String
    public let firstName: String
    public let lastName: String
    public let email: String
    public var gender: Int
    public let legalAddress: String
    public let userID: String
    public let profileInterestIDs: [Int]
    
    public let averageMarketReturn: Int
    public let damageOfFailure: Float
    public let ifMarketDrops20IWillBuy: Float
    public let ifMarketDrops40IWillBuy: Float
    public let investmentHorizon: Float
    public let riskLevel: Float
    public let stockMarketRiskLevel: String
    public let tradingExperience: String
    public let unexpectedPurchasesSource: String
    
    init(avatarURLString: String,
         firstName: String,
         lastName: String,
         email: String,
         gender: Int,
         legalAddress: String,
         userID: String,
         profileInterestIDs: [Int],
         averageMarketReturn: Int,
         damageOfFailure: Float,
         ifMarketDrops20IWillBuy: Float,
         ifMarketDrops40IWillBuy: Float,
         investmentHorizon: Float,
         riskLevel: Float,
         stockMarketRiskLevel: String,
         tradingExperience: String,
         unexpectedPurchasesSource: String) {
        
        self.avatarURLString = avatarURLString
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.gender = gender
        self.legalAddress = legalAddress
        self.userID = userID
        self.profileInterestIDs = profileInterestIDs
        self.averageMarketReturn = averageMarketReturn
        self.damageOfFailure = damageOfFailure
        self.ifMarketDrops20IWillBuy = ifMarketDrops20IWillBuy
        self.ifMarketDrops40IWillBuy = ifMarketDrops40IWillBuy
        self.investmentHorizon = investmentHorizon
        self.riskLevel = riskLevel
        self.stockMarketRiskLevel = stockMarketRiskLevel
        self.tradingExperience = tradingExperience
        self.unexpectedPurchasesSource = unexpectedPurchasesSource
    }
}
