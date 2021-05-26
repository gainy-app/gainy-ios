final class MainCoordinator: BaseCoordinator, CoordinatorFinishOutput {
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
        self.showAViewController()
    }

    // MARK: Private

    // MARK: Properties

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    // MARK: Functions

    private func showAViewController() {
        let aVC = self.viewControllerFactory.instantiateAViewController()
        aVC.onGoToB = { [unowned self] in
            self.showBViewController()
        }
        aVC.onGoToProfile = { [unowned self] in
            self.showProfile()
        }
        self.router.setRootModule(aVC, hideBar: true)
    }

    private func showBViewController() {
//        let bVC = self.viewControllerFactory.instantiateBViewController()
//        bVC.onBack = { [unowned self] in
//            self.router.popModule()
//        }
//        bVC.onLogout = { [unowned self] in
//            self.finishFlow?()
//        }
//        self.router.push(bVC)
    }

    private func showProfile() {
//        let coordinator = self.coordinatorFactory.makeProfileCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
//        coordinator.finishFlow = { [unowned self, unowned coordinator] in
//            self.removeDependency(coordinator)
//            self.router.popModule()
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
    }
}
