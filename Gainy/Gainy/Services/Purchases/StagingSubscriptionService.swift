//
//  StagingSubscriptionService.swift
//  Gainy
//
//  Created by Anton Gubarenko on 10.05.2022.
//

import Foundation

struct StagingSubscriptionService: SubscriptionServiceProtocol {
    
    func setup() {
        dprint("Staging service init")
    }
    
    func login(profileId: Int) {
        dprint("Staging service login")
    }
    
    func setEmail(email: String) {
    }
    
    func getSubscription(_ completion: (SuscriptionType) -> Void) {
        completion(.pro)
    }
    
    func getProducts() {
        
    }
    
    func purchaseProduct(productId: String) {
        
    }
}
