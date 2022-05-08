//
//  SubscriptionServiceProtocol.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation

enum SuscriptionType {
    case free, pro
}

protocol SubscriptionServiceProtocol {
    
    func setup()
    func login(profileId: Int)
    
    func setEmail(email: String)
    func getSubscription() -> SuscriptionType
    func getProducts()
    func purchaseProduct(productId: String)
}
