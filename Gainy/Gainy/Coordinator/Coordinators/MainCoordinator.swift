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
        self.showDiscoverCollectionsViewController()
    }

    // MARK: Private

    // MARK: Properties

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    // MARK: Functions

    private func showDiscoverCollectionsViewController() {
        let vc = self.viewControllerFactory.instantiateDiscoverCollections()
        vc.onGoToCollectionDetails = { [unowned self] in
            self.showCollectionDetailsViewController()
        }

        self.router.setRootModule(vc, hideBar: true)
    }

    private func showCollectionDetailsViewController() {
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
