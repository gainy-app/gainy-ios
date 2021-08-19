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

    func showDiscoverCollectionsViewController(onGoToCollectionDetails: ((Int) -> Void)?) {
        let vc = viewControllerFactory.instantiateDiscoverCollections(coordinator: self)
        vc.onGoToCollectionDetails = onGoToCollectionDetails
        router.push(vc, transition: FadeTransitionAnimator(), animated: true)
    }

    func showCollectionDetailsViewController(with initialCollectionIndex: Int, for vc: CollectionDetailsViewController) {
//        let vc = self.viewControllerFactory.instantiateCollectionDetails(coordinator: self)
//        vc.onDiscoverCollections = { [weak self] in
//            self?.showDiscoverCollectionsViewController(onGoToCollectionDetails: { [weak self]  initialPosition in
//                self?.router.popModule(transition: FadeTransitionAnimator(), animated: true)
//
//                //Animating to selected position
//                vc.viewModel?.initialCollectionIndex = initialCollectionIndex
//                vc.centerInitialCollectionInTheCollectionView()
//            })
//        }
//        vc.onShowCardDetails = { [weak self] in
//            self?.showCardDetailsViewController(TickerInfo())
//        }
//        vc.viewModel?.initialCollectionIndex = initialCollectionIndex

        router.popModule(transition: FadeTransitionAnimator(), animated: true)
        vc.viewModel?.initialCollectionIndex = initialCollectionIndex
        vc.centerInitialCollectionInTheCollectionView()
    }

    private func showCardDetailsViewController(_ tickerInfo: TickerInfo) {
        let vc = self.viewControllerFactory.instantiateTickerDetails()
        vc.coordinator = self
        vc.viewModel = TickerDetailsViewModel(ticker: tickerInfo)
//        vc.onDismiss = { [weak self] in
//            self?.router.dismissModule()
//        }

        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
}
