//
//  CachedMatchScore.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit

struct CachedMatchScore: Codable {
    let symbol: String
    let isMatch: Bool
    let matchScore: Int
    let explanation: [String]
    
    init(remoteMatch: LiveMatch) {
        symbol = remoteMatch.symbol
        isMatch = remoteMatch.isMatch
        matchScore = remoteMatch.matchScore
        explanation = ["will be soon"]
    }
}
