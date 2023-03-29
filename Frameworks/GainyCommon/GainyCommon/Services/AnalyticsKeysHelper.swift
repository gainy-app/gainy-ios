//
//  AnalyticsKeysHelper.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 12.03.2023.
//

import Foundation

public final class AnalyticsKeysHelper {
    
    public static let shared = AnalyticsKeysHelper()
    
    //funding_acc_connect_s
    public var fundingAccountSource = ""
    
    public var initialTTFFlag: Bool = false
    public var firstTTFAdded: Bool = false
}
