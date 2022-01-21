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

final class GainyAnalytics {
    
    static let shared = GainyAnalytics()
    
    class func logEvent(_ name: String, params: [String: AnyHashable]? = nil) {
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
        if  let user = Auth.auth().currentUser {
            newParams["uid"] = user.uid
        }
        newParams["ul"] = Locale.current.identifier
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
        if  let user = Auth.auth().currentUser {
            newParams["uid"] = user.uid
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
}
