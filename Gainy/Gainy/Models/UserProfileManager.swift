//
//  DemoUserContainer.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit

struct AppProfileMetricsSetting {
    
    var id: Int
    var fieldName: String
    var collectionId: Int? = nil
    var order: Int
}

final class UserProfileManager {
        
    static let shared = UserProfileManager()
    weak var authorizationManager: AuthorizationManager?
    @UserDefaultArray(key: "favoriteCollections")
    var favoriteCollections: [Int]
    
    @UserDefault<BrokerData>("selectedBrokerToTrade")
    public var selectedBrokerToTrade: BrokerData?
    
    var favHash: String {
        favoriteCollections.compactMap({String($0)}).joined()
    }
    
    var profileMetricsSettings: [AppProfileMetricsSetting] = Array()
    
    var interests: [Int] = Array()
    
    var categories: [Int] = Array()
    
    var watchlist: [String] = Array()
    
    var firstName: String?
    
    var lastName: String?
    
    var email: String?
    
    var address: String?
    
    var userID: String?
    
    
    var profileID: Int?
    
    var profileLoaded: Bool?
    
    var isPlaidLinked: Bool = false
    var linkedPlaidAccessTokens: [Int] = Array()
    
    var linkedPlaidAccounts: [PlaidAccountData] = []
    
    /// Kind of data source for recommended collections and your collections
    var recommendedCollections: [Collection] = []
    var yourCollections: [Collection] = []
    
    public func cleanup() {
        
        favoriteCollections.removeAll()
        interests.removeAll()
        categories.removeAll()
        watchlist.removeAll()
        profileMetricsSettings.removeAll()
        
        firstName = nil
        lastName = nil
        email = nil
        address = nil
        userID = nil
        profileID = nil
        profileLoaded = false
        isPlaidLinked = false
    }
    
    public func fetchProfile(completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        Network.shared.apollo.clearCache()
        Network.shared.apollo.fetch(query: GetProfileQuery(profileID: profileID)){ [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let graphQLResult):
                
                dprint("Success \(graphQLResult)")
                guard let appProfile = graphQLResult.data?.appProfiles.first else {
                    NotificationManager.shared.showError("Sorry... Failed to load profile info.")
                    completion(false)
                    self.profileLoaded = false
                    return
                }
                guard let profileMetricsSettings = graphQLResult.data?.appProfileTickerMetricsSettings else {
                    NotificationManager.shared.showError("Sorry... Failed to load profile info.")
                    completion(false)
                    self.profileLoaded = false
                    return
                }
                
                if let profilePortfolioAccounts = graphQLResult.data?.appProfilePortfolioAccounts {
                    self.linkedPlaidAccounts = profilePortfolioAccounts.map({ item in
                        let result = PlaidAccountData.init(id: item.id, name: item.name)
                        return result
                    })
                }
            
                self.profileMetricsSettings = profileMetricsSettings.map({ item in
                    let result = AppProfileMetricsSetting.init(id: item.id, fieldName: item.fieldName, collectionId: item.collectionId, order: item.order)
                    return result
                })
                
                let oldFavs = self.favoriteCollections
                self.favoriteCollections = appProfile.profileFavoriteCollections.map({ item in
                    item.collectionId
                }).reorder(by: oldFavs)
                self.interests = appProfile.profileInterests.map({ item in
                    item.interestId
                })
                self.categories = appProfile.profileCategories.map({ item in
                    item.categoryId
                })
                self.watchlist = appProfile.profileWatchlistTickers.map({ item in
                    item.symbol
                })
                
                self.firstName = appProfile.firstName
                self.lastName = appProfile.lastName
                self.email = appProfile.email
                self.address = appProfile.legalAddress
                self.userID = appProfile.userId
                self.profileLoaded = true
                self.isPlaidLinked = appProfile.profilePlaidAccessTokens.count > 0
                self.linkedPlaidAccessTokens = appProfile.profilePlaidAccessTokens.map({ item in
                    item.id
                })
                
                completion(true)
                
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                self.profileLoaded = false
                completion(false)
            }
        }
    }
    
    public func getProfileCollections(loadProfile: Bool = false, completion: @escaping (Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            
            if let authorizationManager = self.authorizationManager {
                authorizationManager.refreshAuthorizationStatus { status in
                    if status == .authorizedFully {
                        guard self.profileID != nil else {
                            completion(false)
                            return
                        }
                        self.getProfileCollections(completion: completion)
                    } else {
                        completion(false)
                        return
                    }
                }
                return
            }
            completion(false)
            return
        }
        
        if (loadProfile) {
            Network.shared.apollo.clearCache()
            self.fetchProfile { success in
                
                guard success == true else {
                    NotificationManager.shared.showError("Sorry... No Collections to display.")
                    completion(false)
                    return
                }
                
                self.getProfileCollections(completion: completion)
            }
            return
        }
        
        
        Network.shared.apollo.fetch(query: FetchRecommendedCollectionsQuery(profileId: profileID)) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let graphQLResult):
                
                guard let collections = graphQLResult.data?.getRecommendedCollections?.compactMap({$0?.collection.fragments.remoteShortCollectionDetails}) else {
                    NotificationManager.shared.showError("Error fetching Recommended Collections")
                    completion(false)
                    return
                }
                
                guard let firstCollections = graphQLResult.data?.getRecommendedCollections?.compactMap({$0?.collection.fragments.remoteShortCollectionDetails}).prefix(24) else {
                    NotificationManager.shared.showError("Sorry... No Collections to display.")
                    completion(false)
                    return
                }
                
                self.recommendedCollections = firstCollections.map {
                    CollectionDTOMapper.map($0)
                }
                
                self.yourCollections = collections.filter({self.favoriteCollections.contains($0.id ?? 0)}).map {
                    CollectionDTOMapper.map($0)
                }.reorder(by: self.favoriteCollections)
                
                completion(true)
                
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion(false)
            }
        }
    }
    
    public func addFavouriteCollection(_ collectionID: Int, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = InsertProfileFavoriteCollectionMutation.init(profileID: profileID, collectionID: collectionID)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... Failed to sync inserted favourite collection.")
                completion(false)
                return
            }
            
            self.favoriteCollections.append(collectionID)
            completion(true)
        }
    }
    
    public func removeFavouriteCollection(_ collectionID: Int, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = DeleteProfileFavoriteCollectionMutation.init(profileID: profileID, collectionID: collectionID)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... Failed to sync deleted favourite collection.")
                completion(false)
                return
            }
            
            self.favoriteCollections.removeAll { element in
                element == collectionID
            }
            completion(true)
        }
    }

    
    public func addTickerToWatchlist(_ symbol: String, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = InsertTickerToWatchlistMutation(profileID: profileID, symbol: symbol)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... Failed to sync watchlist data")
                completion(false)
                return
            }
            
            self.watchlist.append(symbol)
            CollectionsManager.shared.loadWatchlistCollection {
                completion(true)
            }
        }
    }
    
    public func removeTickerFromWatchlist(_ symbol: String, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = DeleteTickerFromWatchlistMutation(profileID: profileID, symbol: symbol)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... Failed to sync watchlist data")
                completion(false)
                return
            }
            
            self.watchlist.removeAll { element in
                element == symbol
            }
            CollectionsManager.shared.loadWatchlistCollection {
                completion(true)
            }
        }
    }
    
    public func updateMetricsForTicker(_ f1: String,
                                       _ f2: String,
                                       _ f3: String,
                                       _ f4: String,
                                       _ f5: String,
                                       _ f6: String,
                                       completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = DeleteMetricsSessingsForTickerMutation.init(profileID: profileID)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            guard (try? result.get().data) != nil else {
//                NotificationManager.shared.showError("Sorry... Failed to sync metrics data")
                completion(false)
                return
            }
            
            let updateQuery = InsertMetricsSessingsForTickerMutation.init(profileID: profileID, f1: f1, f2: f2, f3: f3, f4: f4, f5: f5, f6: f6)
            Network.shared.apollo.perform(mutation: updateQuery) { updateResult in
                dprint("\(updateResult)")
                guard (try? updateResult.get().data) != nil else {
//                    NotificationManager.shared.showError("Sorry... Failed to sync metrics data")
                    completion(false)
                    return
                }
                
                self.fetchProfile(completion: completion)
            }
        }
    }
    
    public func updateMetricsForCollection(_ collectionID: Int,
                                           _ f1: String,
                                           _ f2: String,
                                           _ f3: String,
                                           _ f4: String,
                                           _ f5: String,
                                           completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = DeleteMetricsSessingsForCollectionMutation.init(profileID: profileID, collectionID: collectionID)
        Network.shared.apollo.perform(mutation: query) { result in
            dprint("\(result)")
            guard (try? result.get().data) != nil else {
//                NotificationManager.shared.showError("Sorry... Failed to sync metrics data")
                completion(false)
                return
            }
            
            let updateQuery = InsertMetricsSessingsForCollectionMutation.init(profileID: profileID, collectionID: collectionID,  f1: f1, f2: f2, f3: f3, f4: f4, f5: f5)
            Network.shared.apollo.perform(mutation: updateQuery) { updateResult in
                dprint("\(updateResult)")
                guard (try? updateResult.get().data) != nil else {
//                    NotificationManager.shared.showError("Sorry... Failed to sync metrics data")
                    completion(false)
                    return
                }
                
                self.fetchProfile(completion: completion)
            }
        }
    }
}
