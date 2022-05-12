//
//  RevenueCatSubscriptionService.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation
import RevenueCat

struct RevenueCatSubscriptionService: SubscriptionServiceProtocol {
    private var config = Configuration()
    
    func setup() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Constants.RevenueCat.publicKey,
                            appUserID: nil,
                            observerMode: false,
                            userDefaults: UserDefaults.standard,
                            useStoreKit2IfAvailable: true)
    }
    
    func login(profileId: Int) {
        
        Purchases.shared.logIn("\(profileId)") {(customerInfo, created, error) in
            dprint("RevenueCat login \(customerInfo)")
        }
    }
    
    func setEmail(email: String) {

        Purchases.shared.setEmail(email)
    }
    
    func setName(name: String) {
        Purchases.shared.setDisplayName(name)
    }
    
    func getSubscription(_ completion: (SuscriptionType) -> Void) {
        completion(.free)
    }
    
    func getProducts() {
        
    }
    
    func purchaseProduct(productId: String) {
        
    }
}
