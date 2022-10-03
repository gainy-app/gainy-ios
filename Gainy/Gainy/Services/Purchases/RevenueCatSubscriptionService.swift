//
//  RevenueCatSubscriptionService.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation
import RevenueCat
import SwiftDate
import StoreKit
import FirebaseAnalytics
import GainyAPI

class RevenueCatSubscriptionService: NSObject, SubscriptionServiceProtocol {
    private var config = Configuration()
    
    func setup() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Constants.RevenueCat.publicKey,
                            appUserID: nil,
                            observerMode: false,
                            userDefaults: UserDefaults.standard,
                            useStoreKit2IfAvailable: true)
    }
    
    func login(profileId: Int) {
        Purchases.shared.logIn("\(profileId)") {[weak self] (customerInfo, created, error) in
            dprint("RevenueCat login")
            self?.handleInfo(customerInfo, error: error, informFirebase: true)
            self?.getProducts({_ in})            
        }
    }
    
    private let ettl = "pro"
    func handleInfo(_ customerInfo:CustomerInfo?, error: Error?, informFirebase: Bool = false, fromPurchase: Bool = false) {
        //Checking RC
        if let error = error {
            dprint("RevenueCat error: \(error)")
            innerType = .free
            NotificationManager.broadcastSubscriptionChangeNotification(type: .free)
            innerDate = nil
        } else {
            if customerInfo?.entitlements[ettl]?.isActive == true {
                innerType = .pro
                innerDate = customerInfo?.entitlements[ettl]?.expirationDate
                NotificationManager.broadcastSubscriptionChangeNotification(type: .pro)
                if fromPurchase {
#if targetEnvironment(simulator)
    GainyAnalytics.logEvent("demo_purchase_completed", params: ["productId" : customerInfo?.entitlements[ettl]?.productIdentifier ?? ""])
#else
                    GainyAnalytics.logEvent("purchase_completed", params: ["productId" : customerInfo?.entitlements[ettl]?.productIdentifier ?? ""])
#endif
                }
            } else {
                checkDBForSub()
            }
            if informFirebase {
                reloadPurchase()
            }
        }
        dprint("RevenueCat sub: \(innerType ?? .free)")
    }
    
    private func checkDBForSub() {
        guard UserProfileManager.shared.profileID != nil else {
            return
        }
        //Cehcking our DB
        if let subscriptionExpiryDate = UserProfileManager.shared.subscriptionExpiryDate {
            if Date() < subscriptionExpiryDate  {
                innerDate = subscriptionExpiryDate
                innerType = .pro
                NotificationManager.broadcastSubscriptionChangeNotification(type: .pro)
            } else {
                innerType = .free
                innerDate = nil
                NotificationManager.broadcastSubscriptionChangeNotification(type: .free)
            }
        } else {
            innerType = .free
            innerDate = nil
            NotificationManager.broadcastSubscriptionChangeNotification(type: .free)
        }
    }
    
    func reloadPurchase() {
        if let profileID = UserProfileManager.shared.profileID {
            let query = PurchaseUpdateMutation.init(profileId: profileID)
            Network.shared.apollo.perform(mutation: query) {[weak self] response in
                switch response {
                case .success(let data):
                    if let subExpDate = (data.data?.updatePurchases?.subscriptionEndDate ?? "").toDate("yyyy-MM-dd'T'HH:mm:ssZ")?.date {
                        UserProfileManager.shared.subscriptionExpiryDate = subExpDate
                    } else {
                        if let subExpDate = (data.data?.updatePurchases?.subscriptionEndDate ?? "").toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ")?.date {
                            UserProfileManager.shared.subscriptionExpiryDate = subExpDate
                        } else {
                            UserProfileManager.shared.subscriptionExpiryDate = Date() - 1.weeks
                        }
                    }
                    self?.checkDBForSub()
                    break
                case .failure(let error):
                    GainyAnalytics.logEvent("informAboutPurchase error \(error)")
                    break
                }
            }
        }
    }
    
    func uploadPromo(promocode: String, productId: String) {
        if let profileID = UserProfileManager.shared.profileID {
            let query = UploadPromoMutation.init(profile_id: profileID, promocode: promocode, tariff: productId)
            Network.shared.apollo.perform(mutation: query) {[weak self] response in
                switch response {
                case .success(let data):
                    if let subExpDate = (data.data?.applyPromocode?.subscriptionEndDate ?? "").toDate("yyyy-MM-dd'T'HH:mm:ssZ")?.date {
                        UserProfileManager.shared.subscriptionExpiryDate = subExpDate
                    } else {
                        if let subExpDate = (data.data?.applyPromocode?.subscriptionEndDate ?? "").toDate("yyyy-MM-dd'T'HH:mm:ss.SSSZ")?.date {
                            UserProfileManager.shared.subscriptionExpiryDate = subExpDate
                        } else {
                            UserProfileManager.shared.subscriptionExpiryDate = Date() - 1.weeks
                        }
                    }
                    self?.checkDBForSub()
                    break
                case .failure(let error):
                    GainyAnalytics.logEvent("UploadPromoMutation error \(error)")
                    break
                }
            }
        }
    }
    
    func setEmail(email: String) {
        Purchases.shared.attribution.setEmail(email)
    }
    
    func setName(name: String) {
        Purchases.shared.attribution.setDisplayName(name)
    }
    
    
    private var innerType: SuscriptionType?
    func getSubscription(_ completion: @escaping (SuscriptionType) -> Void) {
        if let innerType = innerType {
            completion(innerType)
        } else {
            if UserProfileManager.shared.profileID != nil {
                checkDBForSub()
            } else {
                UserProfileManager.shared.fetchProfile {[weak self] _ in
                    self?.checkDBForSub()
                }
            }
        }
    }
    
    private var innerDate: Date?
    func expirationDate(_ completion: @escaping (Date?) -> Void) {
        if let innerDate = innerDate {
            completion(innerDate)
        } else {
            if UserProfileManager.shared.profileID != nil {
                checkDBForSub()
            } else {
                UserProfileManager.shared.fetchProfile {[weak self] _ in
                    self?.checkDBForSub()
                }
            }
        }
    }
    
    private var products: [StoreProduct] = []
    func getProducts(_ completion: @escaping ([StoreProduct]?) -> Void) {
        let allProducts = Product.allCases.compactMap({$0.identifier})
        Purchases.shared.getProducts(allProducts) {[weak self] remoteProducts in
            self?.products = remoteProducts
            completion(self?.products)
        }
    }
    
    
    func purchaseProduct(product: Product) {
        if let product = products.first(where: {$0.productIdentifier == product.identifier}) {
            Purchases.shared.purchase(product: product) {[weak self] tr, customerInfo, error, userCancelled in
                self?.handleInfo(customerInfo, error: error, informFirebase: true, fromPurchase: true)
                Purchases.shared.attribution.setAttributes(["promo_сode" : ""])
            }
        }
    }
    
    //Demo EEKUA1AE
    func purchaseProduct(product: Product, with promocode: String) {
        if let product = products.first(where: {$0.productIdentifier == product.identifier}) {
            Purchases.shared.purchase(product: product) {[weak self] tr, customerInfo, error, userCancelled in
                self?.handleInfo(customerInfo, error: error, informFirebase: false, fromPurchase: true)
                self?.uploadPromo(promocode: promocode, productId: product.productIdentifier)
                Purchases.shared.attribution.setAttributes(["promo_сode" : promocode])
                Analytics.setUserProperty(promocode, forName: "promo_сode")
            }
        }
    }
    
    func priceForProduct(product: Product) -> String {
        if let product = products.first(where: {$0.productIdentifier == product.identifier}) {
            return product.localizedPriceString
        }
        return "-"
    }
    
    func restorePurchases(_ completion: @escaping (SuscriptionType) -> Void) {
        Purchases.shared.restorePurchases {[weak self] (customerInfo, error) in
            self?.handleInfo(customerInfo, error: error)
            completion(self?.innerType ?? .free)
        }
    }
    
    func grantPromotion(_ type: SuscriptionPromotionType, _ completion: @escaping (SuscriptionType) -> Void) {
        func promote(_ completion: @escaping (SuscriptionType) -> Void) {
            let headers = [
             "Accept": "application/json",
            "Content-Type": "application/json",
             "Authorization": "Bearer \(Constants.RevenueCat.apiKey)"
            ]
        
            let parameters = ["duration": type.rawValue] as [String : Any]

            let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://api.revenuecat.com/v1/subscribers/\(UserProfileManager.shared.profileID ?? 0)/entitlements/\(ettl)/promotional")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {[weak self] (data, response, error) -> Void in
              if (error != nil) {
                  dprint("Promotion error: \(error?.localizedDescription ?? "")")
              } else {
                  self?.innerType = nil
                  self?.innerDate = nil
                  self?.getSubscription(completion)
              }
            })
            dataTask.resume()
        }        
    }
    
    func productsLoaded() -> Bool {
        !products.isEmpty
    }
}
