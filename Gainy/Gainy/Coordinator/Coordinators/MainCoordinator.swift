import Firebase
import SwiftUI
import Combine
import UIKit
import GainyAPI
import GainyDriveWealth
import GainyCommon
import FloatingPanel


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
        self.dwCoordinator = DriveWealthCoordinator.init(analytics: GainyAnalytics.shared, network: Network.shared, profile: UserProfileManager.shared, remoteConfig: RemoteConfigManager.shared)
    }

    // MARK: Internal
    
    private var cancellables = Set<AnyCancellable>()
    private var lastDiscoverCollectionsVC: DiscoveryViewController?
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
        self.subscribeOnOpenHistory()
        self.subscribeOnOpenHistoryItem()
        self.subscribeOnOpenKYCStatus()
        self.subscribeOnOpenDeposit()
        subscribeOnOpenKYC()
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
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .sink { [weak self] status in
                guard let stockSymbol = status.object as? String else {
                    return
                }
                CollectionsManager.shared.getStocks(symbols: [stockSymbol]) { tickers in
                    for tickLivePrice in tickers.compactMap({$0.realtimeMetrics}) {
                        TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
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
    
    private func subscribeOnOpenKYC() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenKYCNotification, object: nil)
            .sink { [weak self] status in
                self?.dwShowKyc()
            }
            .store(in: &cancellables)
    }
    
    private func subscribeOnOpenDeposit() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenDepositNotification, object: nil)
            .sink { [weak self] status in
                self?.dwShowDeposit()
            }
            .store(in: &cancellables)
    }
    
    private func subscribeOnOpenHistoryItem() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenOrderDetailsNotification, object: nil)
            .sink { [weak self] notif in
                if let uniqID = notif.userInfo?["id"] as? String {
                    CollectionsManager.shared.getTradingHistoryById(uniqId: uniqID) { history in
                        if let history {
                            
                            var mode: DWHistoryOrderMode = .other(history: TradingHistoryFrag())
                            if let tradingCollectionVersion = history.tradingCollectionVersion {
                                if tradingCollectionVersion.targetAmountDelta ?? 0.0  >= 0.0 {
                                    mode = .buy(history: history)
                                } else {
                                    mode = .sell(history: history)
                                }
                            } else {
                                if let tradingOrder = history.tradingOrder {
                                    if tradingOrder.targetAmountDelta ?? 0.0  >= 0.0 {
                                        mode = .buy(history: history)
                                    } else {
                                        mode = .sell(history: history)
                                    }
                                } else {
                                    mode = .other(history: history)
                                }
                            }
                            
                            self?.dwShowExactHistory(mode: mode, name: history.name ?? "", amount: Double(history.amount ?? 0.0))
                        } else {
                            if let presentedViewController = self?.mainTabBarViewController?.presentedViewController {
                                self?.dwShowAllHistory(from: presentedViewController)
                            } else {
                                self?.dwShowAllHistory(from: self?.mainTabBarViewController)
                            }
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func subscribeOnOpenHistory() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenHistoryNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                if let presentedViewController = self?.mainTabBarViewController?.presentedViewController {
                    self?.dwShowAllHistory(from: presentedViewController)
                } else {
                    self?.dwShowAllHistory(from: self?.mainTabBarViewController)
                }
            }
            .store(in: &cancellables)
    }
    
    private func subscribeOnOpenKYCStatus() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenKYCStatusNotification, object: nil)
            .sink { [weak self] notif in
                if let statusRaw = notif.userInfo?["status"] as? String {
                    if let status = KYCStatus(rawValue: statusRaw) {
                        
                        if let presentedViewController = self?.mainTabBarViewController?.presentedViewController {
                            self?.dwShowKYCStatus(status: status, from: presentedViewController)
                        } else {
                            self?.dwShowKYCStatus(status: status, from: self?.mainTabBarViewController)
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
    public let coordinatorFactory: CoordinatorFactoryProtocol
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

    var collectionRouter: RouterProtocol?
    
    func showDiscoverCollectionsViewController( ) {
        collectionRouter?.popModule(transition: FadeTransitionAnimator(), animated: true)
    }

    func showCollectionDetailsViewController(with initialCollectionIndex: Int, for vc: CollectionDetailsViewController) {
        vc.viewModel?.initialCollectionIndex = initialCollectionIndex
        vc.centerInitialCollectionInTheCollectionView()
        let frame = vc.currentBackgroundImageFrame()
        
        if let lastDiscoverCollections = lastDiscoverCollectionsVC {
//            if let image = lastDiscoverCollections.snapshotForYourCollectionCell(at: initialCollectionIndex) {
//                let imageFrame = lastDiscoverCollections.frameForYourCollectionCell(at: initialCollectionIndex)
//                let imageView = UIImageView.init(image: image)
//                imageView.contentMode = .scaleAspectFill
//                imageView.clipsToBounds = true
//                lastDiscoverCollections.view.addSubview(imageView)
//                imageView.frame = imageFrame
//                lastDiscoverCollections.hideYourCollectionCell(at: initialCollectionIndex)
//
//                UIView.animate(withDuration: 0.35) {
//
//                    self.collectionRouter?.push(vc, transition: FadeTransitionAnimator(), animated: true)
//                    imageView.frame.origin.y = frame.origin.y
//
//                } completion: { finished in
//
//                    imageView.removeFromSuperview()
//                }
//
//            } else {
                collectionRouter?.push(vc, transition: FadeTransitionAnimator(), animated: true)
//            }
        } else {
            collectionRouter?.push(vc, transition: FadeTransitionAnimator(), animated: true)
        }
    }
    
    func showCollectionCategory(category: DiscoverySectionInfo, collections: [RecommendedCollectionViewCellModel], delegate: DiscoveryCategoryViewControllerDelegate?) {
    
        let vc = viewControllerFactory.instantiateDiscoverCategory(coordinator: self,
                                                                   category: category,
                                                                   categories: collections)
        vc.delegate = delegate
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
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
            if AnalyticsKeysHelper.shared.initialTTFFlag && haveNoFav {
                AnalyticsKeysHelper.shared.isFromDiscoveryInitial = true
            } else {
                AnalyticsKeysHelper.shared.isFromDiscoveryInitial = false
            }
            vc.modalTransitionStyle = .coverVertical
            router.showDetailed(vc)
            GainyAnalytics.logEvent("show_single_collection", params: ["collectionID" : collectionID])
        }
    }
    
    /// Present Collection Details at current index from Home tab
    /// - Parameter initialCollectionIndex: initial collection index
    func presentCollectionDetails(initialCollectionIndex: Int, delegate: CollectionDetailsViewControllerDelegate? = nil) {
        let detailsVC = self.viewControllerFactory.instantiateCollectionDetails(coordinator: self)
        detailsVC.viewModel?.initialCollectionIndex = initialCollectionIndex
        detailsVC.centerInitialCollectionInTheCollectionView()
        detailsVC.isFromHome = true
        detailsVC.delegate = delegate
        detailsVC.modalTransitionStyle = .coverVertical
        router.showDetailed(detailsVC)
    }
    
    func showBuyingPower() {
        let vc = self.viewControllerFactory.instantiateBuyingPower()
        vc.coordinator = self
        router.showDetailed(vc)
        GainyAnalytics.logEvent("show_compare_collection")
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
    
    func showNotificationsView(_ notifications: [ServerNotification] = []) {
        let vc = self.viewControllerFactory.instantiateNotificationsView()
        vc.mainCoordinator = self
        vc.notifications = notifications
        vc.modalTransitionStyle = .coverVertical
        vc.isModalInPresentation = true
        router.showDetailed(vc)
        GainyAnalytics.logEvent("show_promo_purchase_view")
    }
    
    func showNotificationView(_ notification: ServerNotification) {
        let vc = self.viewControllerFactory.instantiateNotificationView()
        vc.mainCoordinator = self
        vc.notification = notification
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
        GainyAnalytics.logEvent("show_promo_purchase_view")
    }
    
    func showHintsView(_ hints: [HintCellModel]) {
        let vc = self.viewControllerFactory.instantiateHintsView()
        vc.mainCoordinator = self
        vc.cellModels = hints
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
        GainyAnalytics.logEvent("show_hints")
    }
    
    func showProfileLinkAccount() {
        let vc = self.viewControllerFactory.instantiateProfileLinkAccountVC(coordinator: self)
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
    }
    
    func showReferralInviteView() {
        let vc = UIHostingController(rootView: ReferralInviteView())
        vc.modalTransitionStyle = .coverVertical
        router.showDetailed(vc)
        GainyAnalytics.logEvent("show_hints")
    }
        
    func showChartDisclaimerView(from vc: UIViewController? = nil) {
        GainyAnalytics.shared.logEventAMP("ttf_chart_disclaimer_tapped")
        // Set a content view controller.
        let chartVC = viewControllerFactory.instantiateChartDisclaimer()
        FloatingPanelManager.shared.configureWithHeight(height: 428.0)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: chartVC)
        FloatingPanelManager.shared.showFloatingPanel()
        router.showDetailed(FloatingPanelManager.shared.fpc)
    }
    
    class ShowComissionPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .half
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .half: FloatingPanelLayoutAnchor(absoluteInset: 428, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
        
        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            switch state {
            case .half: return 0.3
            default: return 0.0
            }
        }
    }
    
    //MARK: - Share
    
    private var sharedID = 0
    private var sharedSymbol = ""
    private var sharedProduct = ""
    
    func showShareTTF(id: Int) {
        sharedID = id
        sharedSymbol = ""
        sharedProduct = "ttf"
        GainyAnalytics.logEventAMP("share_tapped", params: ["collectionID" : id, "productType": "ttf"])
        showShareAlert(title: "Gainy: TTF share link", parameterName: "ttfId", parameterValue: "\(id)")
    }
    
    func showShareStock(symbol: String, type: String) {
        sharedID = 0
        sharedSymbol = symbol
        sharedProduct = type
        GainyAnalytics.logEventAMP("share_tapped", params: ["tickerSymbol" : symbol, "productType": type])
        showShareAlert(title: "Gainy: Stock share link - \(symbol)", parameterName: "stockSymbol", parameterValue: symbol)
    }
    
    private func showShareAlert(title: String, parameterName: String, parameterValue: String) {
        Task {
            let url = await DeeplinkManager.shared.getShareLink(title: title, parameterName: parameterName, parameterValue: parameterValue)
            if let url {
                await MainActor.run {
                    let items = [url]
                    let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                    ac.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
                                                                                    Bool, arrayReturnedItems: [Any]?, error: Error?) in
                                                                                        if completed {
                                                                                            GainyAnalytics.logEventAMP("share_link_success", params: ["collectionID" : self.sharedID,
                                                                                                                                                   "tickerSymbol" : self.sharedSymbol,
                                                                                                                                                   "productType": self.sharedProduct])
                                                                                            return
                                                                                        } else {
                                                                                            GainyAnalytics.logEventAMP("share_canceled", params: ["collectionID" : self.sharedID,
                                                                                                                                               "tickerSymbol" : self.sharedSymbol,
                                                                                                                                               "productType": self.sharedProduct])
                                                                                        }
                                                                                    }
                    router.showDetailed(ac)
                }
            }
        }
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
