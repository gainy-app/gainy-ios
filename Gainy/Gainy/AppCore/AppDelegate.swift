import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
//    // MARK: Internal
//
//    // MARK: Properites
//
//    var window: UIWindow?
//
//    var rootController: UINavigationController {
//        guard let vc = self.window?.rootViewController as? UINavigationController else {
//            return UINavigationController()
//        }
//
//        return vc
//    }

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        self.appCoordinator.start(with: nil)

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

//    // MARK: Private
//
//    // MARK: Properties
//
//    private lazy var appCoordinator: Coordinator = AppCoordinator(
//        router: Router(rootController: self.rootController),
//        coordinatorFactory: CoordinatorFactory()
//    )
}
