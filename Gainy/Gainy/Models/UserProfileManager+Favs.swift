//
//  UserProfileManager+Favs.swift
//  Gainy
//
//  Created by Anton Gubarenko on 29.01.2022.
//

import UIKit

extension UserProfileManager {
    func getFavCollections() async -> [RemoteShortCollectionDetails] {
        guard let profileID = self.profileID else {
            return [RemoteShortCollectionDetails]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetFavoriteCollectionsQuery(profileId: profileID)) {result in
                
                switch result {
                case .success(let graphQLResult):
                    
                    guard let collections = graphQLResult.data?.appProfileFavoriteCollections.compactMap({$0.collection?.fragments.remoteShortCollectionDetails}) else {
                        NotificationManager.shared.showError("Error fetching Fav Collections")
                        continuation.resume(returning: [RemoteShortCollectionDetails]())
                        return
                    }
                    continuation.resume(returning:collections)
                    
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    continuation.resume(returning: [RemoteShortCollectionDetails]())
                }
            }
        }
    }
    
    func getRecommenedCollections() async -> [RemoteShortCollectionDetails] {
        guard let profileID = self.profileID else {
            return [RemoteShortCollectionDetails]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: FetchRecommendedCollectionsQuery(profileId: profileID)) {result in
                
                switch result {
                case .success(let graphQLResult):
                    guard let collections = graphQLResult.data?.getRecommendedCollections?.compactMap({$0?.collection.fragments.remoteShortCollectionDetails}) else {
                        NotificationManager.shared.showError("Error fetching Recommended Collections")
                        continuation.resume(returning: [RemoteShortCollectionDetails]())
                        return
                    }
                    continuation.resume(returning:collections)
                case .failure(let error):
                    dprint("GetRecommenedCollections failed. Error: \(error)")
                    continuation.resume(returning: [RemoteShortCollectionDetails]())
                }
            }
        }
    }
}
