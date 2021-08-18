import Firebase


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
        showMainTabViewController()
        if isLoggedIn {
            //All fine )
        } else {
            //Show Onboarding
        }
    }
    
    /// FIRUser status
    var isLoggedIn: Bool {
        Auth.auth().currentUser != nil
    }

    // MARK: Private

    // MARK: Properties

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private(set) var viewControllerFactory: ViewControllerFactory

    // MARK: Functions
    
    private func showMainTabViewController() {
        let vc = viewControllerFactory.instantiateMainTab(coordinator: self)
        vc.coordinator = self
        router.setRootModule(vc, hideBar: true)
    }

    @available(*, deprecated, message: "This is initial Tab 1")
    private func showDiscoverCollectionsViewController() {
        let vc = viewControllerFactory.instantiateDiscoverCollections(coordinator: self)
        router.push(vc, transition: FadeTransitionAnimator(), animated: true)
    }

    func showCollectionDetailsViewController(with initialCollectionIndex: Int) {
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
