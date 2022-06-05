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
    
    var name: String {
        switch self {
        case .month(_):
            return "One Month"
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
        buo.title = "Gainy invite"
        buo.contentDescription = "Invite Description"
        buo.imageUrl = "https://lorempixel.com/400/400"
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
