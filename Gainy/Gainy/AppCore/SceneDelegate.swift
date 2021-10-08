import UIKit

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
        
        var isFromPush = connectionOptions.notificationResponse != nil
        var fbParams: [String : AnyHashable] = ["source": isFromPush ? "push" : "normal"]
        // Determine who sent the URL.
        if let urlContext = connectionOptions.urlContexts.first {

            let sendingAppID = urlContext.options.sourceApplication
            let url = urlContext.url

            guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                    let params = components.queryItems else {
                        GainyAnalytics.logEvent("first_launch", params: fbParams)
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
        GainyAnalytics.logEvent("first_launch", params: fbParams)
    }

    func sceneWillEnterForeground(_: UIScene) {
        if !UIDevice.current.hasTopNotch {
            if let navController = window?.rootViewController as? UINavigationController {
                navController.setStatusBar(backgroundColor: .black)
            }
        }
    }

    // MARK: Private

    // MARK: Properties

    private lazy var appCoordinator: Coordinator = AppCoordinator(
        authorizationManager: AuthorizationManager(),
        router: Router(rootController: self.rootController),
        coordinatorFactory: CoordinatorFactory()
    )
    
    //MARK: - UTM/Deeplink
        
}
