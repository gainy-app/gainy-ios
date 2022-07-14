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
    
    
    @UserDefaultBool(Constants.UserDefaults.isApplyCodeBtnVisible)
    var isApplyCodeBtnVisible: Bool
    
    @UserDefault(Constants.UserDefaults.monthPurchaseVariant)
    var monthPurchaseVariant: ProductVariant?
    
    @UserDefault(Constants.UserDefaults.month6PurchaseVariant)
    var month6PurchaseVariant: ProductVariant?
    
    @UserDefault(Constants.UserDefaults.yearPurchaseVariant)
    var yearPurchaseVariant: ProductVariant?
    
    @UserDefault(Constants.UserDefaults.mainBackColor)
    var mainBackColorHex: String?
    
    var mainBackColor: UIColor {
        UIColor(hexString: mainBackColorHex ?? "#FFFFFF") ?? .white
    }
    
    @UserDefault(Constants.UserDefaults.mainButtonColor)
    var mainButtonColorHex: String?
    
    var mainButtonColor: UIColor {
        UIColor(hexString: mainButtonColorHex ?? "#FFFFFF") ?? .white
    }
       
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
                self?.isApplyCodeBtnVisible = self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.isApplyCodeBtnVisible).boolValue ?? false
                
                Analytics.setUserProperty(("\(self?.showPortoCash ?? false)"), forName: "showPortoCash")
                Analytics.setUserProperty(("\(self?.showPortoCrypto ?? false)"), forName: "showPortoCrypto")
                Analytics.setUserProperty(("\(self?.isInvestBtnVisible ?? false)"), forName: "isInvestBtnVisible")
                Analytics.setUserProperty(("\(self?.isApplyCodeBtnVisible ?? false)"), forName: "isApplyCodeBtnVisible")
                
                self?.mainBackColorHex = self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.mainBackColor).stringValue ?? "#FFFFFF"
                self?.mainButtonColorHex = self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.mainButtonColor).stringValue ?? "#FFFFFF"
                
                Analytics.setUserProperty(("\(self?.mainBackColorHex ?? "")"), forName: "mainBackColorHex")
                Analytics.setUserProperty(("\(self?.mainButtonColorHex ?? "")"), forName: "mainButtonColorHex")
                
                //Purchases
                self?.monthPurchaseVariant = ProductVariant(rawValue: self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.monthPurchase).stringValue ?? "A") ?? .a
                self?.month6PurchaseVariant = ProductVariant(rawValue: self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.month6Purchase).stringValue ?? "A") ?? .a
                self?.yearPurchaseVariant = ProductVariant(rawValue: self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.yearPurchase).stringValue ?? "A") ?? .a
                
                Analytics.setUserProperty(("\(self?.monthPurchaseVariant ?? .a)"), forName: "monthPurchase")
                Analytics.setUserProperty(("\(self?.month6PurchaseVariant ?? .a)"), forName: "month6PurchaseVariant")
                Analytics.setUserProperty(("\(self?.yearPurchaseVariant ?? .a)"), forName: "yearPurchaseVariant")
                
                NotificationCenter.default.post(name: NotificationManager.remoteConfigLoadedNotification, object: nil)
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
