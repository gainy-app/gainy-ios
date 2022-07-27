//
//  StagingSubscriptionService.swift
//  Gainy
//
//  Created by Anton Gubarenko on 10.05.2022.
//

import Foundation
import SwiftDate

struct StagingSubscriptionService: SubscriptionServiceProtocol {
    
    func setup() {
        dprint("Staging service init")
    }
    
    func login(profileId: Int) {
        dprint("Staging service login")
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
    
    func getProducts() {
        
    }
    
    func priceForProduct(product: Product) -> String {
        return ""
    }
    
    func purchaseProduct(product: Product) {
        
    }
    
    func purchaseProduct(product: Product, with promocode: String) {
        
    }
    
    func restorePurchases(_ completion: @escaping (SuscriptionType) -> Void) {
        print("Restored")
        completion(.free)
    }
    
    func grantPromotion(_ type: SuscriptionPromotionType, _ completion: @escaping (SuscriptionType) -> Void) {
        print("Promoted")
        completion(.free)
    }
}
