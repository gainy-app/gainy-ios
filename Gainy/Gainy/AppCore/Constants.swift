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
        static let top20ID = 231
        static let loadingCellIDs = [-10, -11, -12]
        static let demoNamePrefix = "GDEMO:"
        static let matchScore = "Match\nScore"
        static let yourCollections = "Your collections"
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
    }
    
    struct Links {
        static let privacy = "https://www.gainy.app/privacy-policy"
        static let tos = "https://www.gainy.app/terms-of-service"
        static let privacyNotice = "https://www.gainy.app/privacy-notice"
        static let advPart3 = "https://www.gainy.app/form-adv"
        static let formCRS = "https://www.gainy.app/form-crs"
        static let clientAgreement = "https://www.gainy.app/client-agreement"
        static let contentTOEDelivery = "https://www.gainy.app/consent-to-e-delivery"
        
        static let rhLink = "https://robinhood.com/applink/instrument/?symbol="
    }
    
    struct Plaid {
        static let redirectURI = "https://app.gainy.application.ios"
    }
    
    struct Chart {
        static let sypChartName = "SYPCHART"
        static let sypSymbol = "SPY"
    }
    
    struct RemoteConfig {
        static let isPortoCash = "isPortoCashEnabled"
        static let isPortoCrypto = "isPortoCryptoEnabled"
    }
}
