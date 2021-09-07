//
//  GainyAnalytics.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit
import FirebaseAnalytics
import AppsFlyerLib

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
        Analytics.logEvent(name, parameters: params)
        AppsFlyerLib.shared().logEvent(name, withValues: params)
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
