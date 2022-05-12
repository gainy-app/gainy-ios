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
}

enum ProductVariant: String {
    case a, b, c
}

enum Product {
    case month(variant: ProductVariant)
    case month6(variant: ProductVariant)
    case year(variant: ProductVariant)
    
    var identifier: String {
        switch self {
        case .month(let variant):
            switch variant {
            case .a:
                return "gainy_5_m1"
            case .b:
                return "gainy_10_m1"
            case .c:
                return "gainy_20_m1"
            }
            
        case .month6(let variant):
            switch variant {
            case .a:
                return "gainy_25_m6"
            case .b:
                return "gainy_50_m6"
            case .c:
                return "gainy_100_m6"
            }
        case .year(let variant):
            switch variant {
            case .a:
                return "gainy_40_y1"
            case .b:
                return "gainy_80_y1"
            case .c:
                return "gainy_160_y1"
            }
        }
    }
}

class SubscriptionManager: SubscriptionManagerProtocol {
    
    //MARK: - Enttlms
    
    private let enttlm = "pro"
    
    
    var service: SubscriptionServiceProtocol
    
    var storage: PurchaseInfoStorageProtocol
    
    static let shared = SubscriptionManager()
    
    private var config = Configuration()
    
    init(
        service: SubscriptionServiceProtocol = RevenueCatSubscriptionService(),
        storage: PurchaseInfoStorageProtocol = UserDefaultsPurchaseInfoStorage()
    ) {
        self.storage = storage
        if config.environment == .production {
            self.service = service
        } else {
            self.service = StagingSubscriptionService()
        }
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
    
    func setName(name: String) {
        service.setName(name: name)
    }
    
    func getSubscription(_ completion: (SuscriptionType) -> Void) {
        service.getSubscription { type in
            NotificationManager.broadcastSubscriptionChangeNotification(type: type)
            completion(type)
        }
        
    }
    
    func getProducts() {
        service.getProducts()
    }
    
    func purchaseProduct(productId: String) {
        service.purchaseProduct(productId: productId)
    }
}
