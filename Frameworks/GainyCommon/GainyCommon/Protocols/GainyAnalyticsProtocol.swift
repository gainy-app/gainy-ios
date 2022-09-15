//
//  GainyAnalyticsProtocol.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 15.09.2022.
//

import UIKit

public protocol GainyAnalyticsProtocol: AnyObject {
    func logEvent(_ name: String, params: [String: AnyHashable]?)
    func logDevEvent(_ name: String, params: [String: AnyHashable]?)
}

extension GainyAnalyticsProtocol {
    func logEvent(_ name: String, params: [String: AnyHashable]? = nil) {
        logEvent(name, params: params)
    }
    func logDevEvent(_ name: String, params: [String: AnyHashable]? = nil) {
        logDevEvent(name, params: params)
    }
}
