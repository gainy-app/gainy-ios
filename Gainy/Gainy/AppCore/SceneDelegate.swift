import UIKit
import AppTrackingTransparency
import AdSupport
import FacebookCore
import FirebaseAuth

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: Internal

    // MARK: Properites

    var window: UIWindow?

    var rootController: UINavigationController {
        guard let vc = self.window?.rootViewController as? UINavigationController else {
            return UINavigationController()
        }

        return vc
    }

    func scene(_ scene: UIScene,
               willConnectTo _: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController()
        self.window = window
        window.makeKeyAndVisible()

        appCoordinator.start(with: nil)
        
        Settings.setAdvertiserTrackingEnabled(true)
        
        var isFromPush = connectionOptions.notificationResponse != nil
        var fbParams: [String : AnyHashable] = ["source": isFromPush ? "push" : "normal"]
        // Determine who sent the URL.
        if let urlContext = connectionOptions.urlContexts.first {

            let sendingAppID = urlContext.options.sourceApplication
            let url = urlContext.url

            guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                    let params = components.queryItems else {
                        if UserDefaults.isFirstLaunch() {
                            GainyAnalytics.logEvent("first_launch", params: fbParams)
                        }
                        return
                }

                if let cmVal = params.first(where: { $0.name == "сm" })?.value {
                    fbParams["cm"] = cmVal
                }
            if let cnVal = params.first(where: { $0.name == "cn" })?.value {
                fbParams["cn"] = cnVal
            }
            if let csVal = params.first(where: { $0.name == "cs" })?.value {
                fbParams["cs"] = csVal
            }
        }
        if UserDefaults.isFirstLaunch() {
            GainyAnalytics.logEvent("first_launch", params: fbParams)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }

    func sceneWillEnterForeground(_: UIScene) {
        if !UIDevice.current.hasTopNotch {
            if let navController = window?.rootViewController as? UINavigationController {
                navController.setStatusBar(backgroundColor: .black)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.requestTrackingAuthorization()
        }
    }
    
    //MARK: - Open/Close
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        GainyAnalytics.logEvent("app_open", params: ["user_id" : Auth.auth().currentUser?.uid ?? "anonymous" ])
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        GainyAnalytics.logEvent("app_close", params: ["user_id" : Auth.auth().currentUser?.uid ?? "anonymous"])
    }

    // MARK: Private
    
    private func requestTrackingAuthorization() {
        guard #available(iOS 14, *) else { return }
        ATTrackingManager.requestTrackingAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized:
                    dprint("Got IDFA")
                    print(self.identifierForAdvertising())
                case .denied, .restricted:
                    dprint("Denied IDFA")
                case .notDetermined:
                    dprint("Not Determined IDFA")
                @unknown default:
                    break
                }
            }
        }
    }
    
    private func identifierForAdvertising() -> String? {
        // check if advertising tracking is enabled in user’s setting
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            return nil
        }
    }
    // MARK: Properties

    private lazy var appCoordinator: Coordinator = AppCoordinator(
        authorizationManager: AuthorizationManager(),
        router: Router(rootController: self.rootController),
        coordinatorFactory: CoordinatorFactory()
    )
    
    //MARK: - UTM/Deeplink
        
}
