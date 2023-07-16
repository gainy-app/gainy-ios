//
//  HomeViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import SwiftUI
import SwiftDate
import SkeletonView
import FloatingPanel
import GainyAPI
import GainyCommon
import MessageUI

final class HomeViewController: BaseViewController {
    
    var mainCoordinator: MainCoordinator?
    weak var authorizationManager: AuthorizationManager?
    
    //MARK: - Inner
    private var viewModel: HomeViewModel!
    private var refreshControl = UIRefreshControl()
    private var needReloadData = false
    private var modelPresentedFromWatchlist = false
    private var watchlistVC: WatchlistViewController? = nil
    
    //MARK: - Inner
    @IBOutlet private weak var nameLbl: UILabel!
    
    //MARK: - Outlets
    @IBOutlet private weak var wlView: UIView!
    @IBOutlet private weak var wlInfoLbl: UILabel!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.sectionHeaderHeight = UITableView.automaticDimension
            tableView.sectionFooterHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 144.0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 80.0
            tableView.backgroundColor = .clear
            tableView.showsHorizontalScrollIndicator = false
            tableView.showsVerticalScrollIndicator = false
            tableView.register(HomeKYCBannerViewCell.self, forCellReuseIdentifier: "HomeKYCBannerViewCell")
            tableView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
            tableView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        }
    }
    
    //Panel
    private var fpc: FloatingPanelController!
    
    //Hosted VCs
    private lazy var sortingCollectionsVC = SortCollectionsViewController.instantiate(.popups)
    private lazy var sortingWatchlistVC = SortCollectionDetailsViewController.instantiate(.popups)
    
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(authorizationManager: authorizationManager)
        tableView.dataSource = viewModel.dataSource
        tableView.delegate = viewModel.dataSource
        viewModel.dataSource.delegate = self
        setupPanel()
        subscribeOnOpenArticle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadBasedOnState()
        
        NotificationCenter.default.publisher(for: NotificationManager.homeTabPressedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.tableView.setContentOffset(.zero, animated: true)
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateWatchlist)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] notification in
            self?.viewModel.loadHomeData {
                DispatchQueue.main.async {
                    self?.viewModel.sortWatchlist()
                    self?.tableView.reloadData()
                    self?.watchlistVC?.watchlist = self?.viewModel.watchlist ?? []
                }
            }
        }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: NotificationManager.appBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] _ in
                if UserProfileManager.shared.profileID != nil {
                    self?.loadBasedOnState()
                }
            }.store(in: &cancellables)
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateScoringSettings)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] _ in
                if UserProfileManager.shared.profileID != nil {
                    self?.loadBasedOnState()
                }
            }.store(in: &cancellables)
    }
    
    private func loadBasedOnState() {
        tableView.contentOffset = .zero
        tableView.isSkeletonable = true
        nameLbl.text = ""
        nameLbl.skeletonCornerRadius = 6
        nameLbl.showAnimatedGradientSkeleton()
        view.showAnimatedGradientSkeleton()
        viewModel.loadHomeData { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableView?.hideSkeleton()
                self?.tableView?.reloadData()
                if let first = UserProfileManager.shared.firstName, let last = UserProfileManager.shared.lastName {
                    self?.nameLbl.text = "Hi, \(first)"
                } else {
                    self?.nameLbl.text = ""
                }
                self?.nameLbl.hideSkeleton()
                
                DeeplinkManager.shared.showDelayedTTF()
                DeeplinkManager.shared.showDelayedStock()
                DeeplinkManager.shared.activateDelayedTrading()
            }
        }
    }
    
    private func subscribeOnOpenArticle() {
        
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenArticleWithIdNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let articleID = status.object as? String else {
                    return
                }
                
                if let index = self?.viewModel.articles.firstIndex(where: { article in
                    article.id == articleID
                }) {
                    let indexPath = IndexPath.init(row: index, section: HomeDataSource.Section.articles.rawValue )
                    let numberOfSections = self?.tableView.numberOfSections
                    guard HomeDataSource.Section.articles.rawValue < numberOfSections ?? 0 else {
                        return
                    }
                    let numberOfItems = self?.tableView.numberOfRows(inSection: HomeDataSource.Section.articles.rawValue)
                    guard index < numberOfItems ?? 0 else {
                        return
                    }
                    self?.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.showAnimatedSkeleton()
        tableView.setContentOffset(.zero, animated: false)
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    override func userLoggedOut() {
        super.userLoggedOut()
        
    }
    
    @objc func refreshAction() {
        loadBasedOnState()
    }
    
    @IBAction private func inviteAction(_ sender: Any) {
        GainyAnalytics.logEventAMP("invite_friend_tapped", params: ["location" : "home"])
        mainCoordinator?.showReferralInviteView()
    }
    
    private func setupPanel() {
        fpc = FloatingPanelController()
        fpc.layout = SortWLPanelLayout()
        let appearance = SurfaceAppearance()
        
        // Define corner radius and background color
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear
        
        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        
        // Set a content view controller.
        sortingCollectionsVC.delegate = self
        sortingWatchlistVC.delegate = self
        sortingWatchlistVC.showWeight = false
        fpc.set(contentViewController: sortingCollectionsVC)
        fpc.isRemovalInteractionEnabled = true
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        //fpc.addPanel(toParent: self)
    }
    
    class SortWLPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
        
        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            switch state {
            case .full,
                    .half,
                    .tip: return 0.3
            default: return 0.0
            }
        }
    }
    
    class SortCollectionsPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 240, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 240, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 240, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
        
        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            switch state {
            case .full,
                    .half,
                    .tip: return 0.3
            default: return 0.0
            }
        }
    }
    
    //MARK: - Popup
    
    private var wlInfo: (stock: HomeTickerInnerTableViewCellModel, cell: HomeTickerInnerTableViewCell)?
    func showWLView(stock: HomeTickerInnerTableViewCellModel, cell: HomeTickerInnerTableViewCell) {
        wlInfo = (stock, cell)
        wlInfoLbl.text = "\(stock.name)\nadded to your watchlist!"
        wlView.isHidden = false
        wlTimer?.invalidate()
        wlTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false, block: {[weak self] _ in
            self?.hideWLView()
        })
    }
    
    private var wlTimer: Timer?
    @IBAction func closeWLViewAction(_ sender: Any) {
        hideWLView()
    }
    
    @IBAction func undoWLAction(_ sender: Any) {
        guard let wlInfo = wlInfo else {return}
        GainyAnalytics.logEvent("remove_from_watch_pressed", params: ["tickerSymbol" : wlInfo.stock.symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        UserProfileManager.shared.removeTickerFromWatchlist(wlInfo.stock.symbol) { success in
            if success {
                wlInfo.cell.isInWL = false
            }
        }
        hideWLView()
    }
    
    func hideWLView() {
        wlView.isHidden = true
    }
}

extension HomeViewController: HomeDataSourceDelegate {
    
    func wlPressed(stock: HomeTickerInnerTableViewCellModel, cell: HomeTickerInnerTableViewCell) {
        showWLView(stock: stock, cell: cell)
    }
    
    func articlePressed(article: WebArticle) {
        let articleVC = ArticleViewController.instantiate(.home)
        articleVC.articleUrl = article.url ?? ""
        present(articleVC, animated: true, completion: nil)
        
        GainyAnalytics.logEventAMP("home_article_tap", params: ["article_id" : article.id])
        feedbackGenerator?.impactOccurred()
    }
    
    func collectionSelected(collection: RemoteShortCollectionDetails, index: Int) {
        mainCoordinator?.presentCollectionDetails(initialCollectionIndex: index, delegate: self)
        GainyAnalytics.logEvent("home_coll_tap", params: ["colId" : collection.id ?? 0])
        AnalyticsKeysHelper.shared.ttfOpenSource = "home"
        feedbackGenerator?.impactOccurred()
        
        RecentViewedManager.shared.addViewedTTF(CollectionViewModelMapper.mapFromShort(collection))
    }
    
    func tickerSelected(ticker: RemoteTicker) {
        let list = viewModel.watchlist.compactMap({TickerInfo.init(ticker: $0)})
        let currentTickerIndex = list.firstIndex(where: {
            $0.symbol == ticker.symbol
        }) ?? 0
        RecentViewedManager.shared.addViewedStock(HomeTickerInnerTableViewCellModel.init(ticker: ticker))
        let controllers = mainCoordinator?.showCardsDetailsViewController(list, index: currentTickerIndex)
        GainyAnalytics.logEvent("home_wl_tap", params: ["symbol" : ticker.symbol])
        GainyAnalytics.logEventAMP("ticker_card_opened", params: ["tickerSymbol" : ticker.symbol, "isFromSearch" : false, "collectionID" : "none", "tickerType": ticker.type ?? "", "type" : ticker.type ?? "", "location" : "home"])
        feedbackGenerator?.impactOccurred()
        
        if let controllers = controllers {
            for controller in controllers {
                controller.modifyDelegate = self
            }
        }
    }
    
    func tickerSortCollectionsPressed() {
        sortingCollectionsVC.delegate = self
        fpc.layout = SortCollectionsPanelLayout()
        sortingCollectionsVC.updateButtons()
        self.fpc.set(contentViewController: sortingCollectionsVC)
        if let presented = self.presentedViewController, presented.isKind(of: WatchlistViewController.classForCoder()) == true {
            presented.present(self.fpc, animated: true)
        } else {
            guard self.presentedViewController == nil else {return}
            self.present(self.fpc, animated: true, completion: nil)
        }
        GainyAnalytics.logEvent("home_col_sorting_pressed", params: [:])
        GainyAnalytics.logEventAMP("wl_ttf_sort_tap")
        feedbackGenerator?.impactOccurred()
    }
    
    func tickerSortWLPressed() {
        sortingWatchlistVC.delegate = self
        sortingWatchlistVC.collectionId = Constants.CollectionDetails.watchlistCollectionID
        fpc.layout = SortWLPanelLayout()
        self.fpc.set(contentViewController: sortingWatchlistVC)
        if let presented = self.presentedViewController, presented.isKind(of: WatchlistViewController.classForCoder()) == true {
            presented.present(self.fpc, animated: true)
        } else {
            guard self.presentedViewController == nil else {return}
            self.present(self.fpc, animated: true, completion: nil)
        }
        GainyAnalytics.logEvent("home_wl_sorting_pressed", params: [:])
        GainyAnalytics.logEventAMP("wl_stock_sort_tapped")
        feedbackGenerator?.impactOccurred()
    }
    
    func expandWLPressed() {
        
        guard self.presentedViewController == nil else {return}
        self.watchlistVC = mainCoordinator?.showWatchlistViewController(self.viewModel?.watchlist ?? [], delegate: self)
        self.watchlistVC?.dismissHandler = {
            self.watchlistVC = nil
        }
        GainyAnalytics.logEvent("home_show_all_wl_tap", params: [:])
        GainyAnalytics.logEventAMP("wl_stock_show_all_tapped")
        feedbackGenerator?.impactOccurred()
    }
    
    func topTickerTapped(symbol: String) {
        if let ticker = viewModel?.getTopIndexBy(symbol: symbol) {
            let list = viewModel.topTickers.compactMap({TickerInfo.init(ticker: $0)})
            let currentTickerIndex = list.firstIndex(where: {
                $0.symbol == ticker.symbol
            }) ?? 0            
            let controllers = mainCoordinator?.showCardsDetailsViewController(list, index: currentTickerIndex)
            if let controllers = controllers {
                for controller in controllers {
                    controller.modifyDelegate = self
                }
            }
            GainyAnalytics.logEvent("home_index_tap", params: ["symbol" : symbol])
            feedbackGenerator?.impactOccurred()
        }
    }
    
    func balanceTapped() {
        tabBarController?.selectedIndex = CustomTabBar.Tab.portfolio.rawValue
        feedbackGenerator?.impactOccurred()
        GainyAnalytics.logEventAMP("home_balance_tapped")
    }
    
    func notifsTapped() {
        mainCoordinator?.showNotificationsView(viewModel.notifications)
        GainyAnalytics.logEventAMP("home_notification_tapped")
    }
    
    func collectionMoved(from fromIndex: Int, to toIndex: Int) {
        viewModel.swapCollections(from: fromIndex, to: toIndex)
        impactOccured()
        self.tableView.reloadData()
        GainyAnalytics.logEventAMP("wl_ttf_reordered")
    }
    
    func collectionDeleted() {
        if UserProfileManager.shared.favoriteCollections.isEmpty {
            delay(0.3) {                
                self.tabBarController?.selectedIndex = CustomTabBar.Tab.discovery.rawValue
            }
        } else {
            self.viewModel.loadHomeData { [weak self] in
                DispatchQueue.main.async {
                    self?.viewModel.sortFavCollections()
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func kycActionTapped(type: HomeKYCBannerViewCell.HomeKYCBannerType) {
        switch type {
        case .startKyc:
            GainyAnalytics.logEventAMP("verify_identity_tapped", params: ["location" : "home"])
            mainCoordinator?.dwShowKyc()
        case .continueKyc:
            GainyAnalytics.logEventAMP("kyc_continue_tapped", params: ["location" : "home"])
            mainCoordinator?.dwShowKyc()
        case .uploadDoc:
            mainCoordinator?.dwShowDocsUpload()
            break
        case .needInfo(let codes):
            mainCoordinator?.dwShowNeedInfoKyc(codes: codes)
            break
        case .deposit:
            GainyAnalytics.logEventAMP("deposit_tapped", params: ["location" : "home_banner"])
            mainCoordinator?.dwShowDeposit()
        case .pending:
            if let status = UserProfileManager.shared.kycStatus?.status {
                mainCoordinator?.handleKYCStatus(status, from: self)
            }
            break
        case .denied:
            if MFMailComposeViewController.canSendMail() {
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                let recipientEmail = "support@gainy.app"
                mailComposer.setToRecipients([recipientEmail])
                present(mailComposer, animated: true)
                
            } else if let emailUrl = URL.init(string: "support@gainy.app") {
                //WebPresenter.openLink(vc: self, url: emailUrl)
            }
        case .farewell:
            mainCoordinator?.dwShowWithdraw(from: self)
        }
        
    }
}

extension HomeViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            
            if let prevY = floatingPanelPreviousYPosition {
                shouldDismissFloatingPanel = prevY < vc.surfaceLocation.y
            }
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y
            let maxY = vc.surfaceLocation(for: .tip).y
            vc.surfaceLocation = CGPoint(x: loc.x, y: max(loc.y, minY))
            floatingPanelPreviousYPosition = max(loc.y, minY)
        }
    }
    
    func floatingPanelDidEndDragging(_ fpc: FloatingPanelController, willAttract attract: Bool) {
        if shouldDismissFloatingPanel {
            self.fpc.dismiss(animated: true, completion: nil)
        }
    }
}

extension HomeViewController: SortCollectionDetailsViewControllerDelegate {
    func selectionChanged(vc: SortCollectionDetailsViewController, sorting: String, isAscending: Bool) {
        GainyAnalytics.logEventAMP("wl_stock_sort_changed", params: ["sortBy" : sorting, "isDescending" : !isAscending])
        self.fpc.dismiss(animated: true, completion: nil)
        viewModel.sortWatchlist()
        self.tableView.reloadData()
        self.watchlistVC?.watchlist = self.viewModel.watchlist
    }
}

extension HomeViewController: SortCollectionsViewControllerDelegate {
    
    func selectionChanged(vc: SortCollectionsViewController, sorting: String, isAscending: Bool) {
        GainyAnalytics.logEventAMP("wl_ttf_sort_changed", params: ["sortBy" : sorting, "isDescending" : !isAscending])
        self.fpc.dismiss(animated: true, completion: nil)
        UserProfileManager.shared.collectionsReordered = false
        viewModel.sortFavCollections()
        self.tableView.reloadData()
    }
}

extension HomeViewController: SingleCollectionDetailsViewControllerDelegate {
    
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int) {
        self.mutateFavouriteCollections(isAdded: isAdded, collectionID: collectionID)
    }
    
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int) {
        self.tableView.reloadData()
    }
    
    private func mutateFavouriteCollections(isAdded: Bool, collectionID: Int) {
        
        if isAdded {
            if !UserProfileManager.shared.favoriteCollections.contains(collectionID) {
                UserProfileManager.shared.addFavouriteCollection(collectionID) { success in
                }
                CollectionsManager.shared.loadNewCollectionDetails(collectionID) {[weak self] remoteTickers in
                    self?.viewModel.loadHomeData { [weak self] in
                        DispatchQueue.main.async {
                            self?.viewModel.sortFavCollections()
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
        } else {
            if let _ = UserProfileManager.shared.favoriteCollections.firstIndex(of: collectionID) {
                UserProfileManager.shared.removeFavouriteCollection(collectionID) {[weak self] success in
                    UserProfileManager.shared.yourCollections.removeAll(where: {$0.id == collectionID})
                    self?.viewModel.loadHomeData { [weak self] in
                        DispatchQueue.main.async {
                            self?.viewModel.sortFavCollections()
                            if UserProfileManager.shared.yourCollections.isEmpty {
                                self?.tabBarController?.selectedIndex = CustomTabBar.Tab.discovery.rawValue
                            } else {
                                self?.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension HomeViewController: CollectionDetailsViewControllerDelegate {
    func collectionToggled(vc: CollectionDetailsViewController, isAdded: Bool, collectionID: Int) {
        self.viewModel.loadHomeData { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.sortFavCollections()
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: TickerViewControllerModifyDelegate {
    
    func didModifyWatchlistTickers(isAdded: Bool, tickerSymbol: String) {
        self.reloadWatchlistTickers(isAdded: isAdded, tickerSymbol: tickerSymbol)
    }
    
    private func reloadWatchlistTickers(isAdded: Bool, tickerSymbol: String) {        
        self.viewModel.loadHomeData { [weak self] in
            DispatchQueue.main.async {
                self?.viewModel.sortWatchlist()
                self?.tableView.reloadData()
                self?.watchlistVC?.watchlist = self?.viewModel.watchlist ?? []
            }
        }
    }
}

extension HomeViewController: WatchlistViewControllerDelegate {
    
    func tickerSelectedFromWL(ticker: RemoteTicker) {
        self.tickerSelected(ticker: ticker)
    }
    
    func sortingPressedFromWL() {
        self.tickerSortWLPressed()
    }
}

extension HomeViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
