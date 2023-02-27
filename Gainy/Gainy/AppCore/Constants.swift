//
//  Constants.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.09.2021.
//

import Foundation


//MARK: - First Order functions
func runOnMain(_ closure: () -> Void) {
    if Thread.current.isMainThread {
        closure()
        return
    }
    DispatchQueue.main.sync {
        closure()
    }
}

@discardableResult
func measure<A>(name: String = "", _ block: () -> A) -> A {
    let startTime = CACurrentMediaTime()
    let result = block()
    let timeElapsed = CACurrentMediaTime() - startTime
    print("Time: \(name) - \(timeElapsed)")
    return result
}

func delay(_ delay: Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

struct Constants {
    struct CollectionDetails {
        static let tickersPreloadCount = 20
        static let watchlistCollectionID = -1
        static let compareCollectionID = -2
        static let singleCollectionId = -3
        static let top20ID = 231
        static let loadingCellIDs = [-10, -11, -12]
        static let demoNamePrefix = "GDEMO:"
        static let matchScore = "Match\nScore"
        static let yourCollections = "Your TTFs"
        static let noCollectionId = -4
        static let ttfSymbol = "TTF"
    }
    
    struct Auth {
        static let claims = "https://hasura.io/jwt/claims"
        static let claimsPost = "https://us-central1-gainyapp.cloudfunctions.net/refresh_token?uid="
        static let claimsPostStaging = "https://us-central1-gainyapp-test.cloudfunctions.net/refresh_token?uid="
    }
    
    struct UserDefaults {
        static let favKey = "favKey"
        static let scheduledSymbolEvents = "scheduledSymbolEvents"
        static let scheduledCalendarEvents = "scheduledCalendarEvents"
        
        static let showPortoCash = "showPortoCash"
        static let showPortoCrypto = "showPortoCrypto"
        static let isInvestBtnVisible = "isInvestBtnVisible"
        static let isApplyCodeBtnVisible = "isApplyCodeBtnVisible"
        
        static let monthPurchaseVariant = "monthPurchase"
        static let month6PurchaseVariant = "month6Purchase"
        static let yearPurchaseVariant = "yearPurchase"
        
        static let isInviteAvaialble = "isInviteAvaialble"
        static let isTTFAvaialble = "isTTFAvaialble"
        static let isStockAvaialble = "isStockAvaialble"
        static let fromInviteId = "fromInviteId"
        static let toTTFId = "toTTFId"
        static let toStockSymbol = "toStockSymbol"
        
        static let minInvestAmount = "minInvestAmount"
        
        static let isTradingAvailable = "isTradingAvailable"
        
        static let mainBackColor = "mainBackColor"
        static let mainButtonColor = "mainButtonColor"
    }
    
    struct Links {
        static let privacy = "https://www.gainy.app/legal-hub/privacy-policy"
        static let tos = "https://www.gainy.app/legal-hub/terms-of-service"
        static let privacyNotice = "https://www.gainy.app/legal-hub/privacy-notice"
        static let advPart3 = "https://www.gainy.app/legal-hub/gainy-adv-part-3-crs"
        static let formCRS = "https://www.gainy.app/legal-hub/form-crs"
        static let clientAgreement = "https://www.gainy.app/legal-hub/client-agreement"
        static let contentTOEDelivery = "https://www.gainy.app/legal-hub/consent-to-e-delivery"
        
        static let rhLink = "https://robinhood.com/applink/instrument/?symbol="
    }
    
    struct Plaid {
        //static let redirectURI = "https://app.gainy.application.ios"
        //static let redirectURI = "https://gainy.app.link/plaid"
        static let demoProfileID = 1
    }
    
    struct Chart {
        static let sypChartName = "SYPCHART"
        static let sypSymbol = "GSPC.INDX"
    }
    
    struct RemoteConfig {
        static let isPortoCash = "isPortoCashEnabled"
        static let isPortoCrypto = "isPortoCryptoEnabled"
        static let isInvestBtnVisible = "isInvestBtnVisible"
        static let isApplyCodeBtnVisible = "isApplyCodeBtnVisible"
        static let minInvestAmount = "minInvestAmount"
        static let mainButtonColor = "mainButtonColor"
        
        static let monthPurchase = "monthPurchase"
        static let month6Purchase = "month6Purchase"
        static let yearPurchase = "yearPurchase"
        
        static let mainBackColor = "mainBackColor"
        
        static let areGainsVisible = "areGainsVisible"
        static let gainsList = "gainsList"
    }
    
    struct OneSignal {
        static let appId = "a9619aa9-f7b4-4675-96f3-7ae78608c131"
    }
    
    struct RevenueCat {
        static let appId = "appf92c1b5c1c"
        static let publicKey = "appl_frKqXzekPjQXwJaYRTwGkPSuCiF"
        static let apiKey = "sk_MdiBlajVcgjEMeOCIeKVqzhRSLUfY"
    }
    
    struct Articles {
        static let wttfId = "62dadc9ea760201a7c2052f8"
    }
}
