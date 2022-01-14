import AppsFlyerLib
import UIKit
import Firebase
import CoreData
import GoogleSignIn
//import Datadog
@_exported import BugfenderSDK
import LinkKit
import FirebaseAnalytics


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
        NotificationManager.trackingRequest()
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
                        print(error ?? "")
                        return
                    } else {
                        dprint("AppsFlyerLib started")
                        print(dictionary ?? "")
                        return
                    }
                })
    }
    
    private func initializeAppsFlyer() {
        AppsFlyerLib.shared().appsFlyerDevKey = "z6SeiLgYCSRpeqK27zouo5"
        AppsFlyerLib.shared().appleAppID = AFConfig.appId
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        

        //AppsFlyerLib.shared().isDebug = true
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: NSSelectorFromString("sendLaunch"),
                         name: UIApplication.didBecomeActiveNotification,
                         object: nil)
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
        if config.environment == .staging {
            Bugfender.activateLogger("4gtCSXc1RciksUiOTPCQ5dkleoP8DNbH")
            Bugfender.enableCrashReporting()
            Bugfender.enableUIEventLogging()
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
        return true
    }
    // <!-- SMARTDOWN_OAUTH_SUPPORT -->    
    
}

extension AppDelegate: AppsFlyerLibDelegate {
    // Overriding the onConversionDataSuccess and onConversionDataFail
    // callbacks to process conversions and enable deferred deep linking
    
    func onConversionDataSuccess(_: [AnyHashable: Any]) {}
    
    func onConversionDataFail(_: Error) {}
}

// Google SignIn
extension AppDelegate {
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
//    private func handleGAILink(_ url: URL) {
//        let tracker1 = GAI.sharedInstance().tracker(withTrackingId: "...")
//                    let hitParams = GAIDictionaryBuilder()
//                    hitParams.setCampaignParametersFromUrl(path)
//                    let medium = self.getQueryStringParameter(url: path, param: "utm_medium")
//
//                    hitParams.set(medium, forKey: kGAICampaignMedium)
//                    hitParams.set(path, forKey: kGAICampaignSource)
//
//                    let hitParamsDict = hitParams.build()
//
//                    tracker1?.allowIDFACollection = true
//
//                    tracker1?.set(kGAIScreenName, value: "...")
//                    tracker1?.send(GAIDictionaryBuilder.createScreenView().setAll(hitParamsDict as? [AnyHashable : Any]).build() as? [AnyHashable : Any])
//    }
}
