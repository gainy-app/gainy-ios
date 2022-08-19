//
//  DDLog.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.10.2021.
//

@_exported import BugfenderSDK
import FirebaseCrashlytics

func dprint(_ msg: CustomStringConvertible, _ error: Error? = nil) {
    bfprint(msg.description)
}

func dprint(_ msg: CustomStringConvertible, _ error: Error? = nil, profileId: Int? = nil) {
    if let profileId = profileId {
        if UserProfileManager.shared.profileID == profileId {
            bfprint(msg.description)
        }
    }
}

enum ReportError: Error {
    case noCollections(reason: String, suggestion: String)
    case authFailed(reason: String, suggestion: String)
    case popupShowned(reason: String)
    case requestFailed(reason: String, suggestion: String)
}

func reportNonFatal(_ error: ReportError) {
    
    var userInfo = [
      "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
    ]
    
    switch error {
    case .noCollections(let reason, let suggestion):
        userInfo = [
          NSLocalizedDescriptionKey: "No Collections to display",
          NSLocalizedFailureReasonErrorKey: reason,
          NSLocalizedRecoverySuggestionErrorKey: suggestion,
          "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
        ]
    case .authFailed(let reason, let suggestion):
        userInfo = [
          NSLocalizedDescriptionKey: "Auth Failed",
          NSLocalizedFailureReasonErrorKey: reason,
          NSLocalizedRecoverySuggestionErrorKey: suggestion,
          "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
        ]
    case .popupShowned(let reason):
        userInfo = [
          NSLocalizedDescriptionKey: "Alert popup",
          NSLocalizedFailureReasonErrorKey: reason,
          NSLocalizedRecoverySuggestionErrorKey: "",
          "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
        ]
    case .requestFailed(let reason, let suggestion):
        userInfo = [
          NSLocalizedDescriptionKey: "Request Failed",
          NSLocalizedFailureReasonErrorKey: reason,
          NSLocalizedRecoverySuggestionErrorKey: suggestion,
          "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
        ]
    }
    
    Crashlytics.crashlytics().setCustomValue(UserProfileManager.shared.profileID ?? 0, forKey: "ProfileID")
    let error = NSError.init(domain: NSCocoaErrorDomain,
                             code: -1001,
                             userInfo: userInfo)
    Crashlytics.crashlytics().record(error: error)
}

//final class DDLog {
//
//    static let logger =  Logger.builder
//        .sendNetworkInfo(true)
//        .printLogsToConsole(true, usingFormat: .shortWith(prefix: "[iOS App] "))
//        .build()
//}
