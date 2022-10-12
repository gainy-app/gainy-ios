import Firebase
import Combine
import UIKit
import GainyAPI
import GainyDriveWealth

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
        self.dwCoordinator = DriveWealthCoordinator.init(analytics: GainyAnalytics.shared, network: Network.shared)
    }

    // MARK: Internal
    
    private var cancellables = Set<AnyCancellable>()
    private var lastDiscoverCollectionsVC: DiscoverCollectionsViewController?
    private(set) var dwCoordinator: DriveWealthCoordinator?
    
    // MARK: CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: Coordinator

    override func start() {
        showMainTabViewController()
        self.subscribeOnFailToRefreshToken()
        self.subscribeOnOpenHome()
        self.subscribeOnOpenPortfolio()
        self.subscribeOnOpenTTF()
    }
    
    private func openHome() {
        if let vc = self.mainTabBarViewController {
            if let tabBar = vc.tabBar as? CustomTabBar {
                guard vc.selectedIndex != 0 else { return }
                tabBar.selectedIndex = CustomTabBar.Tab(rawValue: 0)!
                tabBar.updateTabs()
                vc.selectedIndex = 0
            }
        }
    }
    
    private func openPortfolio() {
        if let vc = self.mainTabBarViewController {
            if let tabBar = vc.tabBar as? CustomTabBar {
                guard vc.selectedIndex != 2 else { return }
                tabBar.selectedIndex = CustomTabBar.Tab(rawValue: 2)!
                tabBar.updateTabs()
                vc.selectedIndex = 2
            }
        }
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
                self?.openHome()
            }
            .store(in: &cancellables)
    }
    
    private func subscribeOnOpenPortfolio() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenPortfolioNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.openPortfolio()
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
        
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenStockWithIdNotification, object: nil)
            .sink { [weak self] status in
                guard let stockSymbol = status.object as? String else {
                    return
                }
                CollectionsManager.shared.getStocks(symbols: [stockSymbol]) { tickers in
                    for tickLivePrice in tickers.compactMap({$0.realtimeMetrics}) {
                        TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol, data: tickLivePrice)
                    }
                    DispatchQueue.main.async {
                        if let firstStock = tickers.first {
                            _ = self?.showCardsDetailsViewController([TickerInfo.init(ticker: firstStock)], index: 0)
                        }
                    }
                }
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
        
        #if DEBUG
        delay(2.0) {
            self.dwShowKyc()
        }
        #endif
    }

    var collectionRouter: RouterProtocol?
    
    func showDiscoverCollectionsViewController( ) {
        collectionRouter?.popModule(transition: FadeTransitionAnimator(), animated: true)
    }
    
    func _showDiscoverCollectionsViewController(showNextButton:Bool, onGoToCollectionDetails: ((Int) -> Void)?, onSwapItems: ((Int, Int) -> Void)?, onItemDelete: ((DiscoverCollectionsSection, Int) -> Void)?  ) {
        let vc = viewControllerFactory.instantiateDiscoverCollections(coordinator: self)
        vc.hidesBottomBarWhenPushed = false
        vc.coordinator = self
        vc.onGoToCollectionDetails = onGoToCollectionDetails
        vc.onSwapItems = onSwapItems
        vc.onItemDelete = onItemDelete
        vc.showNextButton = showNextButton
        lastDiscoverCollectionsVC = vc
        collectionRouter?.push(vc, transition: FadeTransitionAnimator(), animated: true)
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
                    
                    self.collectionRouter?.push(vc, transition: FadeTransitionAnimator(), animated: true)
                    imageView.frame.origin.y = frame.origin.y
                    
                } completion: { finished in
                    
                    imageView.removeFromSuperview()
                }

            } else {
                collectionRouter?.push(vc, transition: FadeTransitionAnimator(), animated: true)
            }
        } else {
            collectionRouter?.push(vc, transition: FadeTransitionAnimator(), animated: true)
        }
    }
    
    

    func _showCardDetailsViewController(_ tickerInfo: TickerInfo) {
        let vc = self.viewControllerFactory.instantiateTickerDetails()
        vc.coordinator = self
        vc.viewModel = TickerDetailsViewModel(ticker: tickerInfo)
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
    
    func showCardsDetailsViewController(_ tickerInfos: [TickerInfo], index: Int) -> [TickerViewController]  {
        
        let vc = viewControllerFactory.instantiateTickersPages()
        var controllers: [UIViewController] = []
        var tickerDetails: [TickerViewController] = []
        for tickerInfo in tickerInfos {
            let vcInner = self.viewControllerFactory.instantiateTickerDetails()
            vcInner.coordinator = self
            vcInner.viewModel = TickerDetailsViewModel(ticker: tickerInfo)
            controllers.append(vcInner)
            tickerDetails.append(vcInner)
        }
        vc.stockControllers = controllers
        vc.initialIndex = index
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
        return tickerDetails
    }
    
    func showWatchlistViewController(_ watchlist: [RemoteTickerDetails], delegate: WatchlistViewControllerDelegate?) -> WatchlistViewController {
    
        let vc = viewControllerFactory.instantiateWatchlistVC()
        vc.watchlist = watchlist
        vc.delegate = delegate
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
        return vc
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
    
    func showCollectionDetails(collectionID: Int, delegate: SingleCollectionDetailsViewControllerDelegate? = nil, isFromSearch: Bool = false, collection: RemoteShortCollectionDetails? = nil, haveNoFav: Bool = false) {
        if let coll = collection {
            let vc = self.viewControllerFactory.instantiateCollectionDetails(colID: collectionID, collection: coll)
            vc.delegate = delegate
            vc.coordinator = self
            vc.isFromSearch = isFromSearch
            vc.haveNoFav = haveNoFav
            vc.modalTransitionStyle = .coverVertical
            router.showDetailed(vc)
            GainyAnalytics.logEvent("show_single_collection", params: ["collectionID" : collectionID])
        } else {
            let vc = self.viewControllerFactory.instantiateCollectionDetails(colID: collectionID)
            vc.delegate = delegate
            vc.coordinator = self
            vc.isFromSearch = isFromSearch
            vc.haveNoFav = haveNoFav
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
    
    func showPurchaseView(delegate: PurchaseViewControllerDelegate? = nil) {
        let vc = self.viewControllerFactory.instantiatePurchases()
        vc.coordinator = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = delegate
        router.showDetailed(vc)
        
        let variants = [Product.month(RemoteConfigManager.shared.monthPurchaseVariant ?? .a).identifier,
                        Product.month6(RemoteConfigManager.shared.month6PurchaseVariant ?? .a).identifier,
                        Product.year(RemoteConfigManager.shared.yearPurchaseVariant ?? .a).identifier
        ]
        
        GainyAnalytics.logEvent("show_purchase_view", params: ["variants" : variants])
    }
    
    func showPromoPurchaseView() {
        let vc = self.viewControllerFactory.instantiatePromoPurchases()
        vc.coordinator = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        router.showDetailed(vc)
        GainyAnalytics.logEvent("show_promo_purchase_view")
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
