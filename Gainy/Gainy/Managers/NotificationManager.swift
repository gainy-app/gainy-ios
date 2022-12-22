//
//  NotificationManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit
import AppTrackingTransparency
import StoreKit
import FirebaseAuth
import OneSignal
import GainyCommon

class NotificationManager: NSObject {
    
    static let defaultTimerIntervalInSeconds = 30
    static let minutesInAppRequiredToShowReview = 25
    static let secondsInDay = 60 * 60 * 24
    static let signupNotificationTimes = [secondsInDay, secondsInDay * 3, secondsInDay * 5]
    
    // Notifications
    static let userLogoutNotification = Notification.Name.init("userLogoutNotification")
    static let userLoginNotification = "userLoginNotification"
    static let appBecomeInactiveNotification = "appBecomeInactiveNotification"
    static let tickerScrollNotification = Notification.Name.init("tickerScrollNotification")
    static let portoTabPressedNotification = Notification.Name.init("portoTabPressedNotification")
    static let homeTabPressedNotification = Notification.Name.init("homeTabPressedNotification")
    static let discoveryTabPressedNotification = Notification.Name.init("discoveryTabPressedNotification")
    static let userSignUpNotification = Notification.Name.init("userSignUpNotification")
    
    static let appBecomeActiveNotification = Notification.Name.init("appBecomeActiveNotification")
    static let subscriptionChangedNotification = Notification.Name.init("subscriptionChangedNotification")
    static let requestOpenHomeNotification = Notification.Name.init("requestOpenHomeNotification")
    static let requestOpenCollectionWithIdNotification = Notification.Name.init("requestOpenCollectionWithIdNotification")
    static let requestOpenStockWithIdNotification = Notification.Name.init("requestOpenStockWithIdNotification")
    static let requestOpenKYCNotification = Notification.Name.init("requestOpenKYCNotification")
    
    static let requestOpenArticleWithIdNotification = Notification.Name.init("requestOpenArticleWithIdNotification")
    static let requestOpenStockWithSymbolOnPortfolioNotification = Notification.Name.init("requestOpenStockWithSymbolOnPortfolioNotification")
    static let requestOpenPortfolioNotification = Notification.Name.init("requestOpenPortfolioNotification")
    static let remoteConfigLoadedNotification = Notification.Name.init("remoteConfigLoadedNotification")
    static let ttfRangeSyncNotification = Notification.Name.init("ttfRangeSyncNotification")
    static let ttfChartVscrollNotification = Notification.Name.init("ttfChartVscrollNotification")
    static let discoveryResetNotification = Notification.Name.init("discoveryResetNotification")
    static let dwTTFBuySellNotification = Notification.Name.init("dwTTFBuySellNotification")
    static let dwStockBuySellNotification = Notification.Name.init("dwStockBuySellNotification")
    static let startProfileTabUpdateNotification = Notification.Name.init("startProfileTabUpdateNotification")
    
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
    
    private var timer: Timer?
    @UserDefault<Int>("timeSpentInSeconds_prod_1.0")
    private var timeSpentInSeconds: Int?
    
    @UserDefault<Int>("addedTTFsCount_prod_1.0")
    private var addedTTFsCount: Int?
    
    @UserDefault<Bool>("reviewWasShown_prod_1.0")
    private var reviewWasShown: Bool?
    
    @UserDefault<Bool>("signupReminderScheduled_prod_1.0")
    private var signupReminderScheduled: Bool?
    
    public func increaseTTFsAdded() {
        
        if let shown = self.reviewWasShown, shown == true {
            return
        }
        
        var addedTTFsCount = self.addedTTFsCount ?? 0
        addedTTFsCount += 1
        self.addedTTFsCount = addedTTFsCount
        
        if addedTTFsCount >= 3 {
            self.requestAppReviewForm()
        }
    }
    
    public func startObservingTimeSpent() {
        
        if let shown = self.reviewWasShown, shown == true {
            return
        }
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: NSSelectorFromString("didEnterBackground"),
                         name: UIApplication.didEnterBackgroundNotification,
                         object: nil)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: NSSelectorFromString("willEnterForeground"),
                         name: UIApplication.willEnterForegroundNotification,
                         object: nil)
        self.restartTimer()
    }
    
    @objc
    private func didEnterBackground() {
        self.stopTimer()
    }
    
    @objc
    private func willEnterForeground() {
        self.restartTimer()
    }
    
    private func stopTimer() {
        
        self.timer?.invalidate()
    }
    
    private func restartTimer() {
        
        self.stopTimer()
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(NotificationManager.defaultTimerIntervalInSeconds),
                                          target: self,
                                          selector: #selector(updateTimer),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    @objc
    private func updateTimer() {
        
        var timeSpentInSeconds = self.timeSpentInSeconds ?? 0
        timeSpentInSeconds += NotificationManager.defaultTimerIntervalInSeconds
        self.timeSpentInSeconds = timeSpentInSeconds
        
        if timeSpentInSeconds / 60 >= NotificationManager.minutesInAppRequiredToShowReview {
            self.requestAppReviewForm()
        }
    }
    
    public func cancelSignUpReminderNotification() {
        
        let center = UNUserNotificationCenter.current()
        let identifiers = ["signup_reminder_local_notification_0", "signup_reminder_local_notification_1", "signup_reminder_local_notification_2"]
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        center.removeDeliveredNotifications(withIdentifiers: identifiers)
    }
    
    public func scheduleSignUpReminderNotification() {

        if Auth.auth().currentUser?.uid != nil {
            return
        }
        if let signupReminderScheduled = self.signupReminderScheduled, signupReminderScheduled == true {
            return
        }
        
        self.signupReminderScheduled = true
        let center = UNUserNotificationCenter.current()
        for (index, timeInterval) in NotificationManager.signupNotificationTimes.enumerated() {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "You’re almost ready! 🧑‍🚀"
            notificationContent.body = "Tap to complete your registration and get personalized investment recommendations"
            let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
            let notificationRequest = UNNotificationRequest(identifier: "signup_reminder_local_notification_\(index)", content: notificationContent, trigger: notificationTrigger)
            center.add(notificationRequest) { (error) in
                if let error = error {
                    print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
                }
            }
        }
    }
    
    public func requestAppReviewForm() {
        
        if let shown = self.reviewWasShown, shown == true {
            return
        }
        
        self.timer?.invalidate()
        self.reviewWasShown = true
        SKStoreReviewController.requestReview()
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
        reportNonFatal(.popupShowned(reason: errorText))
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: errorText, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        if let topViewController = BaseViewController.topViewController {
            if topViewController.presentedViewController == nil && !(topViewController is UIAlertController) {
                topViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func showError(_ errorText: String, withRetry: @escaping (() -> Void)) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: errorText, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let retryAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .default) { _ in
            withRetry()
        }
        alert.addAction(retryAction)
        
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
    
    class func broadcastSubscriptionChangeNotification(type: SuscriptionType) {
        NotificationCenter.default.post(name: subscriptionChangedNotification, object: nil, userInfo: ["type": type])
    }
    
    class func handlePushNotification(notification: OSNotification) {
        
        dprint("Push: \(notification.additionalData ?? [:])")
        guard let additionalData = notification.additionalData else {
            return
        }
        
        if let type = additionalData["t"] as? String {
            switch type {
            case "0":
                NotificationCenter.default.post(name: NotificationManager.requestOpenHomeNotification, object: nil)
                break
            case "1":
                if let id = additionalData["id"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: Int.init(id))
                } else if let id = additionalData["id"] as? Int {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: Int.init(id))
                }
                break
            case "4":
                NotificationCenter.default.post(name: NotificationManager.requestOpenHomeNotification, object: nil)
                if let id = additionalData["id"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenArticleWithIdNotification, object: id)
                } else if let id = additionalData["id"] as? Int {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenArticleWithIdNotification, object: "\(id)")
                }
                break
            case "6":
                if let stockSymbol = additionalData["s"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenPortfolioNotification, object: stockSymbol)
                    NotificationCenter.default.post(name: NotificationManager.requestOpenStockWithSymbolOnPortfolioNotification, object: stockSymbol)
                }
                break
            case "7":
                if let stockSymbol = additionalData["s"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenPortfolioNotification, object: stockSymbol)
                    NotificationCenter.default.post(name: NotificationManager.requestOpenStockWithSymbolOnPortfolioNotification, object: stockSymbol)
                }
                break
            case "8":
                if let stockSymbol = additionalData["s"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenStockWithIdNotification, object: stockSymbol)
                }
                break
            default: break
            }
        } else if let type = additionalData["t"] as? Int {
            switch type {
            case 0:
                NotificationCenter.default.post(name: NotificationManager.requestOpenHomeNotification, object: nil)
                break
            case 1:
                if let id = additionalData["id"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: Int.init(id))
                } else if let id = additionalData["id"] as? Int {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: Int.init(id))
                }
                break
            case 4:
                NotificationCenter.default.post(name: NotificationManager.requestOpenHomeNotification, object: nil)
                if let id = additionalData["id"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenArticleWithIdNotification, object: id)
                } else if let id = additionalData["id"] as? Int {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenArticleWithIdNotification, object: "\(id)")
                }
                break
            case 6:
                if let stockSymbol = additionalData["s"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenPortfolioNotification, object: stockSymbol)
                    NotificationCenter.default.post(name: NotificationManager.requestOpenStockWithSymbolOnPortfolioNotification, object: stockSymbol)
                }
                break
            case 7:
                if let stockSymbol = additionalData["s"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenPortfolioNotification, object: stockSymbol)
                    NotificationCenter.default.post(name: NotificationManager.requestOpenStockWithSymbolOnPortfolioNotification, object: stockSymbol)
                }
                break
            case 8:
                if let stockSymbol = additionalData["s"] as? String {
                    NotificationCenter.default.post(name: NotificationManager.requestOpenStockWithIdNotification, object: stockSymbol)
                }
                break
                
            default: break
            }
        }
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
