//
//  APIModels+Async.swift
//  Gainy
//
//  Created by Anton Gubarenko on 10.01.2022.
//

import UIKit
import GainyAPI

extension Network {
    
    private func categories() async -> [TickerTag] {
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetSelectedCategoriesQuery(ids: [])){ result in
                switch result {
                case .success(let graphQLResult):
                    guard let categories = graphQLResult.data?.categories else {
                        continuation.resume(returning: [])
                        return
                    }
                    continuation.resume(returning: categories.compactMap({TickerTag(name: $0.name ?? "", url: "", collectionID: -404,
                                                                                    id: $0.id ?? -1)}))
                    break
                case .failure(_):
                    continuation.resume(returning: [])
                    break
                }
            }
        }        
    }
    
}
