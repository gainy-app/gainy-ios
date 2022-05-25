//
//  RevenueCatSubscriptionService.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation
import RevenueCat
import SwiftDate

class RevenueCatSubscriptionService: SubscriptionServiceProtocol {
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
            dprint("RevenueCat login \(customerInfo)")
            self?.handleInfo(customerInfo, error: error)
        }
    }
    
    private let ettl = "pro"
    func handleInfo(_ customerInfo:CustomerInfo?, error: Error?) {
        if let error = error {
            dprint("RevenueCat error: \(error)")
            innerType = .pro
        } else {
            if customerInfo?.entitlements[ettl]?.isActive == true {
                innerType = .pro
                innerDate = customerInfo?.entitlements[ettl]?.expirationDate
                NotificationManager.broadcastSubscriptionChangeNotification(type: .pro)
                
            } else {
                innerType = .free
                NotificationManager.broadcastSubscriptionChangeNotification(type: .free)
            }
            dprint("RevenueCat sub: \(innerType ?? .free)")
        }
    }
    
    func setEmail(email: String) {

        Purchases.shared.setEmail(email)
    }
    
    func setName(name: String) {
        Purchases.shared.setDisplayName(name)
    }
    
    
    private var innerType: SuscriptionType?
    func getSubscription(_ completion: @escaping (SuscriptionType) -> Void) {
        if let innerType = innerType {
            completion(innerType)
        } else {
            Purchases.shared.getCustomerInfo {[weak self] (customerInfo, error) in
                self?.handleInfo(customerInfo, error: error)
                completion(self?.innerType ?? .free)
            }
        }
    }
    
    private var innerDate: Date?
    func expirationDate(_ completion: @escaping (Date?) -> Void) {
        if let innerDate = innerDate {
            completion(innerDate)
        } else {
            Purchases.shared.getCustomerInfo {[weak self] (customerInfo, error) in
                self?.handleInfo(customerInfo, error: error)
                completion(self?.innerDate)
            }
        }
    }
    
    private var products: [StoreProduct] = []
    func getProducts() {
        
    }
    
    func purchaseProduct(productId: String) {
        
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
}
