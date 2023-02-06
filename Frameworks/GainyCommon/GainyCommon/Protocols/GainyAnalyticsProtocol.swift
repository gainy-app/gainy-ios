//
//  GainyAnalyticsProtocol.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 15.09.2022.
//

import UIKit

public enum ReportError: Error {
    case noCollections(reason: String, suggestion: String)
    case authFailed(reason: String, suggestion: String)
    case popupShowned(reason: String)
    case requestFailed(reason: String, suggestion: String)
}

public protocol GainyAnalyticsProtocol: AnyObject {
    func logEvent(_ name: String, params: [String: AnyHashable]?)
    func logDevEvent(_ name: String, params: [String: AnyHashable]?)
    func logEvent(_ name: String)
    func reportNonFatalError(_ error: ReportError)
    func logBFEvent(_ name: String)
}

extension GainyAnalyticsProtocol {
    func logEvent(_ name: String, params: [String: AnyHashable]? = nil) {
        logEvent(name, params: params)
    }
    func logDevEvent(_ name: String, params: [String: AnyHashable]? = nil) {
        logDevEvent(name, params: params)
    }
    
    
}
