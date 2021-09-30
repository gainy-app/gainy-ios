//
//  DemoUserContainer.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit

final class UserProfileManager {
        
    static let shared = UserProfileManager()
        

    var favoriteCollections: [Int] = Array()
    
    var interests: [Int] = Array()
    
    var categories: [Int] = Array()
    
    var firstName: String?
    
    var lastName: String?
    
    var email: String?
    
    var address: String?
    
    var userID: String?
    
    var profileID: Int?
    
    var profileLoaded: Bool?
    
    public func cleanup() {
        
        favoriteCollections.removeAll()
        interests.removeAll()
        categories.removeAll()
        
        firstName = nil
        lastName = nil
        email = nil
        address = nil
        userID = nil
        profileID = nil
        profileLoaded = false
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
                
                print("Success \(graphQLResult)")
                guard let appProfile = graphQLResult.data?.appProfiles.first else {
                    NotificationManager.shared.showError("Sorry... Failed to load profile info.")
                    completion(false)
                    self.profileLoaded = false
                    return
                }
                self.favoriteCollections = appProfile.profileFavoriteCollections.map({ item in
                    item.collectionId
                })
                self.interests = appProfile.profileInterests.map({ item in
                    item.interestId
                })
                self.categories = appProfile.profileCategories.map({ item in
                    item.categoryId
                })
                
                self.firstName = appProfile.firstName
                self.lastName = appProfile.lastName
                self.email = appProfile.email
                self.address = appProfile.legalAddress
                self.userID = appProfile.userId
                self.profileLoaded = true
                completion(true)
                
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                self.profileLoaded = false
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
            print("\(result)")
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
            print("\(result)")
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

}
