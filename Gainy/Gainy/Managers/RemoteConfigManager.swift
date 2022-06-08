//
//  RemoteConfigManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.04.2022.
//

import UIKit
import Firebase
import FirebaseRemoteConfig
import FirebaseABTesting

final class RemoteConfigManager {
    
    static let shared = RemoteConfigManager()
    
    @UserDefaultBool(Constants.UserDefaults.showPortoCash)
    var showPortoCash: Bool
    
    @UserDefaultBool(Constants.UserDefaults.showPortoCrypto)
    var showPortoCrypto: Bool
    
    @UserDefaultBool(Constants.UserDefaults.isInvestBtnVisible)
    var isInvestBtnVisible: Bool
    
    @UserDefault(Constants.UserDefaults.monthPurchaseVariant)
    var monthPurchaseVariant: ProductVariant?
    
    @UserDefault(Constants.UserDefaults.month6PurchaseVariant)
    var month6PurchaseVariant: ProductVariant?
    
    @UserDefault(Constants.UserDefaults.yearPurchaseVariant)
    var yearPurchaseVariant: ProductVariant?
    
    private var remoteConfig: RemoteConfig!
     
    func loadDefaults(_ completion: @escaping () -> Void) {
        self.remoteConfig = RemoteConfig.remoteConfig()
        
        let settings = RemoteConfigSettings()
        #if DEBUG
        settings.minimumFetchInterval = 0
        #else
        settings.minimumFetchInterval = 60.0 * 60.0 * 4.0
        #endif
        remoteConfig.configSettings = settings
        
        remoteConfig.fetch() {[weak self](status, error) -> Void in
          if status == .success {
            self?.remoteConfig.activate() { (changed, error) in
                //Porto
                self?.showPortoCash = self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.isPortoCash).boolValue ?? false
                self?.showPortoCrypto = self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.isPortoCrypto).boolValue ?? false
                self?.isInvestBtnVisible = self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.isInvestBtnVisible).boolValue ?? false
                
                //Purchases
                self?.monthPurchaseVariant = ProductVariant(rawValue: self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.monthPurchase).stringValue ?? "A") ?? .a
                self?.month6PurchaseVariant = ProductVariant(rawValue: self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.month6Purchase).stringValue ?? "A") ?? .a
                self?.yearPurchaseVariant = ProductVariant(rawValue: self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.yearPurchase).stringValue ?? "A") ?? .a
                completion()
            }
          } else {
              self?.showPortoCash = false
              self?.showPortoCrypto = false
              completion()
          }
        }
    }
}
