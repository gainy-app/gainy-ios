//
//  DDLog.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.10.2021.
//

@_exported import BugfenderSDK
import FirebaseCrashlytics
import Logging
import LoggingSlack
import ExceptionCatcher

func dprint(_ msg: CustomStringConvertible, _ error: Error? = nil) {
    do {
        let value = try ExceptionCatcher.catch {
            bfprint(msg.description)
        }
    } catch {
        bfprint("BF Error:", error.localizedDescription)
    }
}

func dprint(_ msg: CustomStringConvertible, _ error: Error? = nil, profileId: Int? = nil) {
    if let profileId = profileId {
        if UserProfileManager.shared.profileID == profileId {
            do {
                let value = try ExceptionCatcher.catch {
                    bfprint(msg.description)
                }
            } catch {
                bfprint("BF Error:", error.localizedDescription)
            }
        }
    }
}

enum ReportError: Error {
    case noCollections(reason: String, suggestion: String)
    case authFailed(reason: String, suggestion: String)
    case popupShowned(reason: String)
    case requestFailed(reason: String, suggestion: String)
}

func reportNonFatal(_ error: ReportError, file: String = #fileID, function: String = #function, line: Int = #line) {
    
    var userInfo = [
      "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
    ]
    
    let header: String = "Profile ID: \(UserProfileManager.shared.profileID ?? 0)\nEnv: \(Configuration().environment == .production ? "Prod" : "Test")\nVersion: \(Bundle.main.releaseVersionNumberPretty) Build: \(Bundle.main.buildVersionNumber ?? "")\nBF ID: \(Bugfender.deviceIdentifierUrl()?.absoluteString ?? "")\n"
    let fileInfo: String = "\(file): \(line) \(function)"
    
    switch error {
    case .noCollections(let reason, let suggestion):
        userInfo = [
          NSLocalizedDescriptionKey: "No Collections to display",
          NSLocalizedFailureReasonErrorKey: reason,
          NSLocalizedRecoverySuggestionErrorKey: suggestion,
          "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
        ]
        
        GainyLogger.shared.logger.warning("\(header)No Collections to display\n\nReason: \(reason)\nSuggestion: \(suggestion)\n\(fileInfo)")
    case .authFailed(let reason, let suggestion):
        userInfo = [
          NSLocalizedDescriptionKey: "Auth Failed",
          NSLocalizedFailureReasonErrorKey: reason,
          NSLocalizedRecoverySuggestionErrorKey: suggestion,
          "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
        ]
        GainyLogger.shared.logger.warning("\(header)\nAuth Failed\n\nReason: \(reason)\nSuggestion: \(suggestion)\n\(fileInfo)")
    case .popupShowned(let reason):
        userInfo = [
          NSLocalizedDescriptionKey: "Alert popup",
          NSLocalizedFailureReasonErrorKey: reason,
          NSLocalizedRecoverySuggestionErrorKey: "",
          "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
        ]
        GainyLogger.shared.logger.warning("\(header)\nAlert popup\n\nReason: \(reason)\n\(fileInfo)")
    case .requestFailed(let reason, let suggestion):
        userInfo = [
          NSLocalizedDescriptionKey: "Request Failed",
          NSLocalizedFailureReasonErrorKey: reason,
          NSLocalizedRecoverySuggestionErrorKey: suggestion,
          "ProfileID": "\(UserProfileManager.shared.profileID ?? 0)"
        ]
        GainyLogger.shared.logger.warning("\(header)\nRequest failed\n\nReason: \(reason)\nSuggestion: \(suggestion)\n\(fileInfo)")
    }
    
    Crashlytics.crashlytics().setCustomValue(UserProfileManager.shared.profileID ?? 0, forKey: "ProfileID")
    let error = NSError.init(domain: NSCocoaErrorDomain,
                             code: -1001,
                             userInfo: userInfo)
    Crashlytics.crashlytics().record(error: error)
}


final class GainyLogger {
    static let shared = GainyLogger()
    
    let logger = Logger(label: "Gainy-iOS")
    
    init() {
        
        
    }
}
//final class DDLog {
//
//    static let logger =  Logger.builder
//        .sendNetworkInfo(true)
//        .printLogsToConsole(true, usingFormat: .shortWith(prefix: "[iOS App] "))
//        .build()
//}
