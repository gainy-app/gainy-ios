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
    
    static func flushLogs() {
        guard let user = Auth.auth().currentUser else {return}
        for log in notLoggedCache {
            var newParams = log.params
            newParams["uid"] = user.uid
            newParams["user_id"] = Auth.auth().currentUser?.uid ?? "anonymous"
            Analytics.logEvent(log.name, parameters: newParams)
            AppsFlyerLib.shared().logEvent(log.name, withValues: newParams)
        }
        notLoggedCache.removeAll()
    }
    
    class func logEvent(_ name: String, params: [String: AnyHashable]? = nil) {
        var newParams = params ?? [:]
        newParams["sn"] = ""
        
#if DEBUG
        print("\n###ANALYTICS### \(name) \(params)")
        if let params = params {
            print(params)
        }
#endif
        
        newParams["v"] = 1
        newParams["tid"] = UUID().uuidString
        if ["gois_screen_view", "tab_changed", "discover_collections_pressed", "your_collection_pressed", "ticker_pressed"].contains(name) {
            newParams["t"] = "screen_view"
        } else {
            newParams["t"] = "event"
        }
        newParams[FirebaseAnalytics.AnalyticsParameterSource] = "app"
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
        if Auth.auth().currentUser == nil {
            notLoggedCache.append((name: name, params: newParams))
        } else {
            flushLogs()
        }
        Analytics.logEvent(name, parameters: newParams)
        AppsFlyerLib.shared().logEvent(name, withValues: newParams)
    }
    
    class func logDevEvent(_ name: String, params: [String: AnyHashable]? = nil) {
        var newParams = params ?? [:]
        newParams["sn"] = ""
        
#if DEBUG
        print("\n###ANALYTICS### \(name)")
        if let params = params {
            print(params)
        }
#endif
        
        newParams["v"] = 1
        newParams["tid"] = UUID().uuidString
        newParams[FirebaseAnalytics.AnalyticsParameterSource] = "app"
        newParams["av"] = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        newParams["an"] = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String) ?? ""
        newParams["ul"] = Locale.current.identifier
        newParams["vp"] = "\(UIScreen.main.bounds.height)-\(UIScreen.main.bounds.width)"
        if  let user = Auth.auth().currentUser {
            newParams["uid"] = user.uid
        } else {
            newParams["uid"] = "anonymous"
        }
        newParams["ul"] = Locale.current.identifier
        Analytics.logEvent(name, parameters: newParams)
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
    
    func reportNonFatalError(_ error: ReportError) {
        reportNonFatal(error)
    }
}
