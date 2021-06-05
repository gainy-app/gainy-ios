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
        showDiscoverCollectionsViewController()
    }

    // MARK: Private

    // MARK: Properties

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    // MARK: Functions

    private func showDiscoverCollectionsViewController() {
        let vc = viewControllerFactory.instantiateDiscoverCollections()
        vc.onGoToDiscoverCards = { [weak self] in
            self?.showDiscoverCardsViewController()
        }

        router.setRootModule(vc, hideBar: true)
    }

    private func showDiscoverCardsViewController() {
        let vc = self.viewControllerFactory.instantiateDiscoverCards()
        vc.onDiscoverCollections = { [weak self] in
            self?.router.popModule()
        }

        router.push(vc)
    }
}
