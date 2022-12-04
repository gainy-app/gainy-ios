//
//  DemoUserContainer.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit
import SwiftDate
import BugfenderSDK
import OneSignal
import RevenueCat
import Branch
import FirebaseAnalytics
import SwiftDate
import GainyAPI
import GainyCommon
import Combine
import StoreKit

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
    var favoriteCollections: [Int] {
        didSet {
            print("favoriteCollections \(favoriteCollections.first ?? -1)")
        }
    }
    
    @UserDefaultBool("collectionsReordered")
    var collectionsReordered: Bool
    
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
    
    var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")"
    }
    
    var email: String?
    
    var avatarUrl: String?
    
    var address: String?
    
    var userID: String?
    
    
    var profileID: Int?
    
    var profileLoaded: Bool?
    
    var isPlaidLinked: Bool = false
    var plaidNeed: String?
    
    @UserDefault<Date>("linkPlaidDate")
    var linkPlaidDate: Date?
    
    @UserDefault<Int>("linkPlaidID")
    var linkPlaidID: Int?
        
    var linkedPlaidAccounts: [PlaidAccountData] = []
    
    /// Kind of data source for recommended collections and your collections
    var recommendedCollections: [Collection] = []
    var yourCollections: [Collection] = []
    
    @KeychainDate("subscriptionExpiryDate")
    var subscriptionExpiryDate: Date?
    
    var isFromOnboard: Bool = false
    
    //Funding accounts
    var currentFundingAccounts: [GainyFundingAccount] = []
    let fundingAccountsPublisher = CurrentValueSubject<[GainyFundingAccount], Never>([])
    
    @UserDefault<Int>("selectedFundingAccountIndex")
    var selectedFundingAccountIndex: Int?
    
    var kycStatus: GainyKYCStatus?
    
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
        subscriptionExpiryDate = nil
    }
    
    private var configuration = Configuration()
    public func fetchProfile(completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        OneSignal.setExternalUserId("\(profileID)")
        SubscriptionManager.shared.storage.getViewedCollections()
        OneSignal.disablePush(false)
        
        if configuration.environment == .production {
            Branch.getInstance().setIdentity("\(profileID)")
        }
        Network.shared.apollo.clearCache()
        Network.shared.apollo.fetch(query: GetProfileQuery(profileID: profileID)){ [weak self] result in
            
            guard let self = self else {return}
            switch result {
            case .success(let graphQLResult):
                
                guard let appProfile = graphQLResult.data?.appProfiles.first else {
                    dprint("Err_GetProfileQuery_1: \(graphQLResult)")
                    NotificationManager.shared.showError("Sorry... Failed to load profile info.")
                    completion(false)
                    self.profileLoaded = false
                    return
                }
                guard let profileMetricsSettings = graphQLResult.data?.appProfileTickerMetricsSettings else {
                    dprint("Err_GetProfileQuery_2: \(graphQLResult)")
                    NotificationManager.shared.showError("Sorry... Failed to load profile info.")
                    completion(false)
                    self.profileLoaded = false
                    return
                }
            
                self.profileMetricsSettings = profileMetricsSettings.map({ item in
                    let result = AppProfileMetricsSetting.init(id: item.id, fieldName: item.fieldName, collectionId: item.collectionId, order: item.order)
                    return result
                })
                
                let oldFavs = self.favoriteCollections
                let remoteFavs = appProfile.profileFavoriteCollections.map({ item in
                    item.collectionId
                })
                self.favoriteCollections = remoteFavs.reorder(by: oldFavs)
                
                if let index = self.favoriteCollections.firstIndex(of: Constants.CollectionDetails.top20ID), self.favoriteCollections.count > 1 {
                    self.favoriteCollections.swapAt(index, 0)
                }
                
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
                OneSignal.setEmail(appProfile.email)
                Analytics.setUserID(appProfile.userId)
                SubscriptionManager.shared.setEmail(email: appProfile.email)
                SubscriptionManager.shared.setName(name: "\(appProfile.firstName) \(appProfile.lastName)")
                self.address = appProfile.legalAddress
                self.userID = appProfile.userId
                self.avatarUrl = appProfile.avatarUrl
                self.profileLoaded = true
                self.isPlaidLinked = appProfile.profilePlaidAccessTokens.count > 0
                if let date = (appProfile.subscriptionEndDate ?? "").toDate("yyyy-MM-dd'T'HH:mm:ssZ")?.date {
                    self.subscriptionExpiryDate = date
                } else {
                    if let date = (appProfile.subscriptionEndDate ?? "").toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ")?.date {
                        self.subscriptionExpiryDate = date
                    } else {
                        self.subscriptionExpiryDate = nil
                    }
                }
                self.linkedPlaidAccounts = appProfile.profilePlaidAccessTokens.map({ item in
                    let result = PlaidAccountData.init(id: item.id, institutionID: item.institution?.id ?? -1, name: item.institution?.name ?? "Broker", needReauthSince: item.needsReauthSince)
                    return result
                })
                
                Bugfender.setDeviceString("\(profileID)", forKey: "ProfileID")
                NotificationCenter.default.post(name: NSNotification.Name.didLoadProfile, object: nil)
                completion(true)
                
            case .failure(let error):
                dprint("Err_GetProfileQuery_3: \(error)")
                dprint("Failure when making GraphQL request. Error: \(error)")
                self.profileLoaded = false
                completion(false)
            }
        }
    }
    
    public func deleteProfile(completion: @escaping (Bool) -> Void) {
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = DeleteProfileMutation.init(profileID: profileID)
        DispatchQueue.global(qos: .background).async {
            Network.shared.apollo.perform(mutation: query) { result in
                guard (try? result.get().data) != nil else {
                    NotificationManager.shared.showError("Sorry... Something went wrong, please tyr again later.")
                    runOnMain {
                        completion(false)
                    }
                    return
                }
            
                runOnMain {
                    completion(true)
                }
            }
        }
        
    }
    
    public func setRecommendationSettings(interests: [Int?]?, categories: [Int?]?, recommendedCollectionsCount: Int?, completion: @escaping (Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = SetRecommendationSettingsMutation(profileId: profileID, interests: interests, categories: categories, recommended_collections_count: recommendedCollectionsCount)
        Network.shared.apollo.perform(mutation: query) { result in
            guard (try? result.get().data) != nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    public func getProfileCollections(loadProfile: Bool = false, forceReload: Bool = false, completion: @escaping (Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            
            if let authorizationManager = self.authorizationManager {
                authorizationManager.refreshAuthorizationStatus { status in
                    if status == .authorizedFully {
                        guard self.profileID != nil else {
                            completion(false)
                            return
                        }
                        self.getProfileCollections(forceReload: forceReload, completion: completion)
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
                    runOnMain {
                        NotificationManager.shared.showError("Sorry... Profile fetching failed.") {[weak self] in
                            self?.getProfileCollections(loadProfile: loadProfile, forceReload: forceReload, completion: completion)
                        }
                    }                    
                    completion(false)
                    return
                }
                
                self.getProfileCollections(forceReload: forceReload, completion: completion)
            }
            return
        }
        
        Task {
            async let favs = getFavCollections()
            async let recommeneded = self.getRecommenedCollectionsWithRetry(forceReload: forceReload)
            async let topTickers = CollectionsManager.shared.getGainers(profileId: profileID)
            let (favsRes, recommenededRes, topTickersRes) = await (favs, recommeneded, topTickers)
            let recommendedIDsRes = recommenededRes.compactMap({$0.id})
            dprint("favsRes \(favsRes.count)", profileId: 30)
            dprint("recommenededRes \(recommenededRes.count)", profileId: 30)
            dprint("recommendedIDsRes \(recommendedIDsRes)", profileId: 30)
            
            guard !recommenededRes.isEmpty else {
                dprint("getProfileCollections empty")
                reportNonFatal(.noCollections(reason: "getRecommenedCollectionsWithRetry returned []", suggestion: "recommenededRes is empty"))
                runOnMain {
                    NotificationManager.shared.showError("Sorry... No Collections to display.") {[weak self] in
                        self?.getProfileCollections(loadProfile: loadProfile, forceReload: forceReload, completion: completion)
                    }
                }
                await MainActor.run {
                    completion(false)
                }
                return
            }
            
            CollectionsManager.shared.topTickers = topTickersRes
            
            let firstCollections = recommenededRes.reorder(by: recommendedIDsRes).prefix(24)
            
            self.recommendedCollections = firstCollections.map {
                CollectionDTOMapper.map($0)
            }
            
            if let index = self.favoriteCollections.firstIndex(of: Constants.CollectionDetails.top20ID), self.favoriteCollections.count > 1 {
                self.favoriteCollections.swapAt(index, 0)
            }
            
            self.yourCollections = favsRes.map {
                CollectionDTOMapper.map($0)
            }.reorder(by: self.favoriteCollections)
            dprint("completion loading", profileId: 30)
            completion(true)
        }
        
    }
    
    public func addFavouriteCollection(_ collectionID: Int, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = InsertProfileFavoriteCollectionMutation.init(profileID: profileID, collectionID: collectionID)
        DispatchQueue.global(qos: .background).async {
            Network.shared.apollo.perform(mutation: query) { result in
                guard (try? result.get().data) != nil else {
                    NotificationManager.shared.showError("Sorry... Failed to sync inserted favourite collection.")
                    runOnMain {
                        completion(false)
                    }
                    return
                }
                
                if collectionID == Constants.CollectionDetails.top20ID {
                    self.favoriteCollections.insert(collectionID, at: 0)
                } else {
                    self.favoriteCollections.append(collectionID)
                }
                
                
                runOnMain {
                    NotificationManager.shared.increaseTTFsAdded()
                    completion(true)
                }
            }
        }
        
    }
    
    public func removeFavouriteCollection(_ collectionID: Int, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = DeleteProfileFavoriteCollectionMutation.init(profileID: profileID, collectionID: collectionID)
        Network.shared.apollo.perform(mutation: query) { result in
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
            completion(true)
        }
    }
    
    public func removeTickerFromWatchlist(_ symbol: String, completion: @escaping (_ success: Bool) -> Void) {
        
        guard let profileID = self.profileID else {
            completion(false)
            return
        }
        
        let query = DeleteTickerFromWatchlistMutation(profileID: profileID, symbol: symbol)
        Network.shared.apollo.perform(mutation: query) { result in
            guard (try? result.get().data) != nil else {
                NotificationManager.shared.showError("Sorry... Failed to sync watchlist data")
                completion(false)
                return
            }
            
            self.watchlist.removeAll { element in
                element == symbol
            }
            completion(true)
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
            guard (try? result.get().data) != nil else {
//                NotificationManager.shared.showError("Sorry... Failed to sync metrics data")
                completion(false)
                return
            }
            
            let updateQuery = InsertMetricsSessingsForTickerMutation.init(profileID: profileID, f1: f1, f2: f2, f3: f3, f4: f4, f5: f5, f6: f6)
            Network.shared.apollo.perform(mutation: updateQuery) { updateResult in
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
            guard (try? result.get().data) != nil else {
//                NotificationManager.shared.showError("Sorry... Failed to sync metrics data")
                completion(false)
                return
            }
            
            let updateQuery = InsertMetricsSessingsForCollectionMutation.init(profileID: profileID, collectionID: collectionID,  f1: f1, f2: f2, f3: f3, f4: f4, f5: f5)
            Network.shared.apollo.perform(mutation: updateQuery) { updateResult in
                guard (try? updateResult.get().data) != nil else {
//                    NotificationManager.shared.showError("Sorry... Failed to sync metrics data")
                    completion(false)
                    return
                }
                
                self.fetchProfile(completion: completion)
            }
        }
    }
    
    //MARK: - Porto Tricks
    
    private var plaidUpdateDate: Date?
    public func updatePlaidPortfolio() {
        guard let profileID = self.profileID else {
            return
        }
        guard plaidUpdateDate?.compare(toDate: Date(), granularity: .minute) != .orderedSame else {return}
        Network.shared.apollo.fetch(query: UpdatePlaidPortfolioQuery(profileId: profileID)){[weak self] _ in
            //print(result)
            self?.plaidUpdateDate = Date()
        }
    }
    
    //MARK: - Region
    
    @KeychainString("_userRegion")
    private var _userRegion: String?
    
    enum UserRegion: String {
        case us = "USA", non_us = "NON_USA"
    }
    
    /// Current or set User Region
    var userRegion: UserRegion {
        get {
            if let _userRegion {
                return _userRegion == UserRegion.us.rawValue ? .us : .non_us
            } else {
                let country = SKPaymentQueue.default().storefront?.countryCode
                return country == UserRegion.us.rawValue ? .us : .non_us
            }
        }
        set {
            _userRegion = newValue.rawValue
        }
    }
    
}
