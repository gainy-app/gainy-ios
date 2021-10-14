import Firebase
import Combine
import UIKit

final class MainCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: Lifecycle

    init(authorizationManager: AuthorizationManager,
         router: RouterProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol,
         viewControllerFactory: ViewControllerFactory) {
        self.authorizationManager = authorizationManager
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: Internal
    
    private var cancellables = Set<AnyCancellable>()
    private var lastDiscoverCollectionsVC: DiscoverCollectionsViewController?
    
    // MARK: CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: Coordinator

    override func start() {
        showMainTabViewController()
        // TODO: Borysov - is this logic deprecated already? Need back to this and cleanup
//        if isLoggedIn {
//            //All fine )
//        } else {
//            //Show Onboarding
//        }
        self.subscribeOnFailToRefreshToken()
    }
    
    func subscribeOnFailToRefreshToken() {
        
        NotificationCenter.default.publisher(for: Notification.Name.didFailToRefreshToken).sink { _ in
        } receiveValue: { notification in
            if let finishFlow = self.finishFlow {
                self.authorizationManager.signOut()
                finishFlow()
            }
        }.store(in: &cancellables)
    }
    
    /// FIRUser status
    var isLoggedIn: Bool {
        
        return self.authorizationManager.isAuthorized()
    }

    // MARK: Private

    // MARK: Properties

    private let authorizationManager: AuthorizationManager
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private(set) var viewControllerFactory: ViewControllerFactory

    // MARK: Functions
    
    private func showMainTabViewController() {
        let vc = viewControllerFactory.instantiateMainTab(coordinator: self)
        vc.coordinator = self
        router.setRootModule(vc, hideBar: true)
    }

    func showDiscoverCollectionsViewController(showNextButton:Bool, onGoToCollectionDetails: ((Int) -> Void)?, onSwapItems: ((Int, Int) -> Void)?, onItemDelete: ((DiscoverCollectionsSection, Int) -> Void)?  ) {
        let vc = viewControllerFactory.instantiateDiscoverCollections(coordinator: self)
        vc.coordinator = self
        vc.onGoToCollectionDetails = onGoToCollectionDetails
        vc.onSwapItems = onSwapItems
        vc.onItemDelete = onItemDelete
        vc.showNextButton = showNextButton
        lastDiscoverCollectionsVC = vc
        // TODO: Borysov - custom transition
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

        // TODO: Borysov - custom transition make it better and move out of here
        vc.viewModel?.initialCollectionIndex = initialCollectionIndex
        vc.centerInitialCollectionInTheCollectionView()
        let frame = vc.currentBackgroundImageFrame()
        
        if let lastDiscoverCollections = lastDiscoverCollectionsVC {
            if let image = lastDiscoverCollections.snapshotForYourCollectionCell(at: initialCollectionIndex) {
                let imageFrame = lastDiscoverCollections.frameForYourCollectionCell(at: initialCollectionIndex)
                let imageView = UIImageView.init(image: image)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                lastDiscoverCollections.view.addSubview(imageView)
                imageView.frame = imageFrame
                lastDiscoverCollections.hideYourCollectionCell(at: initialCollectionIndex)
                
                UIView.animate(withDuration: 0.35) {
                    
                    self.router.popModule(transition: FadeTransitionAnimator(), animated: true)
                    imageView.frame.origin.y = frame.origin.y
                    
                } completion: { finished in
                    
                    imageView.removeFromSuperview()
                }

            } else {
                router.popModule(transition: FadeTransitionAnimator(), animated: true)
            }
        } else {
            router.popModule(transition: FadeTransitionAnimator(), animated: true)
        }
        print("\(frame)")
    }

    func showCardDetailsViewController(_ tickerInfo: TickerInfo) {
        let vc = self.viewControllerFactory.instantiateTickerDetails()
        vc.coordinator = self
        vc.viewModel = TickerDetailsViewModel(ticker: tickerInfo)
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
    
    func showCollectionDetails(collectionID: Int, delegate: SingleCollectionDetailsViewControllerDelegate? = nil) {
        let vc = self.viewControllerFactory.instantiateCollectionDetails(colID: collectionID)
        vc.delegate = delegate
        vc.coordinator = self
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
        GainyAnalytics.logEvent("show_single_collection", params: ["collectionID" : collectionID])
    }
}
