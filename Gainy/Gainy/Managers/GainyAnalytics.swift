//
//  GainyAnalytics.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit
import FirebaseAnalytics
import AppsFlyerLib
import FirebaseAuth
import OneSignal
import GainyCommon
import Amplitude_Swift

enum AnalyticFields: String {
    case ProtocolVersion = "v", TrackingID = "tid", ClientID = "cid", HitType = "t", CacheBuster = "z", DataSource = "ds",
         Geo = "geoid", AppVersion = "av", AppName = "an", UserLanguage = "ul", Viewport = "vp",
         ScreenRes = "sr", ScreenName = "sn", EventCategory = "ec",
         EventAction = "ea", EventLabel = "el", EventValue = "ev", MAC = "mac",
         Email = "email", UserID = "uid", SessionControl = "sc", CustomDimension = "cd",
         UserAgent = "ua", Medium = "cm", CompagneName = "cn", Source = "cs"
}


//enum CustomDimension: String {
//    //case ClientID = "cid", case OriginalCountry = "geoid",
//}

/// General Analytics manager
final class GainyAnalytics: GainyAnalyticsProtocol {
       
      
    static let shared = GainyAnalytics()
    
    //MARK: - Onboarding
    
    var isLogin: Bool = false
    var isRegistration: Bool = false
    
    static var notLoggedCache: [(name: String, params: [String: AnyHashable])] = []
    
    static var amplitude: Amplitude {
        if Configuration().environment == .production {
            return Amplitude(
                configuration: Amplitude_Swift.Configuration(
                    apiKey: "b846619ae9b089d8ff443516695e9944"
                )
            )
        } else {
            return Amplitude(
                configuration: Amplitude_Swift.Configuration(
                    apiKey: "14568ca22c85d3c845e69ff38756c857"
                )
            )
        }
    }
    
    static func flushLogs() {
        guard let user = Auth.auth().currentUser else {return}
        for log in notLoggedCache {
            var newParams = log.params
            newParams["uid"] = user.uid
            newParams["user_id"] = Auth.auth().currentUser?.uid ?? "anonymous"
            Analytics.logEvent(log.name, parameters: newParams)
            AppsFlyerLib.shared().logEvent(log.name, withValues: newParams)
            amplitude.track(eventType: log.name, eventProperties: newParams)
        }
        notLoggedCache.removeAll()
    }
    
    class func logEventAMP(_ name: String, params: [String: AnyHashable]? = nil) {
        
        guard Configuration().environment == .production else {
            return
        }
        var newParams = params ?? [:]
        newParams["v"] = 2.0
        if ["gois_screen_view", "tab_changed", "discover_collections_pressed", "your_collection_pressed", "ticker_pressed"].contains(name) {
            newParams["t"] = "screen_view"
        } else {
            newParams["t"] = "event"
        }
        newParams[FirebaseAnalytics.AnalyticsParameterSource] = "app"
        newParams["ds"] = "app"
        newParams["geoid"] = UserProfileManager.shared.storeRegion == .us ? "US" : "NON_US"
        newParams["av"] = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        newParams["an"] = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String) ?? ""
        newParams["ul"] = Locale.current.identifier
        newParams["vp"] = "\(UIScreen.main.bounds.height)-\(UIScreen.main.bounds.width)"
        if let user = Auth.auth().currentUser {
            newParams["uid"] = user.uid
        }
        newParams["user_id"] = Auth.auth().currentUser?.uid ?? "anonymous"
        newParams["profileId"] = UserProfileManager.shared.profileID ?? 0
        newParams["ul"] = Locale.current.identifier
        newParams["date"] = Date().timeIntervalSinceReferenceDate
        newParams["z"] = UUID().uuidString
        amplitude.track(eventType: name, eventProperties: newParams)
#if DEBUG
    print("\n###ANALYTICS### \(name) \(params)")
    if let params = params {
        print(params)
    }
#endif
    }
    
    class func logEvent(_ name: String, params: [String: AnyHashable]? = nil) {
        guard Configuration().environment == .production else {
            return
        }
        
        var newParams = params ?? [:]
        newParams["v"] = 2.0
        if ["gois_screen_view", "tab_changed", "discover_collections_pressed", "your_collection_pressed", "ticker_pressed"].contains(name) {
            newParams["t"] = "screen_view"
        } else {
            newParams["t"] = "event"
        }
        newParams[FirebaseAnalytics.AnalyticsParameterSource] = "app"
        newParams["ds"] = "app"
        newParams["geoid"] = UserProfileManager.shared.storeRegion == .us ? "US" : "NON_US"
        newParams["av"] = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        newParams["an"] = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String) ?? ""
        newParams["ul"] = Locale.current.identifier
        newParams["vp"] = "\(UIScreen.main.bounds.height)-\(UIScreen.main.bounds.width)"
        if let user = Auth.auth().currentUser {
            newParams["uid"] = user.uid
        }
        newParams["user_id"] = Auth.auth().currentUser?.uid ?? "anonymous"
        newParams["profileId"] = UserProfileManager.shared.profileID ?? 0
        newParams["ul"] = Locale.current.identifier
        newParams["date"] = Date().timeIntervalSinceReferenceDate
        newParams["z"] = UUID().uuidString
        if ampNames.contains(name) {
            amplitude.track(eventType: name, eventProperties: newParams)
#if DEBUG
        print("\n###ANALYTICS### \(name) \(params)")
        if let params = params {
            print(params)
        }
#endif

        }
        
        if afNames.contains(name) {
            AppsFlyerLib.shared().logEvent(name, withValues: newParams)
#if DEBUG
        print("\n###ANALYTICS### \(name) \(params)")
        if let params = params {
            print(params)
        }
#endif

        }
    }
    
        static var ampNames: [String] = [
            "app_open",
            "app_close",
            "first_launch",
            "ask_to_track_popup_shown",
            "ask_to_track_popup_pressed",
            "tab_changed",
            "sign_in_tapped",
            "enter_with_acc_tapped",
            "authorization_fully_authorized",
            "login_success",
            "logout_success",
            "get_started_tapped",
            "intro_1_shown",
            "intro_2_shown",
            "intro_3_shown",
            "intro_4_shown",
            "sign_up_failed",
            "authorization_need_create_profile",
            "discovery_initial_launch",
            "pick_interest_shown",
            "interest_picked",
            "investment_goal_shown",
            "investment_goal_picked",
            "average_market_return_picked",
            "invest_horizon_shown",
            "investment_horizon_picked",
            "damage_of_failure_shown",
            "damage_of_failure_picked",
            "stock_market_risks_picked",
            "urgent_money_source_picked",
            "trading_experience_shown",
            "trading_experience_picked",
            "disc_sort_tapped",
            "disc_sort_changed",
            "disc_period_changed",
            "favorite_view_tapped",
            "search_started",
            "search_ended",
            "portfolio_view_tapped",
            "portfolio_not_enough_data_shown",
            "profile_balance_plus_tapped",
            "questionnaire_restart_tapped",
            "transaction_history_opened"
        ]
    
    static var afNames: [String] = [
        "dw_kyc_submitted",
        "questioner_done",
        "ttf_added_to_wl",
        "ticker_added_to_wl",
        "ttf_card_opened",
        "ticker_card_opened",
        "install",
        "af_login",
        "af_complete_registration",
        "funding_acc_connected"
    ]
    
    class func logDevEvent(_ name: String, params: [String: AnyHashable]? = nil) {

    }
    
    class func setAmplUserID(_ profileID: Int) {
        amplitude.setUserId(userId: "\(profileID)")
    }
    
    /// Add marketing info to extrnal link
    /// - Parameter url:
    /// - Returns:
    func addInfoToURLString(_ url: String) -> String {
        //url.appending("?cid=682362403.1529404347&userstatus=free&version=\(appVersion)0&os=\(iOSVersion)")
        url
    }
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
    }
    
    var iOSVersion: String {
        let os = ProcessInfo.processInfo.operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
    
    func logEvent(_ name: String, params: [String : AnyHashable]?) {
        GainyAnalytics.logEvent(name, params: params)
    }
    
    func logEvent(_ name: String) {
        GainyAnalytics.logEvent(name, params: nil)
    }
    
    func logDevEvent(_ name: String, params: [String : AnyHashable]?) {
        GainyAnalytics.logDevEvent(name, params: params)
    }
    
    func logBFEvent(_ name: String) {
        dprint(name)
    }
    
    func logEventAMP(_ name: String, params: [String : AnyHashable]?) {
        GainyAnalytics.logEventAMP(name, params: params)
    }
    
    func logEventAMP(_ name: String) {
        GainyAnalytics.logEventAMP(name, params: nil)
    }
    
    func reportNonFatalError(_ error: ReportError) {
        reportNonFatal(error)
    }
}
