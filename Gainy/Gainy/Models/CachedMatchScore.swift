//
//  CachedMatchScore.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit
import CryptoKit

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
    
    init(remoteMatch: RemoteTickerDetails.MatchScore) {
        symbol = remoteMatch.symbol
        matchScore = remoteMatch.matchScore
        fitsRisk = remoteMatch.fitsRisk
        fitsCategories = remoteMatch.fitsCategories
        fitsInterests = remoteMatch.fitsInterests
        
        riskSimilarity = Double(remoteMatch.riskSimilarity)
        interestMatches = remoteMatch.interestMatches
        categoryMatches = remoteMatch.categoryMatches
    }   
    
    private func interests() async -> [TickerTag] {
        let matches = interestMatches.dropFirst().dropLast().replacingOccurrences(of: " ", with: "")
        if matches.isEmpty {
            return []
        } else {
            let ids = matches.components(separatedBy: ",").compactMap({Int($0)})
            if ids.count == 0 {
                return []
            } else {
                return await
                withCheckedContinuation { continuation in
                    Network.shared.apollo.fetch(query: GetSelectedInterestsQuery(ids: ids)){ result in
                        switch result {
                        case .success(let graphQLResult):
                            guard let appInterests = graphQLResult.data?.interests else {
                                continuation.resume(returning: [])
                                return
                            }
                            continuation.resume(returning: appInterests.compactMap({TickerTag(name: ($0.name ?? ""), url: $0.iconUrl ?? "", collectionID: -404, id: $0.id ?? -1)}))
                            break
                        case .failure(_):
                            continuation.resume(returning: [])
                            break
                        }
                    }
                }
            }
        }
    }
    
    private func categories() async -> [TickerTag] {
        let matches = categoryMatches.dropFirst().dropLast().replacingOccurrences(of: " ", with: "")
        if matches.isEmpty {
            return []
        } else {
            let ids = matches.components(separatedBy: ",").compactMap({Int($0)})
            if ids.count == 0 {
                return []
            } else {
                return await
                withCheckedContinuation { continuation in
                    Network.shared.apollo.fetch(query: GetSelectedCategoriesQuery(ids: ids)){ result in
                        switch result {
                        case .success(let graphQLResult):
                            guard let categories = graphQLResult.data?.categories else {
                                continuation.resume(returning: [])
                                return
                            }
                            continuation.resume(returning: categories.compactMap({TickerTag(name: ($0.name ?? ""), url: "", collectionID: -404, id: $0.id ?? -1)}))
                            break
                        case .failure(_):
                            continuation.resume(returning: [])
                            break
                        }
                    }
                }
                
            }
        }
    }
    
    func combinedTags() async -> [TickerTag] {
        async let interests = interests()
        async let categories = categories()
        var (interestsList, categoriesList) = await (interests, categories)
        interestsList.append(contentsOf: categoriesList)
        return interestsList
    }
}

extension Array where Element == TickerTag {
    func isInList(_ tag: Element) -> Bool {
        return self.firstIndex { el in
            el.id == tag.id
        } != nil
    }
}
