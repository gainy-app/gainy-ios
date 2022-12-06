import UIKit
import FacebookCore
import FirebaseAuth
import OneSignal
import FirebaseDynamicLinks
import GoogleSignIn
import Branch

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Internal
    private(set) var preloadVC: ConfigLoaderViewController = ConfigLoaderViewController.instantiate(.popups)
    private var configuration = Configuration()
    // MARK: Properites
    
    var window: UIWindow?
    private lazy var blurView = makeBlurView()
    
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
        
        if configuration.environment == .production {
            if let userActivity = connectionOptions.userActivities.first {
                BranchScene.shared().scene(scene, continue: userActivity)
            } else if !connectionOptions.urlContexts.isEmpty {
                BranchScene.shared().scene(scene, openURLContexts: connectionOptions.urlContexts)
            }
        }
        
        Settings.shared.isAdvertiserTrackingEnabled = true
        
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
        addPreloadOverlay()
    }
    
    private func addPreloadOverlay() {
        guard Auth.auth().currentUser == nil else {
            RemoteConfigManager.shared.loadDefaults {
            }
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                print("User accepted notification: \(accepted)")
                GainyAnalytics.logEvent("pushes_status", params: ["accepted" : accepted])
            })
            return
        }
        
        insertPreloadOverlay()
    }
    
    func insertPreloadOverlay() {
        if preloadVC.view.superview == nil {
            preloadVC.view.frame = window?.rootViewController?.view.frame ?? .zero
            if let view = preloadVC.view {
                window?.rootViewController?.view.addSubview(view)
                preloadVC.startLoading()
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
        if configuration.environment == .production {
            BranchScene.shared().scene(scene, openURLContexts: URLContexts)
        }
        
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
    
    //MARK: - Deeplinks
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if configuration.environment == .production {
            BranchScene.shared().scene(scene, continue: userActivity)
        }
    }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
    -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    func sceneWillEnterForeground(_: UIScene) {
        if !UIDevice.current.hasTopNotch {
            if let navController = window?.rootViewController as? UINavigationController {
                navController.setStatusBar(backgroundColor: .black)
            }
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        guard let blurView, let window else { return }
        if !blurView.isDescendant(of: window) {
            window.addSubview(blurView)
        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        guard let blurView, let window else { return }
        if !blurView.isDescendant(of: window) {
            window.addSubview(blurView)
        }
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        guard let blurView, let window else { return }
        if blurView.isDescendant(of: window) {
            blurView.removeFromSuperview()
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        guard let blurView, let window else { return }
        if blurView.isDescendant(of: window) {
            blurView.removeFromSuperview()
        }
    }
    
    //MARK: - Open/Close
    
    // MARK: Private
    
    
    // MARK: Properties
    
    private lazy var appCoordinator: Coordinator = AppCoordinator(
        authorizationManager: AuthorizationManager(),
        router: Router(rootController: self.rootController),
        coordinatorFactory: CoordinatorFactory()
    )
    
    private func makeBlurView() -> UIView? {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        guard let window else { return nil }
        view.frame = window.bounds
        return view
    }
    
    //MARK: - UTM/Deeplink
}
