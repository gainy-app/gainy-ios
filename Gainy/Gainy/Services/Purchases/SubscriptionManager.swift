//
//  SubscriptionManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation
import Branch

protocol SubscriptionManagerProtocol: SubscriptionServiceProtocol{
    var service: SubscriptionServiceProtocol { get }
    var storage: PurchaseInfoStorageProtocol { get }
}

enum ProductVariant: String, Codable {
    case a = "A", b = "B", c = "C"
}

enum Product: CaseIterable {
    
    static var allCases: [Product] {
        return [.month(.a), .month(.b), .month(.c), .month6(.a), .month6(.b), .month6(.c), .year(.a), .year(.b), .year(.c)]
    }
    
    case month(_ variant: ProductVariant)
    case month6(_ variant: ProductVariant)
    case year(_ variant: ProductVariant)
    
    var identifier: String {
        switch self {
        case .month(let variant):
            switch variant {
            case .a:
                return "gainy_10_r_m1"
            case .b:
                return "gainy_20_r_m1"
            case .c:
                return "gainy_40_r_m1"
            }
            
        case .month6(let variant):
            switch variant {
            case .a:
                return "gainy_50_r_m6"
            case .b:
                return "gainy_100_r_m6"
            case .c:
                return "gainy_200_r_m6"
            }
        case .year(let variant):
            switch variant {
            case .a:
                return "gainy_80_r_y1"
            case .b:
                return "gainy_160_r_y1"
            case .c:
                return "gainy_320_r_y1"
            }
        }
    }
    
    var name: String {
        switch self {
        case .month(_):
            return "Monthly"
        case .month6(_):
            return "6 Months"
        case .year(_):
            return "One Year"
        }
    }
    
    var info: String {
        switch self {
        case .month(_):
            return "Easy start"
        case .month6(_):
            return "You save 15%"
        case .year(_):
            return "You save 20%"
        }
    }
    
    var price: String {
        let price = SubscriptionManager.shared.priceForProduct(product: self)
        return price
    }
    
    var period: String {
        switch self {
        case .month(_):
            return "per month"
        case .month6(_):
            return "per 6 month"
        case .year(_):
            return "per year"
        }
    }
    
    var terms: String {
        switch self {
        case .month(_):
            return """
Monthly subscription is required to get access to premium features of the app. Subscription automatically renews with the price and duration given above unless it is canceled at least 24 hours before the end of the current period.
Payment will be charged to your Apple ID account at the confirmation of purchase. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel your subscriptions by going to
your account settings on the App Store after purchase.
Removing the app doesn’t automatically cancel the subscription.
"""
        case .month6(_):
            return """
6 Months subscription is required to get access to premium features of the app. Subscription automatically renews with the price and duration given above unless it is canceled at least 24 hours before the end of the current period.
Payment will be charged to your Apple ID account at the confirmation of purchase. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel your subscriptions by going to
your account settings on the App Store after purchase.
Removing the app doesn’t automatically cancel the subscription.
"""
        case .year(_):
            return """
Annually subscription is required to get access to premium features of the app. Subscription automatically renews with the price and duration given above unless it is canceled at least 24 hours before the end of the current period.
Payment will be charged to your Apple ID account at the confirmation of purchase. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel your subscriptions by going to
your account settings on the App Store after purchase.
Removing the app doesn’t automatically cancel the subscription.
"""
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
    
    func purchaseProduct(product: Product) {
        service.purchaseProduct(product: product)
    }
    
    func priceForProduct(product: Product) -> String {
        service.priceForProduct(product: product)
    }
    
    func restorePurchases(_ completion: @escaping (SuscriptionType) -> Void) {
        service.restorePurchases(completion)
    }
    
    func grantPromotion(_ type: SuscriptionPromotionType, _ completion: @escaping (SuscriptionType) -> Void) {
        service.grantPromotion(type, completion)
    }
    
    func generateInviteLink(_ completion: @escaping (URL) -> Void){
        
        let buo = BranchUniversalObject.init(canonicalIdentifier: "invite")
        buo.title = "\(UserProfileManager.shared.fullName) invited you to Gainy Premium"
        buo.contentDescription = "Track all your investment accounts in one place. Follow stock collections from leading analysts. Safe and balanced investing in sectors you believe in with Thematic Trading Fractional."
        buo.imageUrl = "https://uceb1323dc638e314608dee3acec.previews.dropboxusercontent.com/p/thumb/ABgYr7N88APNt8iacn0Ki8PMR6AiXdc1jr5wm31Z2qNQ_5kF5oQjGWu7u6p-3T7tPajrMrVRldMPc5A8s5jFO9E8Xq4t83_E8j1IkowAC0nzN5on6eqlj4RpLqhtHxIQmx3kz_opmyNTy-LCw16WhMZR_tZjN3lIZbbIxHoNhYrN8TACOj5Z9KYAHCG9Aycc8JMkUbx3R2c3warCGI1K8v_AegNY9r9f6ma8xJr02pNghC3OllugVJ-vQ_UuGB2sVbvZUirShEFBzIfWTPaWwfNPHB5l3FnI3VNyqJQeO6BuQvh4mSdE2C_i47RCSgtkVf8axwMAJGKCAO-hx2XqgHwVqjzfToA0wE7yymn3YAO4YL53jstWZzI31y3sXiTG8dQ0888IMczRUjgX1yyjhFD4AXjXJpgmmYf869qjvmfcjA/p.jpeg"
        buo.publiclyIndex = true
        buo.locallyIndex = true
        
        let linkProperties: BranchLinkProperties = BranchLinkProperties()
        linkProperties.feature = "Purchase_swipe"
        linkProperties.campaign = "Referral_Invite"
        linkProperties.channel = "Share"
        linkProperties.addControlParam("refId", withValue: "\(UserProfileManager.shared.profileID ?? 0)")
        linkProperties.addControlParam("$ios_passive_deepview_", withValue: "false")
        
        buo.getShortUrl(with: linkProperties) { (url, error) in
            if (error == nil) {
                if let url = url {
                    completion(URL(string: url)!)
                }
            } else {
                dprint(String(format: "Branch error : %@", error! as CVarArg))
            }
        }
    }
}
