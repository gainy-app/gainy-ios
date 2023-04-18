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
    public var fundingAccountAuto: Bool = false
    
    @UserDefaultBool("initialTTFFlag")
    public var initialTTFFlag: Bool
    
    @UserDefaultBool("firstTTFAdded")
    public var firstTTFAdded: Bool
    
    public var isFirstInstall: Bool = false
    
    public var isFromDiscoveryInitial: Bool = false
    public var ttfOpenSource = ""
    
    public var depositSource = ""
    public var kycStatusSource = ""
    public var kycMainSource = ""
}
