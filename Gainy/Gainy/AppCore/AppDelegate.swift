import AppsFlyerLib
import UIKit
import Firebase
import CoreData
import GoogleSignIn

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Internal

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] != nil {
            GainyAnalytics.logEvent("first_launch", params: ["source": "push"])
        } else {
            GainyAnalytics.logEvent("first_launch", params: ["source": "normal"])
        }
        
        initializeAppsFlyer()
        initFirebase()
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
        AppsFlyerLib.shared().start()
    }

    private func initializeAppsFlyer() {
        AppsFlyerLib.shared().appsFlyerDevKey = BundleReader().appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = AFConfig.appId
        AppsFlyerLib.shared().delegate = self

        #if DEBUG
            AppsFlyerLib.shared().isDebug = true
        #endif

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
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        GainyAnalytics.logEvent("app_open", params: ["user_id" : "anonymous"])
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        GainyAnalytics.logEvent("app_close", params: ["user_id" : "anonymous"])
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
}
