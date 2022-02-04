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
    
    /// Get Rec Colls with retry
    /// - Returns: list of cols or empty list
    func getRecommenedCollectionsWithRetry() async -> [RemoteShortCollectionDetails] {
        var recs = await getRecommenedCollections()
        if recs.isEmpty {
            recs = await getRecommenedCollections()
            if recs.isEmpty {
                return await getRecommenedCollections()
            } else {
                return [RemoteShortCollectionDetails]()
            }
        } else {
            return recs
        }
    }
    
    func getRecommenedCollections() async -> [RemoteShortCollectionDetails] {
        guard let profileID = self.profileID else {
            dprint("Err_FetchRecommendedCollectionsQuery_1 [No profile ID]")
            return [RemoteShortCollectionDetails]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: FetchRecommendedCollectionsQuery(profileId: profileID)) {result in
                
                switch result {
                case .success(let graphQLResult):
                    guard let collections = graphQLResult.data?.getRecommendedCollections?.compactMap({$0?.collection.fragments.remoteShortCollectionDetails}) else {
                        dprint("Err_FetchRecommendedCollectionsQuery_2 \(graphQLResult)")
                        continuation.resume(returning: [RemoteShortCollectionDetails]())
                        return
                    }
                    dprint("FetchRecommendedCollectionsQuery_Done")
                    continuation.resume(returning:collections)
                case .failure(let error):
                    dprint("Err_FetchRecommendedCollectionsQuery_3 Error: \(error)")
                    continuation.resume(returning: [RemoteShortCollectionDetails]())
                }
            }
        }
    }
}
