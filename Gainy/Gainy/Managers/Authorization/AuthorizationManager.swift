//
//  AuthorizationManager.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/20/21.
//

import Foundation
import UIKit
import FirebaseAuth
import Branch
import OneSignal
import GainyAPI
import GainyCommon

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
    case authorizingFailed_EmailAlreadyInUse = 7
}

final class AuthorizationManager {
    
    @UserDefaultAuthorizationStatus("AuthorizationStatus")
    private(set) var authorizationStatus: AuthorizationStatus
    
    @KeychainString("firebaseAuthToken")
    private(set) var firebaseAuthToken: String?
    
    public var firstName: String? {
        get {
            if appleAuth.isAuthorized() {
                return appleAuth.firstName
            } else if googleAuth.isAuthorized() {
                return googleAuth.firstName
            }
            return nil
        }
    }
    
    public var lastName: String? {
        get {
            if appleAuth.isAuthorized() {
                return appleAuth.lastName
            } else if googleAuth.isAuthorized() {
                return googleAuth.lastName
            }
            return nil
        }
    }
    
    public var email: String? {
        get {
            if appleAuth.isAuthorized() {
                return appleAuth.email
            } else if googleAuth.isAuthorized() {
                return googleAuth.email
            }
            return nil
        }
    }
    
    private let appleAuth: AppleAuth = AppleAuth.init()
    private let googleAuth: GoogleAuth = GoogleAuth.init()
    private var completion: ((AuthorizationStatus) -> Void)?
    
    init() {
        
    }
    
    public func refreshAuthorizationStatus(completion: @escaping (_ authorizationStatus: AuthorizationStatus) -> Void) {
        
        self.updateAuthorizationStatus {
            
            completion(self.authorizationStatus)
        }
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
    
    public func resetStatus() {
        
        self.authorizationStatus = .none
    }
    
    private var configuration = Configuration()
    public func signOut() {
        
        do {
            self.authorizationStatus = .notAuthorized
            if self.appleAuth.isAuthorized() {
                try self.appleAuth.signOut()
            } else if self.googleAuth.isAuthorized() {
                try self.googleAuth.signOut()
            }
            UserProfileManager.shared.selectedBrokerToTrade = nil;
            self.firebaseAuthToken = nil
            UserProfileManager.shared.cleanup()
            CollectionsManager.shared.collections = []
            CollectionsManager.shared.watchlistCollection = nil
            NotificationCenter.default.post(name: NSNotification.Name.didReceiveFirebaseAuthToken, object: nil)
            OneSignal.disablePush(true)
            
            if configuration.environment == .production {
                Branch.getInstance().logout()
            }
        } catch let signOutError as NSError {
            dprint("Error signing out: %@", signOutError)
        }
    }
    
    public func finalizeSignUpNoOnboarding(profileInfoBuilder: ProfileInfoBuilder, completion: @escaping (_ authorizationStatus: AuthorizationStatus) -> Void) {
        
        guard let profileInfo = profileInfoBuilder.buildProfileInfo() else {
            GainyAnalytics.logEvent("sign_up_failed_missing_full_profile_info", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        
        self.authorizationStatus = .authorizedNeedCreateProfile
        let query = CreateAppProfileNoOnboardingMutation(email: profileInfo.email,
                                                         firstName: profileInfo.firstName,
                                                         lastName: profileInfo.lastName,
                                                         userID: profileInfo.userID)
        Network.shared.apollo.clearCache()
        Network.shared.apollo.perform(mutation: query) { result in

            if let error = (try? result.get().errors?.first) {

                let extensions: [String : Any]? = error.extensions
                let code: String? = extensions?["code"] as? String
                if let code = code, code == "constraint-violation" {
                    let message = error.message
                    if let message = message, message.contains("profile_email_key") {
                        self.authorizationStatus = .authorizingFailed;
                        GainyAnalytics.logEvent("sign_up_failed_email_already_in_use", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                        completion(.authorizingFailed_EmailAlreadyInUse)
                        return
                    }
                }

                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_server_error", params: ["error" : "\(error.description)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }

            guard let resultData = (try? result.get().data) else {
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_no_resultData", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }
            guard let insert_app_profiles = resultData.resultMap["insert_app_profiles"] as? [String : Any] else  {
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_no_insert_app_profiles", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }
            guard let returning = (insert_app_profiles["returning"] as? [Any])?.first else {
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_no_returning", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }
            guard let profileID = ((returning as? [String : Any?])?["id"]) as? Int else {
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_no_profileID", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }

            GainyAnalytics.logEvent("sign_up_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
            UserProfileManager.shared.profileID = profileID

            UserProfileManager.shared.setRecommendationSettings(interests: [], categories: nil, recommendedCollectionsCount: 0) { success in
                if success {
                    GainyAnalytics.logEvent("set_recommendation_settings_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                } else {
                    GainyAnalytics.logEvent("set_recommendation_settings_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                }
                UserProfileManager.shared.fetchProfile { success in
                    guard success == true else {
                        GainyAnalytics.logEvent("fetch_profile_after_sign_up_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                        self.authorizationStatus = .authorizingFailed
                        completion(self.authorizationStatus)
                        return
                    }
                    GainyAnalytics.logEvent("fetch_profile_after_sign_up_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                    NotificationCenter.default.post(name: NotificationManager.userSignUpNotification, object: nil)
                    DeeplinkManager.shared.redeemInvite()
                    self.authorizationStatus = .authorizedFully
                    NotificationManager.shared.cancelSignUpReminderNotification()
                    completion(self.authorizationStatus)
                }
            }
        }
    }
    
    public func finalizeSignUp(profileInfoBuilder: ProfileInfoBuilder, onboardingInfoBuilder: OnboardingInfoBuilder, completion: @escaping (_ authorizationStatus: AuthorizationStatus) -> Void) {
        
        guard let profileInfo = profileInfoBuilder.buildProfileInfo(),
            let onboardingInfo = onboardingInfoBuilder.buildOnboardingInfo() else {
                if profileInfoBuilder.buildProfileInfo() == nil {
                    GainyAnalytics.logEvent("sign_up_failed_missing_full_profile_info", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                }
                if onboardingInfoBuilder.buildOnboardingInfo() == nil {
                    GainyAnalytics.logEvent("sign_up_failed_missing_full_onboarding_info", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                }
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        
        if onboardingInfo.profileInterestIDs.count < 1 {
            GainyAnalytics.logEvent("sign_up_failed_missing_onboarding_interests", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        
        let appInterests: [app_profile_interests_insert_input]! = onboardingInfo.profileInterestIDs.map { interestID in
            return app_profile_interests_insert_input.init(interestId: interestID, profile: nil, profileId: nil)
        }
        self.authorizationStatus = .authorizedNeedCreateProfile
        let query = CreateAppProfileMutation(avatarURL: profileInfo.avatarURLString,
                                             email: profileInfo.email,
                                             firstName: profileInfo.firstName,
                                             gender: profileInfo.gender,
                                             lastName: profileInfo.lastName,
                                             userID: profileInfo.userID,
                                             legalAddress: profileInfo.legalAddress,
                                             interests: appInterests,
                                             averageMarketReturn: onboardingInfo.averageMarketReturn,
                                             damageOfFailure: Double(onboardingInfo.damageOfFailure),
                                             marketLoss20: Double(onboardingInfo.ifMarketDrops20IWillBuy),
                                             marketLoss40: Double(onboardingInfo.ifMarketDrops40IWillBuy),
                                             investemtHorizon: Double(onboardingInfo.investmentHorizon),
                                             riskLevel: Double(onboardingInfo.riskLevel),
                                             stockMarketRiskLevel: onboardingInfo.stockMarketRiskLevel,
                                             tradingExperience: onboardingInfo.tradingExperience,
                                             unexpectedPurchaseSource: onboardingInfo.unexpectedPurchasesSource)
        Network.shared.apollo.clearCache()
        Network.shared.apollo.perform(mutation: query) { result in
            
            if let error = (try? result.get().errors?.first) {
                
                let extensions: [String : Any]? = error.extensions
                let code: String? = extensions?["code"] as? String
                if let code = code, code == "constraint-violation" {
                    let message = error.message
                    if let message = message, message.contains("profile_email_key") {
                        self.authorizationStatus = .authorizingFailed;
                        GainyAnalytics.logEvent("sign_up_failed_email_already_in_use", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                        completion(.authorizingFailed_EmailAlreadyInUse)
                        return
                    }
                }
                
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_server_error", params: ["error" : "\(error.description)", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }
            
            guard let resultData = (try? result.get().data) else {
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_no_resultData", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }
            guard let insert_app_profiles = resultData.resultMap["insert_app_profiles"] as? [String : Any] else  {
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_no_insert_app_profiles", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }
            guard let returning = (insert_app_profiles["returning"] as? [Any])?.first else {
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_no_returning", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }
            guard let profileID = ((returning as? [String : Any?])?["id"]) as? Int else {
                self.authorizationStatus = .authorizingFailed
                GainyAnalytics.logEvent("sign_up_failed_no_profileID", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                completion(self.authorizationStatus)
                return
            }
            
            GainyAnalytics.logEvent("sign_up_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
            UserProfileManager.shared.profileID = profileID
            
            UserProfileManager.shared.setRecommendationSettings(interests: onboardingInfo.profileInterestIDs, categories: nil, recommendedCollectionsCount: 0) { success in
                if success {
                    GainyAnalytics.logEvent("set_recommendation_settings_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                } else {
                    GainyAnalytics.logEvent("set_recommendation_settings_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                }
                UserProfileManager.shared.fetchProfile { success in
                    guard success == true else {
                        GainyAnalytics.logEvent("fetch_profile_after_sign_up_failed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                        self.authorizationStatus = .authorizingFailed
                        completion(self.authorizationStatus)
                        return
                    }
                    GainyAnalytics.logEvent("fetch_profile_after_sign_up_success", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SignUpView"])
                    NotificationCenter.default.post(name: NotificationManager.userSignUpNotification, object: nil)
                    DeeplinkManager.shared.redeemInvite()
                    self.authorizationStatus = .authorizedFully
                    NotificationManager.shared.cancelSignUpReminderNotification()
                    completion(self.authorizationStatus)
                }
            }
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
                switch error {
                case .inconsistencyCall:
                    reportNonFatal(.authFailed(reason: "GoogleAuthError.inconsistencyCall", suggestion: "fromViewController is nil - there is no view controller to present login UI from"))
                    self.authorizationStatus = .authorizingFailed
                case .noUser:
                    reportNonFatal(.authFailed(reason: "GoogleAuthError.noUser", suggestion: "GIDGoogleUser is nil"))
                    self.authorizationStatus = .authorizingFailed
                case .noUserID:
                    reportNonFatal(.authFailed(reason: "GoogleAuthError.noUser", suggestion: "GIDGoogleUser.userID is nil"))
                    self.authorizationStatus = .authorizingFailed
                case .noClientID:
                    reportNonFatal(.authFailed(reason: "GoogleAuthError.noClientID", suggestion: "GIDGoogleUser.idToken is nil"))
                    self.authorizationStatus = .authorizingFailed
                case .noToken:
                    reportNonFatal(.authFailed(reason: "GoogleAuthError.noToken", suggestion: "Google auth didn't return us user token for some reason"))
                    self.authorizationStatus = .authorizingFailed
                case .authorizationFailed:
                    reportNonFatal(.authFailed(reason: "GoogleAuthError.authorizingFailed", suggestion: "Google auth failed internally for some reason"))
                    self.authorizationStatus = .authorizingFailed
                case .authorizationCancelled:
                    //reportNonFatal(.authFailed(reason: "GoogleAuthError.authorizingCancelled", suggestion: "Google auth is cancelled - valid case"))
                    self.authorizationStatus = .authorizingCancelled
                case .unexpected(let code):
                    reportNonFatal(.authFailed(reason: "GoogleAuthError.unexpected(\(code))", suggestion: "Google auth unexpected error with internal code"))
                    self.authorizationStatus = .authorizingFailed
                }
            } else if let error = error as? AppleAuthError {
                switch error {
                case .inconsistencyCall:
                    reportNonFatal(.authFailed(reason: "AppleAuthError.inconsistencyCall", suggestion: "A login callback was received, but no login request was sent."))
                    self.authorizationStatus = .authorizingFailed
                case .noToken:
                    reportNonFatal(.authFailed(reason: "AppleAuthError.noToken", suggestion: "Apple auth didn't return us user token for some reason"))
                    self.authorizationStatus = .authorizingFailed
                case .tokenDecodingError:
                    reportNonFatal(.authFailed(reason: "AppleAuthError.tokenDecodingError", suggestion: "Apple auth returned us invalid user token we are not able to decode"))
                    self.authorizationStatus = .authorizingFailed
                case .authorizationFailed:
                    reportNonFatal(.authFailed(reason: "AppleAuthError.authorizationFailed", suggestion: "Apple auth failed internally for some reason"))
                    self.authorizationStatus = .authorizingFailed
                case .authorizationCancelled:
                    //reportNonFatal(.authFailed(reason: "AppleAuthError.authorizingCancelled", suggestion: "Apple auth is cancelled - valid case"))
                    self.authorizationStatus = .authorizingCancelled
                case .unexpected(let code):
                    reportNonFatal(.authFailed(reason: "AppleAuthError.unexpected(\(code))", suggestion: "Apple auth unexpected error with internal code"))
                    self.authorizationStatus = .authorizingFailed
                }
            } else if self.authorizationStatus != .authorizedNeedCreateProfile {
                reportNonFatal(.authFailed(reason: "Auth: Invalid status", suggestion: "Expected .authorizedNeedCreateProfile, but got another status"))
                self.authorizationStatus = .authorizingFailed
            }
            completion(self.authorizationStatus)
            return
        }
        guard let user = Auth.auth().currentUser else {
            reportNonFatal(.authFailed(reason: "Auth: no user", suggestion: "Auth.auth().currentUser is nil"))
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        guard let userID = Auth.auth().currentUser?.uid  else {
            reportNonFatal(.authFailed(reason: "Auth: no user id", suggestion: "Auth.auth().currentUser?.uid is nil"))
            self.authorizationStatus = .authorizingFailed
            completion(self.authorizationStatus)
            return
        }
        
        user.getIDTokenResult(forcingRefresh: true) { authTokenResult, error in
            
            if authTokenResult?.claims[Constants.Auth.claims] != nil {
                self.getFirebaseAuthToken { success in
                    
                    if !success {
                        reportNonFatal(.authFailed(reason: "Auth: no Firebase auth token", suggestion: "getFirebaseAuthToken failed: NO success"))
                        self.authorizationStatus = .authorizingFailed
                        completion(self.authorizationStatus)
                        return
                    }
                    
                    guard self.firebaseAuthToken != nil else {
                        reportNonFatal(.authFailed(reason: "Auth: no Firebase auth token", suggestion: "getFirebaseAuthToken failed: firebaseAuthToken is nil"))
                        self.authorizationStatus = .authorizingFailed
                        completion(self.authorizationStatus)
                        return
                    }
                    
                    self.hasProfilesMatchingUserID(userID: userID) { hasProfiles in
                        
                        if (hasProfiles) {
                            
                            UserProfileManager.shared.fetchProfile { success in
                                guard success == true else {
                                    reportNonFatal(.authFailed(reason: "Auth: can't fetch profile", suggestion: "hasProfilesMatchingUserID returns us true, but we failed to fetch the profile"))
                                    self.authorizationStatus = .authorizingFailed
                                    completion(self.authorizationStatus)
                                    return
                                }
                                
                                self.authorizationStatus = .authorizedFully
                                NotificationManager.shared.cancelSignUpReminderNotification()
                                completion(self.authorizationStatus)
                            }
                            return
                        }
                        
                        self.authorizationStatus = .authorizedNeedCreateProfile
                        completion(self.authorizationStatus)
                    }
                }
                
            } else {
                let config = Configuration()
                let session = URLSession.shared
                var url = URL(string: "\(Constants.Auth.claimsPost)\(user.uid)")!
                if config.environment == .staging {
                    url = URL(string: "\(Constants.Auth.claimsPostStaging)\(user.uid)")!
                }
                let task = session.dataTask(with: url, completionHandler: { data, response, error in

                    if error != nil {
                        reportNonFatal(.authFailed(reason: "Auth: can't fetch claims", suggestion: "Fetch claims returns error: \(error?.localizedDescription ?? "unknown error")"))
                        self.authorizationStatus = .authorizingFailed
                        completion(self.authorizationStatus)
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        reportNonFatal(.authFailed(reason: "Auth: can't fetch claims", suggestion: "Fetch claims returns invalid HTTPURLResponse: (200...299)"))
                        self.authorizationStatus = .authorizingFailed
                        completion(self.authorizationStatus)
                        return
                    }
                    
                    self.getFirebaseAuthToken { success in
                        
                        if !success {
                            reportNonFatal(.authFailed(reason: "Auth: no Firebase auth token", suggestion: "getFirebaseAuthToken failed: NO success"))
                            self.authorizationStatus = .authorizingFailed
                            completion(self.authorizationStatus)
                            return
                        }
                        
                        guard self.firebaseAuthToken != nil else {
                            reportNonFatal(.authFailed(reason: "Auth: no Firebase auth token", suggestion: "getFirebaseAuthToken failed: firebaseAuthToken is nil"))
                            self.authorizationStatus = .authorizingFailed
                            completion(self.authorizationStatus)
                            return
                        }
                        
                        self.hasProfilesMatchingUserID(userID: userID) { hasProfiles in
                            
                            if (hasProfiles) {
                                UserProfileManager.shared.fetchProfile { success in
                                    guard success == true else {
                                        reportNonFatal(.authFailed(reason: "Auth: can't fetch profile", suggestion: "hasProfilesMatchingUserID returns us true, but we failed to fetch the profile"))
                                        self.authorizationStatus = .authorizingFailed
                                        completion(self.authorizationStatus)
                                        return
                                    }
                                    
                                    self.authorizationStatus = .authorizedFully
                                    NotificationManager.shared.cancelSignUpReminderNotification()
                                    completion(self.authorizationStatus)
                                }
                                return
                            }
                            
                            self.authorizationStatus = .authorizedNeedCreateProfile
                            completion(self.authorizationStatus)
                        }
                    }
                })
                task.resume()
            }
        }
    }
    
    private func updateAuthorizationStatus(completion: @escaping () -> Void) {
        
        guard let userID = Auth.auth().currentUser?.uid  else {
            self.authorizationStatus = .notAuthorized
            completion()
            return
        }
        
        self.hasProfilesMatchingUserID(userID: userID) { hasProfiles in
            
            if (hasProfiles) {
                UserProfileManager.shared.fetchProfile { success in
                    guard success == true else {
                        self.authorizationStatus = .authorizingFailed
                        completion()
                        return
                    }
                    UserProfileManager.shared.updatePlaidPortfolio()
                    
                    self.getFirebaseAuthToken { success in
                        guard success == true else {
                            self.authorizationStatus = .authorizingFailed
                            completion()
                            return
                        }
                        
                        self.authorizationStatus = .authorizedFully
                        NotificationManager.shared.cancelSignUpReminderNotification()
                        completion()
                    }
                }
                return
            }
            
            self.authorizationStatus = .authorizedNeedCreateProfile
        }
    }
    
    func getFirebaseAuthToken(completion: @escaping (_ success: Bool) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }
        
        user.getIDTokenForcingRefresh(true) { token, error in
            
            guard let token = token else {
                completion(false)
                return
            }
            
            self.firebaseAuthToken = token
            NotificationCenter.default.post(name: NSNotification.Name.didReceiveFirebaseAuthToken, object: token)
            completion(true)
        }
    }
    
    private func hasProfilesMatchingUserID(userID: String, completion: @escaping (_ success: Bool) -> Void) {
        
        func processProfs(appProfiles: [AppProfilesUserIDsQuery.Data.AppProfile]) {
            let filteredProfiles = appProfiles.filter { profile in
                profile.userId == userID
            }
            if filteredProfiles.count > 0 {
                let profile = filteredProfiles.first
                UserProfileManager.shared.profileID = profile?.id
            } else {
                dprint("Err_AppProfilesUserIDsQuery_NoSuch \(appProfiles)")
            }
            completion(filteredProfiles.count > 0)
        }
        
        Network.shared.apollo.clearCache()
        Network.shared.apollo.fetch(query: AppProfilesUserIDsQuery()) { [weak self] result in
            guard self != nil else {
                completion(false)
                return
            }
            switch result {
            case .success(let graphQLResult):
                
                guard let appProfiles = graphQLResult.data?.appProfiles else {
                    dprint("Err_AppProfilesUserIDsQuery_Empty \(graphQLResult)")
                    completion(false)
                    return
                }
                if appProfiles.isEmpty {
                    dprint("ALI: \(appProfiles)")
                }
                processProfs(appProfiles: appProfiles)
                
            case .failure(let error):
                dprint("Err_AppProfilesUserIDsQuery_Failed \(error)")
                NotificationManager.shared.showError("Sorry... \(error.localizedDescription). Please, try again later.", report: true)
                completion(false)
            }
        }
    }
    
}
