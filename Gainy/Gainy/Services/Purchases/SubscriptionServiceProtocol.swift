//
//  SubscriptionServiceProtocol.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation

enum SuscriptionType: Codable {
    case free, pro
}

protocol SubscriptionServiceProtocol {
    
    func setup()
    func login(profileId: Int)
    
    func setEmail(email: String)
    func setName(name: String)
    func getSubscription(_ completion: @escaping (SuscriptionType) -> Void)
    func expirationDate(_ completion: @escaping (Date?) -> Void)
    func getProducts()
    func purchaseProduct(productId: String)
}
