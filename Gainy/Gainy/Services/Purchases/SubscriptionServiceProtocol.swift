//
//  SubscriptionServiceProtocol.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation
import RevenueCat

enum SuscriptionType: Codable {
    case free, pro
}

enum SuscriptionPromotionType: String, Codable  {
    case month = "monthly", month6 = "six_month", year = "yearly"
}

protocol SubscriptionServiceProtocol {
    
    func setup()
    func login(profileId: Int)
    
    func setEmail(email: String)
    func setName(name: String)
    func getSubscription(_ completion: @escaping (SuscriptionType) -> Void)
    func expirationDate(_ completion: @escaping (Date?) -> Void)
    
    func getProducts(_ completion: @escaping ([StoreProduct]?) -> Void)
    func priceForProduct(product: Product) -> String
    func purchaseProduct(product: Product)
    func purchaseProduct(product: Product, with promocode: String)
    func restorePurchases(_ completion: @escaping (SuscriptionType) -> Void)
    func grantPromotion(_ type: SuscriptionPromotionType, _ completion: @escaping (SuscriptionType) -> Void)
    func productsLoaded() -> Bool
}
