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
        completion(.free)
    }
    
    func expirationDate(_ completion: @escaping (Date?) -> Void) {
        completion(Date() + 1.years)
    }
    
    func getProducts() {
        
    }
    
    func purchaseProduct(productId: String) {
        
    }
}
