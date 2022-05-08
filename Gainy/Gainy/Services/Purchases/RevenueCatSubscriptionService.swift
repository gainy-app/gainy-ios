//
//  RevenueCatSubscriptionService.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation
import RevenueCat

struct RevenueCatSubscriptionService: SubscriptionServiceProtocol {
    
    func setup() {
        var config = Configuration()
        guard config.environment == .production else {return}
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Constants.RevenueCat.publicKey,
                            appUserID: nil,
                            observerMode: false,
                            userDefaults: UserDefaults.standard,
                            useStoreKit2IfAvailable: true)
    }
    
    func login(profileId: Int) {
        var config = Configuration()
        guard config.environment == .production else {return}
        
        Purchases.shared.logIn("\(profileId)") {(customerInfo, created, error) in
            dprint("RevenueCat login \(customerInfo)")
        }
    }
    
    func setEmail(email: String) {
        Purchases.shared.setEmail(email)
    }
    
    func getSubscription() -> SuscriptionType {
        .free
    }
    
    func getProducts() {
        
    }
    
    func purchaseProduct(productId: String) {
        
    }
}
