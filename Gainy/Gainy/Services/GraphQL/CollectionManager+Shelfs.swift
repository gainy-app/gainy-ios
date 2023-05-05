//
//  CollectionManager+Shelfs.swift
//  Gainy
//
//  Created by Anton Gubarenko on 05.05.2023.
//

import UIKit
import GainyAPI

enum DiscoverySection: String, Codable {
    case bear, flat, bull
}

typealias DiscoverySectionCollection = GetDiscoverySectionCollectionsQuery.Data.SectionCollection

extension DiscoverySectionCollection {
    
    var discoverySection: DiscoverySection {
        DiscoverySection.init(rawValue: sectionId ?? "bear") ?? .bear
    }
}

extension CollectionsManager {
    
    /// Get 2 sections for collection
    /// - Returns: all collections for the shelfs
    @discardableResult func getShelfCollections() async -> [DiscoverySectionCollection] {
        guard let profileID = UserProfileManager.shared.profileID else {
            return [DiscoverySectionCollection]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: GetDiscoverySectionCollectionsQuery.init(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.sectionCollections else {
                        continuation.resume(returning: [DiscoverySectionCollection]())
                        return
                    }
                    continuation.resume(returning: status)
                case .failure(_):
                    continuation.resume(returning: [DiscoverySectionCollection]())
                }
            }
        }
    }
}
