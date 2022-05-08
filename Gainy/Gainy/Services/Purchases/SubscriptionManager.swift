//
//  SubscriptionManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation

protocol SubscriptionManagerProtocol: SubscriptionServiceProtocol{
    var service: SubscriptionServiceProtocol { get }
    var storage: PurchaseInfoStorageProtocol { get }
    
    var subscribtionType: SuscriptionType {get}
}

class SubscriptionManager: SubscriptionManagerProtocol {
    
    
    var service: SubscriptionServiceProtocol
    
    var storage: PurchaseInfoStorageProtocol
    
    static let shared = SubscriptionManager()
    
    init(
        service: SubscriptionServiceProtocol = RevenueCatSubscriptionService(),
        storage: PurchaseInfoStorageProtocol = UserDefaultsPurchaseInfoStorage()
    ) {
        self.service = service
        self.storage = storage
    }
    
    var subscribtionType: SuscriptionType {
        service.getSubscription()
    }
    
}


extension SubscriptionManager: SubscriptionServiceProtocol {
    func setup() {
        service.setup()
    }
    
    func login(profileId: Int) {
        service.login(profileId: profileId)
    }
    
    func setEmail(email: String) {
        service.setEmail(email: email)
    }
    
    func getSubscription() -> SuscriptionType {
        service.getSubscription()
    }
    
    func getProducts() {
        service.getProducts()
    }
    
    func purchaseProduct(productId: String) {
        service.purchaseProduct(productId: productId)
    }
}
