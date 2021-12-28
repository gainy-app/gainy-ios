//
//  HoldingsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.11.2021.
//

import UIKit
import SkeletonView
import FloatingPanel

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
    
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var sortButton: ResponsiveButton! {
        didSet {
            sortButton.layer.cornerRadius = 8.0
            sortButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var settingsButton: ResponsiveButton! {
       didSet {
           settingsButton.layer.cornerRadius = 8.0
           settingsButton.clipsToBounds = true
       }
   }
    @IBOutlet weak var linkPlaidButton: UIButton!
    
    //MARK: - Outlets
    
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
    }
    
    func loadData(){
        settingsButton.isUserInteractionEnabled = false
        sortButton.isUserInteractionEnabled = false
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
            self?.settingsButton.isUserInteractionEnabled = true
            self?.sortButton.isUserInteractionEnabled = true
            self?.linkPlaidButton.isUserInteractionEnabled = true
            self?.updateSortButton()
            self?.updateFilterButtonTitle()
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func onSortButtonTapped(_ sender: Any) {
        
        guard self.presentedViewController == nil else {return}

        GainyAnalytics.logEvent("sorting_portfolio_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showSortingPanel()
    }
    
    @IBAction func onLinkButtonTapped(_ sender: Any) {
        
        guard self.presentedViewController == nil else {return}

        GainyAnalytics.logEvent("link_button_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showLinkUnlinkPlaid()
    }
    
    @IBAction func onSettingsButtonTapped(_ sender: Any) {
        
        guard self.presentedViewController == nil else {return}

        GainyAnalytics.logEvent("sorting_portfolio_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        self.showFilteringPanel()
    }
    
    private func updateSortButton() {
        
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }

        let title = settings.sorting.title
        sortLabel.text = title
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
        layout.height = min(420.0 + 64.0 * CGFloat(brokers.count), self.view.bounds.height)
        fpc.layout = layout
        filterVC.delegate = self
        filterVC.configure(brokers, settings.interests, settings.categories, settings.securityTypes, settings.includeClosedPositions, settings.onlyLongCapitalGainTax)
        fpc.set(contentViewController: filterVC)
        fpc.isRemovalInteractionEnabled = true
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    private func updateFilterButtonTitle() {
        
        guard let userID = UserProfileManager.shared.profileID else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        
        let selectedInterests = settings.interests.filter { item in
            item.selected
        }
        let selectedCategories = settings.categories.filter { item in
            item.selected
        }
        let selectedSecurityTypes = settings.securityTypes.filter { item in
            item.selected
        }
        let selectedSum = selectedInterests.count + selectedCategories.count + selectedSecurityTypes.count + settings.disabledAccounts.count
        self.settingsLabel.text = selectedSum > 0 ? "Filter applied" : "All"
    }
    
    private func showLinkUnlinkPlaid() {
        
        self.linkUnlinkVC.delegate = self
        self.linkUnlinkVC.configure(UserProfileManager.shared.linkedPlaidAccessTokens)
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
        updateSortButton()
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
        self.updateFilterButtonTitle()
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
    func stockSelected(source: HoldingsDataSource, stock: RemoteTickerDetailsFull) {
        coordinator?.showCardsDetailsViewController([TickerInfo.init(ticker: stock.fragments.remoteTickerDetails)], index: 0)
    }
    
    func chartsForRangeRequested(range: ScatterChartView.ChartPeriod) {
        showNetworkLoader()
        
        hideLoader()
    }
}

