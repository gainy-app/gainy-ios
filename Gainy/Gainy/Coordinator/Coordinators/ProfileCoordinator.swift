import Foundation

final class ProfileCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: Lifecycle

    init(router: RouterProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol,
         viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: Internal

    // MARK: CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: Coordinator

    override func start() {
        self.showProfileViewController()
    }

    // MARK: Private

    // MARK: Properties

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    // MARK: Functions

    private func showProfileViewController() {
        let profileVC = self.viewControllerFactory.instantiateProfile()
        profileVC.onBack = { [unowned self] in
            self.finishFlow?()
        }
        profileVC.onChangePassword = { [unowned self, weak profileVC] in
            self.showForgetPassword(module: profileVC!)
        }
        self.router.push(profileVC)
    }

    private func showForgetPassword(module _: ProfileViewController) {
//        let coordinator = self.coordinatorFactory.makeChangePasswordCoordinatorBox(router: self.router, viewControllerFactory: self.viewControllerFactory)
//        coordinator.finishFlow = { [unowned self, weak module, unowned coordinator] in
//            self.removeDependency(coordinator)
//            self.router.popToModule(module: module , animated: true)
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
    }
}
