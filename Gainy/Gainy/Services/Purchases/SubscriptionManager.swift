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

enum ProductVariant: String, Codable {
    case a = "A", b = "B", c = "C"
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
    
    func getSubscription(_ completion: @escaping (SuscriptionType) -> Void) {
        service.getSubscription { type in            
            completion(type)
        }
    }
    
    func expirationDate(_ completion: @escaping (Date?) -> Void) {
        service.expirationDate(completion)
    }
    
    func getProducts() {
        service.getProducts()
    }
    
    func purchaseProduct(productId: String) {
        service.purchaseProduct(productId: productId)
    }
    
    func restorePurchases(_ completion: @escaping (SuscriptionType) -> Void) {
        service.restorePurchases(completion)
    }
    
    func grantPromotion(_ type: SuscriptionPromotionType, _ completion: @escaping (SuscriptionType) -> Void) {
        service.grantPromotion(type, completion)
    }
}
