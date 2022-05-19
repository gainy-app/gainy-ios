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
        self.onboardingInfoBuilder = OnboardingInfoBuilder.init()
    }

    // MARK: Internal
    
    private var cancellables = Set<AnyCancellable>()
    private var lastDiscoverCollectionsVC: DiscoverCollectionsViewController?
    
    // MARK: CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: Coordinator

    override func start() {
        showMainTabViewController()
        self.subscribeOnFailToRefreshToken()
        self.subscribeOnOpenHome()
        self.subscribeOnOpenTTF()
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
    
    private func subscribeOnOpenHome() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenHomeNotification, object: nil)
            .sink { [weak self] status in
                if let vc = self?.mainTabBarViewController {
                    if let tabBar = vc.tabBar as? CustomTabBar {
                        tabBar.selectedIndex = CustomTabBar.Tab(rawValue: 0)!
                        tabBar.updateTabs()
                        vc.selectedIndex = 0
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func subscribeOnOpenTTF() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenCollectionWithIdNotification, object: nil)
            .sink { [weak self] status in
                guard let collectionID = status.object as? Int else {
                    return
                }
                self?.showCollectionDetails(collectionID: collectionID, delegate:  self, isFromSearch: true)
            }
            .store(in: &cancellables)
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
    private(set) var onboardingInfoBuilder: OnboardingInfoBuilder
    private(set) var mainTabBarViewController: MainTabBarViewController?

    // MARK: Functions
    
    private func showMainTabViewController() {
        let vc = viewControllerFactory.instantiateMainTab(coordinator: self)
        vc.coordinator = self
        self.mainTabBarViewController = vc
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
        router.push(vc, transition: FadeTransitionAnimator(), animated: true)
    }

    func showCollectionDetailsViewController(with initialCollectionIndex: Int, for vc: CollectionDetailsViewController) {
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

    func _showCardDetailsViewController(_ tickerInfo: TickerInfo) {
        let vc = self.viewControllerFactory.instantiateTickerDetails()
        vc.coordinator = self
        vc.viewModel = TickerDetailsViewModel(ticker: tickerInfo)
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
    
    func showCardsDetailsViewController(_ tickerInfos: [TickerInfo], index: Int) {
        
        let vc = viewControllerFactory.instantiateTickersPages()
        var controllers: [UIViewController] = []
        for tickerInfo in tickerInfos {
            let vcInner = self.viewControllerFactory.instantiateTickerDetails()
            vcInner.coordinator = self
            vcInner.viewModel = TickerDetailsViewModel(ticker: tickerInfo)
            controllers.append(vcInner)
        }
        vc.stockControllers = controllers
        vc.initialIndex = index
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
    
    func showBrokersViewController(symbol: String, delegate: BrokersViewControllerDelegate?) {
        let vc = self.viewControllerFactory.instantiateBrokersList()
        vc.symbol = symbol
        vc.delegate = delegate
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
    
    func showMetricsViewController(ticker: RemoteTicker, collectionID: Int?, delegate: MetricsViewControllerDelegate?) {
        let vc = self.viewControllerFactory.instantiateMetricsList()
        vc.ticker = ticker
        vc.collectionID = collectionID
        vc.delegate = delegate
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
    
    func showCollectionDetails(collectionID: Int, delegate: SingleCollectionDetailsViewControllerDelegate? = nil, isFromSearch: Bool = false, collection: RemoteShortCollectionDetails? = nil) {
        if let coll = collection {
            let vc = self.viewControllerFactory.instantiateCollectionDetails(colID: collectionID, collection: coll)
            vc.delegate = delegate
            vc.coordinator = self
            vc.isFromSearch = isFromSearch
            vc.modalTransitionStyle = .coverVertical
            router.showDetailed(vc)
            GainyAnalytics.logEvent("show_single_collection", params: ["collectionID" : collectionID])
        } else {
            let vc = self.viewControllerFactory.instantiateCollectionDetails(colID: collectionID)
            vc.delegate = delegate
            vc.coordinator = self
            vc.isFromSearch = isFromSearch
            vc.modalTransitionStyle = .coverVertical
            router.showDetailed(vc)
            GainyAnalytics.logEvent("show_single_collection", params: ["collectionID" : collectionID])
        }
    }
    
    func showCompareDetails(model: CollectionDetailViewCellModel, delegate: SingleCollectionDetailsViewControllerDelegate? = nil) {
        let vc = self.viewControllerFactory.instantiateCompareDetails(model: model)
        vc.delegate = delegate
        vc.coordinator = self
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
        GainyAnalytics.logEvent("show_compare_collection")
    }
}

extension MainCoordinator: SingleCollectionDetailsViewControllerDelegate {
    
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int) {
        self.mutateFavouriteCollections(isAdded: isAdded, collectionID: collectionID)
    }
    
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int) {
        
    }
    
    private func mutateFavouriteCollections(isAdded: Bool, collectionID: Int) {
        
        if isAdded {
            if !UserProfileManager.shared.favoriteCollections.contains(collectionID) {
                UserProfileManager.shared.addFavouriteCollection(collectionID) { success in
                }
                CollectionsManager.shared.loadNewCollectionDetails(collectionID) { remoteTickers in
                }
            }
        } else {
            if let _ = UserProfileManager.shared.favoriteCollections.firstIndex(of: collectionID) {
                UserProfileManager.shared.removeFavouriteCollection(collectionID) { success in
                }
            }
        }
    }
}
