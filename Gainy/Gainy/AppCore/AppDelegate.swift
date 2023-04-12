import AppsFlyerLib
import UIKit
import Firebase
import CoreData
import GoogleSignIn
//import Datadog
@_exported import BugfenderSDK
import LinkKit
import FirebaseAnalytics
import OneSignal
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Branch
import Logging
import LoggingSlack
import Amplitude_Swift

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Internal
    
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initSwiftLogging()
        initializeAppsFlyer()
        initFirebase()
        initDataDog()
        initBugfender()
        TickerLiveStorage.shared.clearAllLiveData()
        initOneSignal(launchOptions: launchOptions)
        SubscriptionManager.shared.setup()
        initBranchIO(launchOptions: launchOptions)
        NotificationManager.registerNotifications { success in
            if success {
                NotificationManager.shared.startObservingTimeSpent()
                NotificationManager.shared.scheduleSignUpReminderNotification()
            }
        }
        return true
    }
    
    fileprivate func clearOldUser() {
        UserProfileManager.shared.profileID ?? 0
    }
    
    
    func application(_: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration",
                             sessionRole: connectingSceneSession.role)
    }
    
    // MARK: Private
    
    @objc
    private func sendLaunch() {
        AppsFlyerLib.shared().start(completionHandler: { (dictionary, error) in
            if (error != nil){
                //dprint(error ?? "")
                return
            } else {
                dprint("AppsFlyerLib started")
                return
            }
        })
        NotificationCenter.default.post(name: NotificationManager.appBecomeActiveNotification, object: nil)
    }
    
    private func initializeAppsFlyer() {
        AppsFlyerLib.shared().appsFlyerDevKey = "z6SeiLgYCSRpeqK27zouo5"
        AppsFlyerLib.shared().appleAppID = AFConfig.appId
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        
        AppsFlyerLib.shared().isDebug = true
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: NSSelectorFromString("sendLaunch"),
                         name: UIApplication.didBecomeActiveNotification,
                         object: nil)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: NSSelectorFromString("sendClose"),
                         name: UIApplication.willResignActiveNotification,
                         object: nil)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: NSSelectorFromString("sendCloseWithClear"),
                         name: UIApplication.willTerminateNotification,
                         object: nil)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: NSSelectorFromString("trackOpen"),
                         name: UIApplication.didBecomeActiveNotification,
                         object: nil)
    }
    
    @objc
    private func sendClose() {
        //GainyAnalytics.logEvent("app_close")
    }
    
    @objc
    private func sendCloseWithClear() {
        //GainyAnalytics.logEvent("app_close")
        UserDefaults.markFirstClear()
    }
    
    @objc
    private func trackOpen() {
        if Auth.auth().currentUser?.uid != nil {
            UserProfileManager.shared.updatePlaidPortfolio()
        }
    }
    
    private func initFirebase() {
        FirebaseApp.configure()
    }
    
    private func initSwiftLogging() {
        let webhookURL = URL(string: "https://hooks.slack.com/services/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")!
        
        LoggingSystem.bootstrap { label in
            MultiplexLogHandler([
                // Setup SlackLogHandler with a webhook URL
                SlackLogHandler(label: label, webhookURL: webhookURL),
                // Setup the standard logging backend to enable console logging
                StreamLogHandler.standardOutput(label: label)
            ])
        }
        SlackLogHandler.globalLogLevelThreshold = .warning
    }
    
    private func initDataDog() {
        //        Datadog.initialize(
        //            appContext: .init(),
        //            trackingConsent: .granted,
        //            configuration: Datadog.Configuration
        //                .builderUsing(clientToken: "pub0e6507a595775f78e400ca18143aab43", environment: "production")
        //                .set(serviceName: "gainy-ios")
        //                .build()
        //        )
        //#if DEBUG
        //        Datadog.verbosityLevel = .debug
        //#endif
    }
    
    private var config = Configuration()
    private func initBugfender() {
        Bugfender.activateLogger("4gtCSXc1RciksUiOTPCQ5dkleoP8DNbH")
        Bugfender.enableCrashReporting()
    }
    
    private func initOneSignal(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        let notificationOpenedBlock: OSNotificationOpenedBlock = { result in
            // This block gets called when the user reacts to a notification received - we actually don't need to handle any other options: user tapped on the notification - app reatced
            let notification: OSNotification = result.notification
            NotificationManager.handlePushNotification(notification: notification)
        }
        
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(Constants.OneSignal.appId)
        OneSignal.setNotificationOpenedHandler(notificationOpenedBlock)
        
        if Configuration().environment == .staging {
            delay(3.0) {
                //NotificationManager.handlePushNotification(notification: OSNotification(), testData: ["t" : "11"])
                //NotificationManager.handlePushNotification(notification: OSNotification(), testData: ["t" : 10, "status" : "PROCESSING"])
                //NotificationManager.handlePushNotification(notification: OSNotification(), testData: ["t": 9,
                //                        "id": "tcv_506"])
            }
        }
    }
    
    private func initBranchIO(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
#if DEBUG
        Branch.getInstance().enableLogging()
#endif
        if config.environment == .production {
            
            Branch.getInstance().checkPasteboardOnInstall()
            
            BranchScene.shared().initSession(launchOptions: launchOptions, registerDeepLinkHandler: { (params, error, scene) in
                if let refId = params?["refId"] as? String {
                    dprint("Got invite install from \(refId)")
                    GainyAnalytics.logEvent("invite_received", params: ["refID" : refId])
                    DeeplinkManager.shared.isInviteAvaialble = true
                    DeeplinkManager.shared.fromId = Int(refId) ?? 0
                }
                
                if let ttfId = params?["ttfId"] as? String {
                    dprint("Got link to TTF \(ttfId)")
                    GainyAnalytics.logEvent("ttf_deeplink_received", params: ["ttfId" : ttfId])
                    
                    if Auth.auth().currentUser == nil {
                        DeeplinkManager.shared.isTTFAvaialble = true
                        DeeplinkManager.shared.ttfId = Int(ttfId) ?? 0
                    } else {
                        if let ttf = Int(ttfId) {
                            dprint("ttf_deeplink_open \(ttfId)")
                            GainyAnalytics.logEvent("ttf_deeplink_open", params: ["ttfId" : ttfId])
                            NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: Int(ttf))
                        }
                    }
                }
                
                if let stockSymbol = params?["stockSymbol"] as? String {
                    dprint("Got link to Stock \(stockSymbol)")
                    GainyAnalytics.logEvent("stock_deeplink_received", params: ["symbol" : stockSymbol])
                    
                    if Auth.auth().currentUser == nil {
                        DeeplinkManager.shared.isStockAvaialble = true
                        DeeplinkManager.shared.stockSymbol = stockSymbol
                    } else {
                        DeeplinkManager.shared.isStockAvaialble = false
                        dprint("stock_deeplink_open \(stockSymbol)")
                        GainyAnalytics.logEvent("stock_deeplink_open", params: ["symbol" : stockSymbol])
                        NotificationCenter.default.post(name: NotificationManager.requestOpenStockWithIdNotification, object: stockSymbol)
                    }
                }
                
                if let status = params?["activate"] as? String {
                    GainyAnalytics.logEvent("trade_activated")
                    if Auth.auth().currentUser == nil {
                        DeeplinkManager.shared.isTradingAvailable = true
                    } else {
                        DeeplinkManager.shared.isTradingAvailable = true
                        DeeplinkManager.shared.activateDelayedTrading()
                        
                        Task {
                            async let kycStatus = await UserProfileManager.shared.getProfileStatus()
                            if let kycStatus = await kycStatus {
                                if !(kycStatus.kycDone ?? false) {
                                    await MainActor.run {
                                        NotificationCenter.default.post(name: NotificationManager.requestOpenKYCNotification, object: nil)
                                    }
                                }
                            }
                        }
                        
                    }
                }
                if let status = params?["kyc"] as? String {
                    Task {
                        async let kycStatus = await UserProfileManager.shared.getProfileStatus()
                        if let kycStatus = await kycStatus {
                            if !(kycStatus.kycDone ?? false) {
                                await MainActor.run {
                                    NotificationCenter.default.post(name: NotificationManager.requestOpenKYCNotification, object: nil)
                                }
                            }
                        }
                    }
                }
                if let status = params?["deposit"] as? String {
                    Task {
                        async let kycStatus = await UserProfileManager.shared.getProfileStatus()
                        if let kycStatus = await kycStatus {
                            if (kycStatus.kycDone ?? false) {
                                await MainActor.run {
                                    NotificationCenter.default.post(name: NotificationManager.requestOpenDepositNotification, object: nil)
                                }
                            }
                        }
                    }
                }
                self.handleNonBranchLink(params?["+non_branch_link"] as? String)
            })
            //Branch.getInstance().validateSDKIntegration()
        }
        
    }
    
    /// Handle Universal Link
    /// - Parameter link: link if exists
    private func handleNonBranchLink(_ link: String?) {
        guard let link = link else {return}
        
        guard link.contains("/plaid") else {return}
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        
        guard let webpageURL = URL(string: link) else {return}
        
        dprint("dwCoordinator.linkHandler search")
        // The Plaid Link SDK ignores unexpected URLs passed to `continue(from:)` as
        // per Apple’s recommendations, so there is no need to filter out unrelated URLs.
        // Doing so may prevent a valid URL from being passed to `continue(from:)` and
        // OAuth may not continue as expected.
        // For details see https://plaid.com/docs/link/ios/#set-up-universal-links
        guard let tabBar = (sceneDelegate.window?.rootViewController as? UINavigationController)?.topViewController as? MainTabBarViewController,
              let dwCoordinator = tabBar.coordinator?.dwCoordinator
        else {
            return
        }
        if dwCoordinator.linkHandler != nil {
            dprint("dwCoordinator.linkHandler call")
            // Continue the Link flow
            dwCoordinator.linkHandler?.continue(from: webpageURL)
        }
    }
    
    //MARK: - CoreData
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "GainyModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: Continue Plaid Link for iOS to complete an OAuth authentication flow
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let webpageURL = userActivity.webpageURL else {
            return false
        }
        return true    }
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->
    
    private func sendInstallToFirebase(_ installData: [AnyHashable : Any]){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        let _newDate: String = dateFormatter.string(from: date)
        
        if(installData["af_status"] as? String == "Organic"){
            Analytics.logEvent("install", parameters: [
                "install_time": _newDate,
                "media_source": "organic",
                "campaign": "organic"
            ]);
        } else {
            Analytics.logEvent("install", parameters: [
                "install_time": installData["install_time"],
                "click_time": installData["click_time"],
                "media_source": installData["media_source"],
                "campaign": installData["campaign"],
                "install_type": installData["af_status"]
            ]);
        }
    }
    
    private func sendInstallToAmp(_ installData: [AnyHashable : Any]){
        let identify = Identify()
        let dataList = ["af_ad", "af_ad_id", "af_ad_type", "af_adset", "af_adset_id", "af_c_id", "af_channel", "af_prt", "c", "pid"]
        
        for item in dataList {
            if let setItem = installData[item] {
                identify.set(property: "\(item)", value: setItem)
            }
        }
        GainyAnalytics.amplitude.identify(identify: identify)
    }
}

extension AppDelegate: AppsFlyerLibDelegate {
    // Overriding the onConversionDataSuccess and onConversionDataFail
    // callbacks to process conversions and enable deferred deep linking
    
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        if let is_first_launch = installData["is_first_launch"] , let launch_code = is_first_launch as? Int {
            if(launch_code == 1){
                sendInstallToFirebase(installData)
                sendInstallToAmp(installData)
            }
        }
    }
    
    func onConversionDataFail(_ err: Error) {
        
    }
}

// Google SignIn
extension AppDelegate {
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
