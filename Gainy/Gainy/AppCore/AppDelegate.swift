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

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Internal
    
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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
                         name: UIApplication.didEnterBackgroundNotification,
                         object: nil)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: NSSelectorFromString("trackOpen"),
                         name: UIApplication.willEnterForegroundNotification,
                         object: nil)
    }
    
    @objc
    private func sendClose() {
        GainyAnalytics.logEvent("app_close", params: ["user_id" : Auth.auth().currentUser?.uid ?? "anonymous"])
    }
    
    @objc
    private func trackOpen() {
        GainyAnalytics.logEvent("app_open", params: ["user_id" : Auth.auth().currentUser?.uid ?? "anonymous" ])
        if Auth.auth().currentUser?.uid != nil {
            UserProfileManager.shared.updatePlaidPortfolio()
        }
    }
    
    private func initFirebase() {
        FirebaseApp.configure()
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
            dprint("Push: \(notification.additionalData ?? [:])")
            if let additionalData = notification.additionalData {
                if let type = additionalData["t"] as? String {
                    switch type {
                    case "0":
                        NotificationCenter.default.post(name: NotificationManager.requestOpenHomeNotification, object: nil)
                        break
                    case "1":
                        if let id = additionalData["id"] as? String {
                            NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: Int.init(id))
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
                        if let id = additionalData["id"] as? Int {
                            NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: id)
                        }
                        break
                        
                    default: break
                    }
                }
            }
        }
        
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(Constants.OneSignal.appId)
        OneSignal.setNotificationOpenedHandler(notificationOpenedBlock)
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
                
            })
            //Branch.getInstance().validateSDKIntegration()
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
        
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return false
        }
        
        // The Plaid Link SDK ignores unexpected URLs passed to `continue(from:)` as
        // per Apple’s recommendations, so there is no need to filter out unrelated URLs.
        // Doing so may prevent a valid URL from being passed to `continue(from:)` and
        // OAuth may not continue as expected.
        // For details see https://plaid.com/docs/link/ios/#set-up-universal-links
        guard let linkOAuthHandler = sceneDelegate.window?.rootViewController as? LinkOAuthHandling,
              let handler = linkOAuthHandler.linkHandler
        else {
            return false
        }
        
        // Continue the Link flow
        handler.continue(from: webpageURL)
        return true    }
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->
    
}

extension AppDelegate: AppsFlyerLibDelegate {
    // Overriding the onConversionDataSuccess and onConversionDataFail
    // callbacks to process conversions and enable deferred deep linking
    
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        print("Conv sc \(installData)")
    }
    
    func onConversionDataFail(_ err: Error) {
        print("Conv err \(err)")
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
