import Foundation

final class ProfileCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: - CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: - Vars & Lets

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    // MARK: - Private methods

    private func showProfileViewController() {
        let profileVC = self.viewControllerFactory.instantiateProfileViewController()
        profileVC.onBack = { [unowned self] in
            self.finishFlow?()
        }
        profileVC.onChangePassword = { [unowned self, weak profileVC] in
            self.showForgetPassword(module: profileVC!)
        }
        self.router.push(profileVC)
    }

    private func showForgetPassword(module: ProfileViewController) {
//        let coordinator = self.coordinatorFactory.makeChangePasswordCoordinatorBox(router: self.router, viewControllerFactory: self.viewControllerFactory)
//        coordinator.finishFlow = { [unowned self, weak module, unowned coordinator] in
//            self.removeDependency(coordinator)
//            self.router.popToModule(module: module , animated: true)
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
    }

    // MARK: - Coordinator

    override func start() {
        self.showProfileViewController()
    }

    // MARK: - Init

    init(router: RouterProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol,
         viewControllerFactory: ViewControllerFactory
    ) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
}
