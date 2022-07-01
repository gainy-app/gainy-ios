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

protocol HoldingsViewControllerDelegate: AnyObject {
    func plaidUnlinked(controller: HoldingsViewController)
    func noHoldings(controller: HoldingsViewController)
}

final class HoldingsViewController: BaseViewController {
    
    var coordinator: MainCoordinator?
    
    //MARK: - Hosted VCs
    private lazy var sortingVC = SortPortfolioDetailsViewController.instantiate(.popups)
    private lazy var filterVC: PortfolioFilteringViewController = PortfolioFilteringViewController.instantiate(.portfolio)
    private lazy var linkUnlinkVC: LinkUnlinkPlaidViewController = LinkUnlinkPlaidViewController.instantiate(.portfolio)
    
    public weak var delegate: HoldingsViewControllerDelegate?
    
    //Panel
    private var fpc: FloatingPanelController!
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    
    
    @IBOutlet weak var linkPlaidButton: UIButton!
    
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
        
        NotificationCenter.default.publisher(for: NotificationManager.portoTabPressedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.tableView.setContentOffset(.zero, animated: true)
            }
            .store(in: &cancellables)
    }
    
    @objc func loadData() {
        guard UserProfileManager.shared.profileID != nil else {
            return
        }
        guard linkPlaidButton.isUserInteractionEnabled else {return}
        linkPlaidButton.isUserInteractionEnabled = false
        tableView.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        viewModel.loadHoldingsAndSecurities {[weak self] in
            if !(self?.viewModel.haveHoldings ?? false) {
                if let self = self {
                    self.delegate?.noHoldings(controller: self)
                }
            }
            self?.tableView.hideSkeleton()
            self?.linkPlaidButton.isUserInteractionEnabled = true
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
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
    
    @IBAction func onLinkButtonTapped(_ sender: Any) {
        
        guard self.presentedViewController == nil else {return}
        
        GainyAnalytics.logEvent("link_button_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showLinkUnlinkPlaid()
    }
    
    func onSettingsButtonTapped() {
        
        guard self.presentedViewController == nil else {return}
        
        GainyAnalytics.logEvent("sorting_portfolio_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showFilteringPanel()
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
        layout.height = 420.0
        fpc.layout = layout
        sortingVC.delegate = self
        fpc.set(contentViewController: sortingVC)
        fpc.isRemovalInteractionEnabled = true
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    private func showFilteringPanel() {
        
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        let brokers = UserProfileManager.shared.linkedPlaidAccounts.map { item -> PlaidAccountDataSource in
            let disabled = settings.disabledAccounts.contains { account in
                item.id == account.id
            }
            return PlaidAccountDataSource.init(accountData: item, enabled: !disabled)
        }
        
        let layout = MyFloatingPanelLayout()
        layout.height = min(380.0 + 64.0 * CGFloat(brokers.count) - 64.0, self.view.bounds.height)
        fpc.layout = layout
        filterVC.delegate = self
        filterVC.configure(brokers, settings.interests, settings.categories, settings.securityTypes, settings.includeClosedPositions, settings.onlyLongCapitalGainTax)
        fpc.set(contentViewController: filterVC)
        fpc.isRemovalInteractionEnabled = true
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    private func showLinkUnlinkPlaid() {
        
        self.linkUnlinkVC.delegate = self
        self.linkUnlinkVC.configure(UserProfileManager.shared.linkedPlaidAccounts)
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
        
        vc.dismiss(animated: true)
        viewModel.settings = settings
        tableView.reloadData()
        
        viewModel.clearChats()
        chartsForRangeRequested(range: viewModel.dataSource.chartRange,
                                viewModel: viewModel.dataSource.chartViewModel)
        
    }
}

extension HoldingsViewController: LinkUnlinkPlaidViewControllerDelegate {
    
    func plaidLinked(controller: LinkUnlinkPlaidViewController) {
        
    }
    
    func plaidUnlinked(controller: LinkUnlinkPlaidViewController) {
        
        self.delegate?.plaidUnlinked(controller: self)
    }
}

extension HoldingsViewController: PortfolioFilteringViewControllerDelegate {
    
    func didChangeFilterSettings(_ sender: PortfolioFilteringViewController) {
        
        guard let userID = UserProfileManager.shared.profileID else {return}
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {return}
        viewModel.settings = settings
        tableView.reloadData()
        
        viewModel.clearChats()
        chartsForRangeRequested(range: viewModel.dataSource.chartRange,
                                viewModel: viewModel.dataSource.chartViewModel)        
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
    func scrollChanged(_ offsetY: CGFloat) {
        refreshControl.updateProgress(with: offsetY)
    }
    
    func stockSelected(source: HoldingsDataSource, stock: RemoteTickerDetailsFull) {
        coordinator?.showCardsDetailsViewController([TickerInfo.init(ticker: stock.fragments.remoteTickerDetails)], index: 0)
    }
    
    func chartsForRangeRequested(range: ScatterChartView.ChartPeriod, viewModel: HoldingChartViewModel) {
        
        guard let userID = UserProfileManager.shared.profileID else {return}
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {return}
        
        self.viewModel.clearChats()
        showNetworkLoader()
        self.viewModel.loadChartsForRange(range: range, settings: settings) {[weak self] model in
            runOnMain {
                if let model = model {
                    self?.viewModel.dataSource.profileGains[range] = model
                    
                    viewModel.lastDayPrice = Float(self?.viewModel.metrics?.lastDayPrice(range: range) ?? 0.0)
                    
                    viewModel.min = Double(min(model.sypChartData.onlyPoints().min() ?? 0.0, model.chartData.onlyPoints().min() ?? 0.0))
                    viewModel.max = Double(max(model.sypChartData.onlyPoints().max() ?? 0.0, model.chartData.onlyPoints().max() ?? 0.0))
                    if model.sypChartData.onlyPoints().isEmpty {
                        viewModel.min = model.chartData.onlyPoints().min() ?? 0.0
                        viewModel.max = model.chartData.onlyPoints().max() ?? 0.0
                    }
                    if viewModel.lastDayPrice != 0.0 && range == .d1 {
                        viewModel.min = min(Double(viewModel.min ?? 0.0), Double(viewModel.lastDayPrice))
                        viewModel.max = max(Double(viewModel.max ?? 0.0), Double(viewModel.lastDayPrice))
                    }
                    
                    viewModel.chartData = model.chartData
                    viewModel.rangeGrow = model.rangeGrow
                    viewModel.rangeGrowBalance = model.rangeGrowBalance
                    viewModel.spGrow = model.spGrow
                    viewModel.sypChartData = model.sypChartData
                }
                self?.hideLoader()
            }
            
        }
    }
    
    func requestOpenCollection(withID id: Int) {
        coordinator?.showCollectionDetails(collectionID: id, delegate: self)
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

