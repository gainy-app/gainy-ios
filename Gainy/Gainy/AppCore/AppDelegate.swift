import AppsFlyerLib
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: Internal

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeAppsFlyer()

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
}

extension AppDelegate: AppsFlyerLibDelegate {
    // Overriding the onConversionDataSuccess and onConversionDataFail
    // callbacks to process conversions and enable deferred deep linking

    func onConversionDataSuccess(_: [AnyHashable: Any]) {}

    func onConversionDataFail(_: Error) {}
}
