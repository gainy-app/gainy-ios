//
//  HoldingsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.11.2021.
//

import UIKit
import SkeletonView
import FloatingPanel
import Combine
import GainyAPI

protocol HoldingsViewControllerDelegate: AnyObject {
    func plaidUnlinked(controller: HoldingsViewController)
    func noHoldings(controller: HoldingsViewController)
}

final class HoldingsViewController: BaseViewController {
    
    var coordinator: MainCoordinator?
    var pieChartViewController: HoldingsPieChartViewController?
    
    //MARK: - Hosted VCs
    private lazy var sortingVC = SortPortfolioDetailsViewController.instantiate(.popups)
    private lazy var filterVC: PortfolioFilteringViewController = PortfolioFilteringViewController.instantiate(.portfolio)
    private lazy var linkUnlinkVC: LinkUnlinkPlaidViewController = LinkUnlinkPlaidViewController.instantiate(.portfolio)
    
    public weak var delegate: HoldingsViewControllerDelegate?
    
    //Panel
    private var fpc: FloatingPanelController!
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    
    
    @IBOutlet weak var viewModeButton: UIButton!
    
    //MARK: - Outlets
    
    private let refreshControl = LottieRefreshControl()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableView.automaticDimension
            tableView.sectionHeaderHeight = UITableView.automaticDimension
            tableView.sectionFooterHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 120.0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.backgroundColor = .clear
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.showsHorizontalScrollIndicator = false
            tableView.showsVerticalScrollIndicator = false
            tableView.dataSource = viewModel.dataSource
            tableView.delegate = viewModel.dataSource
            viewModel.dataSource.delegate = self
            tableView.refreshControl = refreshControl
            refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        }
    }
    
    //MARK: - Inner
    private(set) var viewModel = HoldingsViewModel()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupPanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.setContentOffset(.zero, animated: true)
        viewModel.dataSource.updateChart()
        tableView.reloadData()
        
        NotificationCenter.default.publisher(for: NotificationManager.portoTabPressedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.tableView.setContentOffset(.zero, animated: true)
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateScoringSettings)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: { notification in
            self.loadData()
        }.store(in: &cancellables)
        NotificationCenter.default.publisher(for: NotificationManager.dwTTFBuySellNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: { notification in
            self.loadData()
        }.store(in: &cancellables)
        NotificationCenter.default.publisher(for: NotificationManager.appBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] _ in
                if UserProfileManager.shared.profileID != nil {
                    self?.loadData()
                }
            }.store(in: &cancellables)
        subscribeOnOpenTicker()
    }
    
    @objc func loadData() {
        guard UserProfileManager.shared.profileID != nil else {
            return
        }
        guard viewModeButton.isUserInteractionEnabled else {return}
        viewModeButton.isUserInteractionEnabled = false
        tableView.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        
        showNetworkLoader()
        viewModel.loadHoldingsAndSecurities {[weak self] in
            if !(self?.viewModel.haveHoldings ?? false) {
                if let self = self {
                    self.delegate?.noHoldings(controller: self)
                }
            }
            self?.tableView.hideSkeleton()
            self?.viewModeButton.isUserInteractionEnabled = true
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            self?.hideLoader()
        }
    }
    
    @objc func animateLoad() {
        tableView.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    //MARK: - Actions
    
    func onSortButtonTapped() {
        
        guard self.presentedViewController == nil else {return}
        
        GainyAnalytics.logEvent("sorting_portfolio_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showSortingPanel()
    }
    
    func onLinkButtonTapped() {
        
        guard self.presentedViewController == nil else {return}
        
        GainyAnalytics.logEvent("link_button_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showLinkUnlinkPlaid()
    }
    
    @IBAction func onLinkButtonTapped(_ sender: UIButton) {
        
        self.onLinkButtonTapped()
    }
    
    @IBAction func onViewModeButtonTapped(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if !sender.isSelected {
            self.pieChartViewController?.willMove(toParent: nil)
            self.pieChartViewController?.view.removeFromSuperview()
            self.pieChartViewController?.removeFromParent()
            self.pieChartViewController = nil
            tableView.reloadData()
            GainyAnalytics.logEventAMP("portfolio_view_tapped", params: ["view" : "chart"])
            return
        }
        let holdingPieChartViewController = HoldingsPieChartViewController.init(viewModel: .init(isDemoProfile: false))
        holdingPieChartViewController.view.backgroundColor = self.view.backgroundColor
        self.addChild(holdingPieChartViewController)
        holdingPieChartViewController.view.frame = CGRect.init(x: 0, y: sender.frame.maxY, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(holdingPieChartViewController.view)
        holdingPieChartViewController.didMove(toParent: self)
        holdingPieChartViewController.view.isUserInteractionEnabled = true
        
        holdingPieChartViewController.onSettingsPressed = {
            self.onSettingsButtonTapped(isPie: true)
        }
        
        holdingPieChartViewController.onPlusPressed = {
            self.onLinkButtonTapped()
        }
        
        self.pieChartViewController = holdingPieChartViewController
        GainyAnalytics.logEvent("pie_chart_button_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        GainyAnalytics.logEventAMP("portfolio_view_tapped", params: ["view" : "piechart"])
    }
    
    func onSettingsButtonTapped(isPie: Bool = false) {
        
        guard self.presentedViewController == nil else {return}
        
        GainyAnalytics.logEvent("filter_portfolio_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showFilteringPanel(isPie: isPie)
    }
    
    func onConnectButtonTapped() {
        guard self.presentedViewController == nil else {return}
        
        GainyAnalytics.logEvent("reauth_portfolio_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showLinkUnlinkPlaid()
    }
    
    private func setupPanel() {
        fpc = FloatingPanelController()
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear
        fpc.surfaceView.appearance = appearance
        fpc.delegate = self // Optional
    }
    
    private func showSortingPanel() {
        
        let layout = MyFloatingPanelLayout()
        layout.height = 380.0
        fpc.layout = layout
        sortingVC.delegate = self
        fpc.set(contentViewController: sortingVC)
        fpc.isRemovalInteractionEnabled = true
        self.present(self.fpc, animated: true, completion: nil)
        GainyAnalytics.logEventAMP("portfolio_sort_tapped", params: ["view" : "chart"])
    }
    
    private func subscribeOnOpenTicker() {
        NotificationCenter.default.publisher(for: NotificationManager.requestOpenStockWithSymbolOnPortfolioNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let stockSymbol = status.object as? String else {
                    return
                }
                
                if let index = self?.viewModel.dataSource.holdings.firstIndex(where: { holding in
                    holding.tickerSymbol == stockSymbol
                }) {
                    let section = (self?.viewModel.dataSource.sectionsCount ?? 1) - 1
                    let indexPath = IndexPath.init(row: index, section: section)
                    
                    let numberOfSections = self?.tableView.numberOfSections
                    guard section < numberOfSections ?? 0 else {
                        return
                    }
                    let numberOfItems = self?.tableView.numberOfRows(inSection: section)
                    guard index < numberOfItems ?? 0 else {
                        return
                    }
                    
                    self?.tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.middle, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    private func showFilteringPanel(isPie: Bool = false) {
        
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        guard let settings = isPie ? PortfolioSettingsManager.pieShared.getSettingByUserID(userID) : PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        let brokers = (isPie ? settings.pieBrokers : UserProfileManager.shared.linkedBrokerAccounts).map { item -> PlaidAccountDataSource in
            let disabled = settings.disabledAccounts.contains { account in
                item.brokerUniqId == account.brokerUniqId
            }
            return PlaidAccountDataSource.init(accountData: item, enabled: !disabled)
        }
        
        let layout = MyFloatingPanelLayout()
        layout.height = min(250.0 + (64.0 * CGFloat(brokers.count)), self.view.bounds.height)
        fpc.layout = layout
        filterVC.delegate = self
        filterVC.configure(brokers, settings.interests, settings.categories, settings.includeClosedPositions, settings.onlyLongCapitalGainTax, isPie)
        fpc.set(contentViewController: filterVC)
        fpc.isRemovalInteractionEnabled = true
        self.present(self.fpc, animated: true, completion: nil)
        
        GainyAnalytics.logEventAMP("portfolio_fillter_view_tapped", params: ["view" : isPie ? "piechart" : "chart"])
    }
     
    private func showLinkUnlinkPlaid() {
        self.linkUnlinkVC.delegate = self
        self.linkUnlinkVC.configure(UserProfileManager.shared.linkedBrokerAccounts)
        let navigationController = UINavigationController.init(rootViewController: self.linkUnlinkVC)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    class MyFloatingPanelLayout: FloatingPanelLayout {
        public var height: CGFloat = 0.0
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: self.height, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: self.height, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: self.height, edge: .bottom, referenceGuide: .safeArea),
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
}

extension HoldingsViewController: SortPortfolioDetailsViewControllerDelegate {
    
    func selectionChanged(vc: SortPortfolioDetailsViewController, sorting: PortfolioSortingField, ascending: Bool) {
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        GainyAnalytics.logEventAMP("portfolio_sort_changed", params: ["view" : "chart", "sortBy" : sorting.title, "isDescending" : !ascending ])
        vc.dismiss(animated: true)
        viewModel.settings = settings
        tableView.reloadData()
        
        viewModel.clearChats()
        chartsForRangeRequested(range: viewModel.dataSource.chartRange,
                                viewModel: viewModel.dataSource.chartViewModel,
                                log: false)

        self.pieChartViewController?.reloadChartData()
        
    }
}

extension HoldingsViewController: LinkUnlinkPlaidViewControllerDelegate {
    
    func plaidLinked(controller: LinkUnlinkPlaidViewController) {
        
        self.tableView.reloadData()
        self.pieChartViewController?.reloadChartData()
    }
    
    func plaidUnlinked(controller: LinkUnlinkPlaidViewController) {
        
        self.delegate?.plaidUnlinked(controller: self)
        self.pieChartViewController?.reloadChartData()
    }
}

extension HoldingsViewController: PortfolioFilteringViewControllerDelegate {
    
    func didChangeFilterSettings(_ sender: PortfolioFilteringViewController) {
        
        guard let userID = UserProfileManager.shared.profileID else {return}
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {return}
        
        GainyAnalytics.logEvent("portfolio_sort_changed", params: ["view" : "chart", "sortBy" : settings.sorting.title, "isDescending" : !settings.ascending])
        viewModel.settings = settings
        tableView.reloadData()
        
        viewModel.clearChats()
        chartsForRangeRequested(range: viewModel.dataSource.chartRange,
                                viewModel: viewModel.dataSource.chartViewModel,
        log: false)
        
        self.pieChartViewController?.reloadChartData()
    }
}

extension HoldingsViewController: FloatingPanelControllerDelegate {
    
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            
            if let prevY = floatingPanelPreviousYPosition {
                shouldDismissFloatingPanel = prevY < vc.surfaceLocation.y
            }
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y
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

extension HoldingsViewController: HoldingsDataSourceDelegate {
    func onSettingsButtonTapped() {
        onSettingsButtonTapped(isPie: false)
    }
    
    func scrollChanged(_ offsetY: CGFloat) {
        refreshControl.updateProgress(with: offsetY)
    }
    
    func stockSelected(source: HoldingsDataSource, stock: RemoteTickerDetails) {
        coordinator?.showCardsDetailsViewController([TickerInfo.init(ticker: stock)], index: 0)
        GainyAnalytics.logEventAMP("ticker_card_opened", params: ["tickerSymbol" : stock.symbol, "tickerType" : "stock", "isFromSearch" : "false", "collectionID" : "none", "source" : "portfolio"])
    }
    
    func ttfSelected(source: HoldingsDataSource, collectionId: Int) {
        coordinator?.showCollectionDetails(collectionID: collectionId, delegate: self)
        let type = UserProfileManager.shared.favoriteCollections.contains(collectionId) ? "your" : "none"
        GainyAnalytics.logEventAMP("ttf_card_opened", params: ["id" : collectionId, "isFromSearch" : "false", "type": type, "source" : "portfolio"])
    }
    
    func chartsForRangeRequested(range: ScatterChartView.ChartPeriod, viewModel: HoldingChartViewModel, log: Bool = true) {
        
        guard let userID = UserProfileManager.shared.profileID else {return}
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {return}
        if log {
            GainyAnalytics.logEventAMP("portfolio_chart_period_changed", params: ["period" : range.rawValue])
        }
        
        self.viewModel.clearChats()
        showNetworkLoader()
        self.viewModel.loadChartsForRange(range: range, settings: settings) {[weak self] model in
            runOnMain {
                if let model = model {
                    self?.viewModel.dataSource.profileGains[range] = model
                    
                    if !(settings.isFilterApplied) {
                        viewModel.lastDayPrice = self?.viewModel.metrics?.lastDayPrice(range: range) ?? 0.0
                    } else {
                        viewModel.lastDayPrice = 0.0
                    }
//                    if !model.chartData.onlyPoints().isEmpty && !model.sypChartData.onlyPoints().isEmpty {
//                    viewModel.min = Double(min(model.sypChartData.onlyPoints().min() ?? 0.0, model.chartData.onlyPoints().min() ?? 0.0))
//                    viewModel.max = Double(max(model.sypChartData.onlyPoints().max() ?? 0.0, model.chartData.onlyPoints().max() ?? 0.0))
//                    }
//                    if model.sypChartData.onlyPoints().isEmpty {
                        viewModel.min = model.chartData.onlyPoints().min() ?? 0.0
                        viewModel.max = model.chartData.onlyPoints().max() ?? 0.0
                    //}
                    if viewModel.lastDayPrice != 0.0 {
                        viewModel.min = min(Double(viewModel.min ?? 0.0), Double(viewModel.lastDayPrice))
                        viewModel.max = max(Double(viewModel.max ?? 0.0), Double(viewModel.lastDayPrice))
                    }
                    
                    viewModel.chartData = model.chartData
                                        
                    viewModel.spGrow = model.spGrow
                    viewModel.sypChartData = model.sypChartData
                    
                    if model.chartData.onlyPoints().count < 2 {
                        GainyAnalytics.logEventAMP("portfolio_not_enough_data_shown")
                    }
                }
                self?.hideLoader()
            }
            
        }
    }
    
    func requestOpenCollection(withID id: Int) {
        coordinator?.showCollectionDetails(collectionID: id, delegate: self)
    }
    
    func onBuyingPowerSelect() {
        coordinator?.showBuyingPower()
        GainyAnalytics.logEventAMP("buying_power_tapped")
    }
    
    func onPendingOrdersSelect() {
        coordinator?.dwShowAllHistory()
        GainyAnalytics.logEventAMP("pending_orders_tapped")
    }
}

extension HoldingsViewController: SingleCollectionDetailsViewControllerDelegate {
    
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int) {
        self.mutateFavouriteCollections(senderCell: nil, isAdded: isAdded, collectionID: collectionID)
    }
    
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int) {
        
    }
    
    private func mutateFavouriteCollections(senderCell: RecommendedCollectionViewCell? = nil, isAdded: Bool, collectionID: Int) {
        
        if isAdded {
            if !UserProfileManager.shared.favoriteCollections.contains(collectionID) {
                UserProfileManager.shared.addFavouriteCollection(collectionID) { success in
                    if let cell = senderCell {
                        cell.setButtonChecked(isChecked: success)
                    }
                }
                CollectionsManager.shared.loadNewCollectionDetails(collectionID) { remoteTickers in
                    
                }
            }
        } else {
            if let _ = UserProfileManager.shared.favoriteCollections.firstIndex(of: collectionID) {
                UserProfileManager.shared.removeFavouriteCollection(collectionID) { success in
                    if let cell = senderCell {
                        cell.setButtonChecked(isChecked: !success)
                    }
                }
            }
        }
    }
}

