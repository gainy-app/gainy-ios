//
//  AuthorizationManager.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/20/21.
//

import Foundation
import UIKit
import FirebaseAuth

enum AuthorizationError: Error, Equatable {

    case invalidStatusOnAuthorizeCall
    case unexpected(code: Int)
}

enum AuthorizationStatus: Int {
    
    case none = 0
    case authorizing = 1
    case authorizingFailed = 2
    case authorizingCancelled = 3
    case authorizedFully = 4
    case authorizedNeedCreateProfile = 5
    case notAuthorized = 6
}

final class AuthorizationManager {
    
    @UserDefaultAuthorizationStatus("AuthorizationStatus")
    private(set) var authorizationStatus: AuthorizationStatus
    
    private let appleAuth: AppleAuth = AppleAuth.init()
    private let googleAuth: GoogleAuth = GoogleAuth.init()
    private var completion: ((AuthorizationStatus) -> Void)?
    
    init() {
        
        self.updateAuthorizationStatus()
    }
    
    public func authorizeWithApple(completion: @escaping (_ authorizationStatus: AuthorizationStatus) -> Void) {
        
        self.signOut()
        self.completion = completion
        if self.authorizationStatus != .notAuthorized {
            self.callCompletion(false, AuthorizationError.invalidStatusOnAuthorizeCall)
            return
        }
        
        self.authorizationStatus = .authorizing
        self.appleAuth.signIn(nil) { success, error in
            
            self.callCompletion(success, error)
        }
    }
    
    public func authorizeWithGoogle(_ fromViewController: UIViewController, completion: @escaping (_ authorizationStatus: AuthorizationStatus) -> Void) {
        
        self.signOut()
        self.completion = completion
        if self.authorizationStatus != .notAuthorized {
            self.callCompletion(false, AuthorizationError.invalidStatusOnAuthorizeCall)
            return
        }
        
        self.authorizationStatus = .authorizing
        self.googleAuth.signIn(fromViewController) { success, error in
            
            self.callCompletion(success, error)
        }
    }
    
    public func signOut() {
        
        do {
            self.authorizationStatus = .notAuthorized
            if self.appleAuth.isAuthorized() {
                try self.appleAuth.signOut()
            } else if self.googleAuth.isAuthorized() {
                try self.googleAuth.signOut()
            }
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    public func finalizeSignUp(_ profileInfoBuilder: ProfileInfoBuilder, completion: @escaping (_ authorizationStatus: AuthorizationStatus) -> Void) {
        
        guard let profileInfo = profileInfoBuilder.buildProfileInfo() else {
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        
        if profileInfo.profileInterestIDs.count != 5 {
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        
        if self.authorizationStatus != .authorizedNeedCreateProfile {
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        
        let query = CreateAppProfileMutation(avatarURL: profileInfo.avatarURLString,
                                             email: profileInfo.email,
                                             firstName: profileInfo.firstName,
                                             gender: profileInfo.gender,
                                             lastName: profileInfo.lastName,
                                             userID: profileInfo.userID,
                                             legalAddress: profileInfo.legalAddress,
                                             interests0: profileInfo.profileInterestIDs[0],
                                             interests1: profileInfo.profileInterestIDs[1],
                                             interests2: profileInfo.profileInterestIDs[2],
                                             interests3: profileInfo.profileInterestIDs[3],
                                             interests4: profileInfo.profileInterestIDs[4],
                                             averageMarketReturn: profileInfo.averageMarketReturn,
                                             damageOfFailure: Double(profileInfo.damageOfFailure),
                                             marketLoss20: Double(profileInfo.ifMarketDrops20IWillBuy),
                                             marketLoss40: Double(profileInfo.ifMarketDrops40IWillBuy),
                                             investemtHorizon: Double(profileInfo.investmentHorizon),
                                             riskLevel: Double(profileInfo.riskLevel),
                                             stockMarketRiskLevel: profileInfo.stockMarketRiskLevel,
                                             tradingExperience: profileInfo.tradingExperience,
                                             unexpectedPurchaseSource: profileInfo.unexpectedPurchasesSource)
        
        Network.shared.apollo.perform(mutation: query) { result in
            
            guard (try? result.get().data) != nil else {
                self.authorizationStatus = .authorizingFailed
                completion(self.authorizationStatus)
                return
            }
          
            self.authorizationStatus = .authorizedFully
            completion(self.authorizationStatus)
        }
    }
    
    public func isAuthorized() -> Bool {
        
        return self.appleAuth.isAuthorized() || self.googleAuth.isAuthorized()
    }
    
    public func userID() -> String? {
        
        return Auth.auth().currentUser?.uid
    }
    
    private func callCompletion(_ success: Bool, _ error: Error?) {
        
        guard let completion = completion else {
            return
        }
     
        if(!success) {
            if let error = error as? GoogleAuthError {
                if error == GoogleAuthError.authorizationCancelled {
                    self.authorizationStatus = .authorizingCancelled
                }
            } else if let error = error as? AppleAuthError {
                if error == AppleAuthError.authorizationCancelled {
                    self.authorizationStatus = .authorizingCancelled
                }
            } else if self.authorizationStatus != .authorizedNeedCreateProfile {
                self.authorizationStatus = .authorizingFailed
            }
            completion(self.authorizationStatus)
            return
        }
        guard let userID = Auth.auth().currentUser?.uid  else {
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        
        self.hasProfilesMatchingUserID(userID: userID) { hasProfiles in
            
            if (hasProfiles) {
                self.authorizationStatus = .authorizedFully
                completion(self.authorizationStatus)
                return
            }
            
            self.authorizationStatus = .authorizedNeedCreateProfile
            completion(self.authorizationStatus)
        }
    }
    
    private func updateAuthorizationStatus() {
        
        guard let userID = Auth.auth().currentUser?.uid  else {
            self.authorizationStatus = .notAuthorized
            return
        }
        
        self.hasProfilesMatchingUserID(userID: userID) { hasProfiles in
            
            if (hasProfiles) {
                self.authorizationStatus = .authorizedFully
                return
            }
            
            self.authorizationStatus = .authorizedNeedCreateProfile
        }
    }
    
    private func hasProfilesMatchingUserID(userID: String, completion: @escaping (_ success: Bool) -> Void) {
        
        Network.shared.apollo.fetch(query: AppProfilesUserIDsQuery()) { [weak self] result in
            guard self != nil else {
                completion(false)
                return
            }
            switch result {
            case .success(let graphQLResult):
                
                guard let appProfiles = graphQLResult.data?.appProfiles else {
                    NotificationManager.shared.showError("Sorry... No Collections to display.")
                    completion(false)
                    return
                }
                
                let filteredProfiles = appProfiles.filter { profile in
                    profile.userId == userID
                }
                completion(filteredProfiles.count > 0)
                
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                NotificationManager.shared.showError("Sorry... Something went wrong. Please, try again later.")
                completion(false)
            }
        }
    }
    
}
