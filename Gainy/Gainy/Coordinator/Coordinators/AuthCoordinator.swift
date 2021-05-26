import UIKit

final class AuthCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: Lifecycle

    init(router: RouterProtocol, coordinatorFactory: CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: Internal

    // MARK: CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: - Coordinator

    override func start() {
        self.showLoginViewController()
    }

    // MARK: Private

    // MARK: Properies

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    // MARK: Functions

    private func showLoginViewController() {
        let loginVC = self.viewControllerFactory.instantiateLoginViewController()
        loginVC.onLogin = { [unowned self] in
            self.finishFlow?()
        }
        loginVC.onRegister = { [unowned self] in
            self.showRegisterViewController()
        }
        loginVC.onChangePassword = { [unowned self, unowned loginVC] in
            self.showForgetPassword(module: loginVC)
        }
        self.router.setRootModule(loginVC, hideBar: true)
    }

    private func showRegisterViewController() {
//        let registerVC = self.viewControllerFactory.instantiateRegisterViewController()
//        registerVC.onBack = { [unowned self] in
//            self.router.popModule()
//        }
//        registerVC.onRegister = { [unowned self] in
//            self.router.popModule()
//        }
//        self.router.push(registerVC)
    }

    private func showForgetPassword(module _: LoginViewController) {
//        let coordinator = self.coordinatorFactory.makeChangePasswordCoordinatorBox(router: self.router, viewControllerFactory: self.viewControllerFactory)
//        coordinator.finishFlow = { [unowned self, weak module, unowned coordinator] in
//            self.removeDependency(coordinator)
//            self.router.popToModule(module: module , animated: true)
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
    }
}
