//
//  CachedMatchScore.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit

struct CachedMatchScore: Codable {
    let symbol: String
    let matchScore: Int
    let fitsRisk: Int
    let fitsCategories: Int
    let fitsInterests: Int
    
    let riskSimilarity: Double
    let interestMatches: String
    let categoryMatches: String
    
    init(remoteMatch: LiveMatch) {
        symbol = remoteMatch.symbol
        matchScore = remoteMatch.matchScore
        fitsRisk = remoteMatch.fitsRisk
        fitsCategories = remoteMatch.fitsCategories
        fitsInterests = remoteMatch.fitsInterests
        
        riskSimilarity = remoteMatch.riskSimilarity
        interestMatches = remoteMatch.interestMatches ?? ""
        categoryMatches = remoteMatch.categoryMatches ?? ""
    }
    
    var interests: [RemoteTickerDetailsFull.TickerInterest] {
        []
    }
    
    var categories: [RemoteTickerDetailsFull.TickerCategory] {
        []
    }
}
