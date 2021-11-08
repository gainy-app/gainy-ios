//
//  Constants.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.09.2021.
//

import Foundation

func runOnMain(_ closure: @autoclosure @escaping () -> Void) {
    if Thread.current.isMainThread {
        closure()
        return
    }
    DispatchQueue.main.async {
        closure()
    }
}

struct Constants {
    struct CollectionDetails {
        static let tickersPreloadCount = 20
        static let compareCollectionID = -2
        static let top20ID = 231
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
    }
    
    struct Links {
        static let privacy = "https://www.gainy.app/privacy-policy"
        static let tos = "https://www.gainy.app/terms-of-service"
        static let rhLink = "https://robinhood.com/applink/instrument/?symbol="
    }
}
