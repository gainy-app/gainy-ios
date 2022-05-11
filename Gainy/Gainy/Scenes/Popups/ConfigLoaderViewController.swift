//
//  ConfigLoaderViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.04.2022.
//

import UIKit
import FirebaseRemoteConfig
import OneSignal

final class ConfigLoaderViewController: BaseViewController {
    
    @IBOutlet private weak var logoImgView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLoading()
    }
    
    func startLoading() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear) {
            self.logoImgView.alpha = 0
        } completion: { done in
            if done {
                self.showNetworkLoader()
                RemoteConfigManager.shared.loadDefaults {
                    runOnMain {
                        
                        OneSignal.promptForPushNotifications(userResponse: { accepted in
                            print("User accepted notification: \(accepted)")
                            GainyAnalytics.logEvent("pushes_status", params: ["accepted" : accepted])
                        })
                        
                        self.view.removeFromSuperview()
                    }
                }
            }
        }
        
    }
}
