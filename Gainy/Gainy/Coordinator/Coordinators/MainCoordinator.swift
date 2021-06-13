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
        showCollectionDetailsViewController(with: 0)
    }

    // MARK: Private

    // MARK: Properties

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory

    // MARK: Functions

    private func showDiscoverCollectionsViewController() {
        let vc = viewControllerFactory.instantiateDiscoverCollections()
        vc.onGoToCollectionDetails = { [weak self] initialPosition in
            self?.showCollectionDetailsViewController(with: initialPosition)
        }

        router.setRootModule(vc, hideBar: true)
    }

    private func showCollectionDetailsViewController(with initialCollectionIndex: Int) {
        let vc = self.viewControllerFactory.instantiateCollectionDetails()
        vc.onDiscoverCollections = { [weak self] in
            self?.router.popModule(transition: FadeTransitionAnimator(),
                                   animated: true)
        }
        vc.onShowCardDetails = { [weak self] in
            self?.showCardDetailsViewController()
        }
        vc.viewModel?.initialCollectionIndex = initialCollectionIndex

        router.push(vc, transition: FadeTransitionAnimator(), animated: true)
    }

    private func showCardDetailsViewController() {
        let vc = self.viewControllerFactory.instantiateCardDetails()
        vc.onDismiss = { [weak self] in
            self?.router.dismissModule()
        }

        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
}
