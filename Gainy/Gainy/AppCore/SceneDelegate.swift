import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
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
               options _: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController()
        self.window = window
        window.makeKeyAndVisible()

        appCoordinator.start(with: nil)
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
        router: Router(rootController: self.rootController),
        coordinatorFactory: CoordinatorFactory()
    )
}
