//
//  TradingSubscriptionService.swift
//  Gainy
//
//  Created by Anton Gubarenko on 03.04.2023.
//

import Foundation
import SwiftDate
import RevenueCat

struct TradingSubscriptionService: SubscriptionServiceProtocol {
    
    func setup() {
        dprint("Trading service init")
    }
    
    func login(profileId: Int) {
        dprint("Trading service login")
    }
    
    func setEmail(email: String) {
    }
    
    func setName(name: String) {
    }
    
    func getSubscription(_ completion: @escaping (SuscriptionType) -> Void) {
        completion(.pro)
    }
    
    func expirationDate(_ completion: @escaping (Date?) -> Void) {
        completion(Date() + 1.years)
    }
    
    func getProducts(_ completion: @escaping ([StoreProduct]?) -> Void) {
        completion([])
    }
    
    func priceForProduct(product: Product) -> String {
        return ""
    }
    
    func purchaseProduct(product: Product) {
        
    }
    
    func purchaseProduct(product: Product, with promocode: String) {
        
    }
    
    func restorePurchases(_ completion: @escaping (SuscriptionType) -> Void) {
        completion(.pro)
    }
    
    func grantPromotion(_ type: SuscriptionPromotionType, _ completion: @escaping (SuscriptionType) -> Void) {
        completion(.pro)
    }
    
    func productsLoaded() -> Bool {
        true
    }
}
