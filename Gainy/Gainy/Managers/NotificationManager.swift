//
//  NotificationManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit
import AppTrackingTransparency

class NotificationManager: NSObject {
    // Notifications
    static let userLogoutNotification = "userLogoutNotification"
    static let userLoginNotification = "userLoginNotification"
    static let appBecomeInactiveNotification = "appBecomeInactiveNotification"
    static let appBecomeActiveNotification = "appBecomeActiveNotification"
    static let tickerScrollNotification = Notification.Name.init("tickerScrollNotification")
    static let portoTabPressedNotification = Notification.Name.init("portoTabPressedNotification")
    
    // Singleton
    static let shared = NotificationManager()
    
    
    fileprivate override init() {
        super.init()
    }
    
    static var isPushesGranted = false
    class func registerNotifications(_ result: ((Bool) -> ())? = nil) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            
            result?(granted)
            guard granted else {
                return
            }
            isPushesGranted = true
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
           
            UNUserNotificationCenter.current().delegate = NotificationManager.shared
            
            //ATT Tracking
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
                })
            } else {
            }
        }
    }
    
    class func trackingRequest() {
        //ATT Tracking
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
            })
        } else {
        }
    }
    
    class func registerOrEnableNotifications() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            
            guard granted else {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                DispatchQueue.main.async {
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (_) in
                        })
                    }
                }
                
                return
            }
            isPushesGranted = true
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
    
    func showMessage(title: String, text: String, cancelTitle: String?, actions: Array<UIAlertAction>?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        
        if let topViewController = BaseViewController.topViewController {
            if topViewController.presentedViewController == nil && !(topViewController is UIAlertController) {
                topViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func showError(_ errorText: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: errorText, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        if let topViewController = BaseViewController.topViewController {
            if topViewController.presentedViewController == nil && !(topViewController is UIAlertController) {
                topViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    class func broadcastNotification(name: NSNotification.Name, object: Any?) {
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    class func broadcastNotification(name: String, object: Any?, shortcutIndex: Int) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: nil, userInfo: [:])
    }
    
    
    func handleErrors(status: Int, errors: [String]) {
        //        if status == 524 {
        //            self.showMessage(title: "Error!", text: "No Internet connection. Please try again later.", cancelTitle: "OK", actions: nil)
        //        } else {
        //            if status == 401 {
        //                DataManager.shared.logout()
        //                NotificationManager.broadcastNotification(name: NotificationManager.userLogoutNotification, object: nil)
        //            }
        //            if status == 403 {
        //                self.showMessage(title: "Warning", text: errors.joined(separator: "\n") + "\nContact us via website to resume your ap usage.", cancelTitle: "OK", actions: nil)
        //            } else {
        //                if status == 499 {
        //                    if DataManager.shared.isLoggedIn {
        //                        //self.showMessage(title: "Error!", text: "Your subscription has expired", cancelTitle: "OK", actions: nil)
        //                        //To-Do: subcription expiry
        //                        //NotificationManager.broadcastNotification(name: NotificationManager.subscriptionExpiredNotification, object: nil)
        //                    }
        //                } else {
        //                    self.showMessage(title: "Error!", text: errors.joined(separator: "\n"), cancelTitle: "OK", actions: nil)
        //                }
        //            }
        //        }
    }
    
}

extension NotificationManager : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        let aps = userInfo["aps"] as? [AnyHashable : Any]
        
        if let threadId = aps?["threadId"] as? String {
        } else {
            completionHandler([.alert, .sound])
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        let aps = userInfo["aps"] as? [AnyHashable : Any]
        completionHandler()
    }
}
