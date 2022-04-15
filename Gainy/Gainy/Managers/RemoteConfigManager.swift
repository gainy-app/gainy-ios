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
                self?.showPortoCash = self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.isPortoCash).boolValue ?? false
                self?.showPortoCrypto = self?.remoteConfig.configValue(forKey: Constants.RemoteConfig.isPortoCrypto).boolValue ?? false
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
