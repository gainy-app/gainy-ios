import UIKit
import SkeletonView

// TODO: move into a separate file
protocol CardDetailsViewModelProtocol {
    //    var initialCollectionIndex: Int { get set }
    //    var collectionDetails: [CollectionDetailViewCellModel] { get set }
}

protocol TickerViewControllerDelegate {
    
    func didUpdateTickerMetrics()
}

protocol TickerViewControllerModifyDelegate {
    
    func didModifyWatchlistTickers(isAdded: Bool, tickerSymbol: String)
}

final class TickerViewController: BaseViewController {
    
    //MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: TickerDetailsViewModel?
    var delegate: TickerViewControllerDelegate? = nil
    var modifyDelegate: TickerViewControllerModifyDelegate? = nil
    
    //MARK: - Outlets
    @IBOutlet private weak var wlView: UIView!
    @IBOutlet private weak var wlInfoLbl: UILabel!
    private let refreshControl = LottieRefreshControl()
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel?.dataSource
            tableView.delegate = viewModel?.dataSource
            tableView.refreshControl = refreshControl
            viewModel?.dataSource.delegate = self
            refreshControl.addTarget(self, action: #selector(refreshTicketInfo), for: .valueChanged)
        }
    }
    @IBOutlet private weak var wrongIndView: UIView!
    @IBOutlet private weak var wrongIndLbl: UILabel!
    @IBOutlet private weak var tradeBtn: BorderButton! {
        didSet {
            tradeBtn.layer.borderWidth = 0.0
            tradeBtn.setTitle("Invest".uppercased(), for: .normal)
            tradeBtn.titleLabel?.font = .compactRoundedMedium(16.0)
            tradeBtn.titleLabel?.setKern(kern: 2.0, color: UIColor.white)
            tradeBtn.titleLabel?.font = UIFont.proDisplaySemibold(16.0)
            tradeBtn.titleLabel?.textAlignment = .center
            tradeBtn.titleLabel?.adjustsFontSizeToFitWidth = true
            tradeBtn.setTitleColor(UIColor.white, for: .normal)
            
        }
    }
    
    //MARK:- Inner
    
    private var lastYOffset: CGFloat? = nil
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomView()
        
//        NotificationCenter.default.publisher(for: NotificationManager.ttfChartVscrollNotification)
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//        } receiveValue: {[weak self] notification in
//            if let dy = notification.userInfo?["v"] as? CGFloat, let curOff = self?.tableView.contentOffset {
//                if self?.lastYOffset == nil {
//                    self?.lastYOffset = curOff.y
//                }
//
//                if let lastYOffset = self?.lastYOffset {
//                    print(dy)
//                    self?.tableView.contentOffset = CGPoint(x: curOff.x, y: lastYOffset + dy)
//                    print(CGPoint(x: curOff.x, y: lastYOffset + dy))
//                }
//            } else {
//                self?.lastYOffset = nil
//                print("reset")
//            }
//        }.store(in: &cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func refreshTicketInfo() {
        delay(0.5) {
            self.loadTicketInfo()
        }
    }
    
    @objc func loadTicketInfo(fromRefresh: Bool = true) {
        refreshControl.endRefreshing()
        viewModel?.dataSource.ticker.isChartDataLoaded = false
        if let viewModel = viewModel {
            if RemoteConfigManager.shared.isInvestBtnVisible {
                tradeBtn.isHidden = viewModel.ticker.isIndex || viewModel.ticker.isCrypto
            } else {
                tradeBtn.isHidden = true
            }
        } else {
            tradeBtn.isHidden = !RemoteConfigManager.shared.isInvestBtnVisible
        }
        
        if !fromRefresh {
            guard !(self.viewModel?.dataSource.ticker.isMainDataLoaded ?? false) else {return}
        }
        
        tableView.contentOffset = .zero
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            GainyAnalytics.logEvent("no_internet")
            return
        }
        
        delay(1.0) {
            if !(self.viewModel?.dataSource.ticker.isMainDataLoaded ?? true) {
                self.isLoadingInfo = true
            }
        }
        viewModel?.dataSource.chartLoader.startAnimating()
        dprint("SHOWING LOADER")
        viewModel?.dataSource.ticker.loadDetails(mainDataLoaded: {[weak self] in
            dprint("DISMISS LOADIER")
            DispatchQueue.main.async {
                
                self?.isLoadingInfo = false
                self?.viewModel?.dataSource.calculateHeights()
                //self?.tableView.reloadData()
            }
        }, chartsLoaded: { [weak self] in
            DispatchQueue.main.async {
                dprint("DISMISS chart loader")
                self?.viewModel?.dataSource.stopLoader()
                self?.viewModel?.dataSource.updateChart()
            }
        })
    }
    
    @MainActor private var isLoadingInfo: Bool = false {
        didSet {
            if isLoadingInfo {
                print("SHOWING SKELTON")
                for cell in tableView.visibleCells {
                    if let rightCell = cell as? TickerDetailsViewCell {
                        if !(cell is TickerDetailsChartViewCell) {
                            rightCell.showAnimatedGradientSkeleton()
                        }
                    }
                }
                tableView.isScrollEnabled = false
                tableView.isUserInteractionEnabled = false
            } else {
                print("HIDING SKELTON")
                for cell in tableView.visibleCells {
                    if let rightCell = cell as? TickerDetailsViewCell {
                        rightCell.hideSkeleton()
                        rightCell.updateFromTickerData()
                    }
                }
                tableView.isScrollEnabled = true
                tableView.isUserInteractionEnabled = true
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func shareAction(_ sender: Any) {
        
        guard let symbol = viewModel?.dataSource.ticker.symbol else {
            return
        }
        if let currentBroker = UserProfileManager.shared.selectedBrokerToTrade {
            if let url = currentBroker.brokerURLWithSymbol(symbol: symbol) {
                WebPresenter.openLink(vc: self, url: url)
                GainyAnalytics.logEvent("ticker_shared", params: ["tickerSymbol" : symbol])
            }
            return
        }
        
        self.showBrokersList()
    }
    
    private func showBrokersList() {
        
        guard let symbol = viewModel?.dataSource.ticker.symbol else {
            return
        }
        
        self.coordinator?.showBrokersViewController(symbol: symbol, delegate: self)
    }
    
    @IBAction func compareStocksAction(_ sender: UIButton) {
       
        guard let ticker = viewModel?.dataSource.ticker else {
            return
        }
        
        self.openCompareWithSelf(ticker: ticker)
    }
    
    @IBAction func addToWatchlistToggleAction(_ sender: UIButton) {
        
        guard let symbol = viewModel?.dataSource.ticker.symbol else {
            return
        }
        
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == symbol
        }
        if addedToWatchlist {
            GainyAnalytics.logEvent("remove_from_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.removeTickerFromWatchlist(symbol) { success in
                if success {
                    sender.isSelected = false
                    guard let cell = self.viewModel?.dataSource.headerCell else {
                        return
                    }
                    cell.updateAddToWatchlistToggle()
                    self.modifyDelegate?.didModifyWatchlistTickers(isAdded: false, tickerSymbol: symbol)
                }
            }
        } else {
            GainyAnalytics.logEvent("add_to_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.addTickerToWatchlist(symbol) { success in
                if success {
                    sender.isSelected = true
                    guard let cell = self.viewModel?.dataSource.headerCell else {
                        return
                    }
                    cell.updateAddToWatchlistToggle()
                    self.modifyDelegate?.didModifyWatchlistTickers(isAdded: true, tickerSymbol: symbol)
                }
            }
        }
    }
    
    @IBAction func closeViewAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func viewAllMetricsAction(_ sender: Any) {
        
        guard let ticker = viewModel?.ticker.ticker else {
            return
        }
        self.coordinator?.showMetricsViewController(ticker:ticker, collectionID: nil, delegate: self)
    }
    //MARK: - Bottom action
    
    /// Model to cahnge bottom view
    private var bottomViewModel: CollectionsBottomViewModel?
    
    private var bottomViews: [UIView] = []
    
    /// Bottom action view adding
    fileprivate func addBottomView() {
        bottomViewModel = CollectionsBottomViewModel.init(actionTitle: "Compare \((viewModel?.tickersToCompare.count ?? 0) + 1) stocks", actionIcon: "compare_icon")
        var bottomView = CollectionsBottomView(model: bottomViewModel!)
        bottomView.delegate = self
        let hosting = CustomHostingController.init(shouldShowNavigationBar: false, rootView: bottomView)
        addChild(hosting)
        hosting.view.frame = CGRect.init(x: 0, y: 0, width: 50, height: 94)
        hosting.view.backgroundColor = .clear
        view.addSubview(hosting.view)
        hosting.view.autoPinEdge(.leading, to: .leading, of: view)
        hosting.view.autoPinEdge(.trailing, to: .trailing, of: view)
        hosting.view.autoSetDimension(.height, toSize: 94)
        hosting.view.autoPinEdge(.bottom, to: .bottom, of: view)
        hosting.didMove(toParent: self)
        bottomViews.append(hosting.view)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.view.backgroundColor = .white
        
        self.bottomViews.forEach({$0.alpha = 0; $0.isUserInteractionEnabled = false;})
    }
    
    //MARK: - Wrong Ind Logic
    
    private var wrongIndTimer: Timer?
    @IBAction func closeWrongIndViewAction(_ sender: Any) {
        hideWrongIndView()
    }
    
    @IBAction func undoWrongIndViewAction(_ sender: Any) {
        guard let symbol = viewModel?.ticker.symbol else {return}
        guard let cell = tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as? TickerDetailsRecommendedViewCell else {return}

        if WrongIndustryManager.shared.isIndWrong(symbol) {
            GainyAnalytics.logEvent("wrong_industry_undo", params: ["timestamp": Date().timeIntervalSinceReferenceDate,   "ticker_symbol": viewModel?.ticker.symbol ?? "",
                                                                       "tag_ids": viewModel?.ticker.tags.compactMap({$0.id}) ?? [],
                                                                       "tag_names": viewModel?.ticker.tags.compactMap({$0.name}) ?? []])
            WrongIndustryManager.shared.removeFromWrong(symbol)
            cell.unhighlightIndustries()
        } else {
            GainyAnalytics.logEvent("wrong_industry", params: ["timestamp": Date().timeIntervalSinceReferenceDate,   "ticker_symbol": viewModel?.ticker.symbol ?? "",
                                                                       "tag_ids": viewModel?.ticker.tags.compactMap({$0.id}) ?? [],
                                                                       "tag_names": viewModel?.ticker.tags.compactMap({$0.name}) ?? []])
            WrongIndustryManager.shared.addToWrong(symbol)
            cell.highlightIndustries()
        }
        hideWrongIndView()
    }
    
    //MARK: - WL Popup
    
    private var wlInfo: (stock: AltStockTicker, cell: HomeTickerInnerTableViewCell)?
    func showWLView(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        wlInfo = (stock, cell)
        wlInfoLbl.text = "\(stock.name ?? "")\nadded to your watchlist!"
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
        GainyAnalytics.logEvent("remove_from_watch_pressed", params: ["tickerSymbol" : wlInfo.stock.symbol ?? "", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        UserProfileManager.shared.removeTickerFromWatchlist(wlInfo.stock.symbol ?? "") { success in
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
extension TickerViewController: TickerDetailsDataSourceDelegate {
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        showWLView(stock: stock, cell: cell)
    }
    
    
    func didRequestShowBrokersListForSymbol(symbol: String) {
        
        self.coordinator?.showBrokersViewController(symbol: symbol, delegate: self)
    }
    
    func isStockCompared(stock: AltStockTicker) -> Bool {
        viewModel?.tickersToCompare.contains(where: {$0.symbol == stock.symbol}) ?? false
    }
    
    func altStockPressed(stock: AltStockTicker) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            self.tableView.setContentOffset(.zero, animated: false)
            let viewModel = TickerDetailsViewModel(ticker: TickerInfo(ticker: stock))
            self.viewModel = viewModel
            self.tableView.dataSource = viewModel.dataSource
            self.tableView.delegate = viewModel.dataSource
            viewModel.dataSource.delegate = self
            
            TickerDetailsDataSource.oldHostingTag = TickerDetailsDataSource.hostingTag
            TickerDetailsDataSource.hostingTag = Int((arc4random() % 50) + 1)
            self.loadTicketInfo()
        }
    }
    
    func loadingState(started: Bool) {
        DispatchQueue.main.async { [weak self] in
            if started {
                self?.showNetworkLoader()
            } else {
                self?.hideLoader()
            }
        }
    }
    
    func comparedStocksChanged(stock: AltStockTicker) {
        
        viewModel?.compareToggled(stock)
        
        let stocksCount = (viewModel?.tickersToCompare.count ?? 0)
        if stocksCount == 2 {
            bottomViewModel?.actionTitle = "Compare \(stocksCount) stocks"
        }
        UIView.animate(withDuration: 0.3) {
            self.bottomViews.forEach({$0.alpha = stocksCount > 1 ? 1 : 0; $0.isUserInteractionEnabled = stocksCount > 1 ? true : false;})
        } completion: { done in
            if done {
                self.bottomViewModel?.actionTitle = "Compare \(stocksCount) stocks"
            }
        }
    }
    
    func openCompareWithSelf(ticker: TickerInfo) {
        if !(viewModel?.tickersToCompare.contains(ticker.ticker) ?? false) {
            viewModel?.tickersToCompare.insert(ticker.ticker, at: 0)
        }
        if let model = viewModel?.compareCollectionDTO() {
            coordinator?.showCompareDetails(model: model, delegate: nil)
        }
    }
    
    func requestOpenCollection(withID id: Int) {
        coordinator?.showCollectionDetails(collectionID: id, delegate: self)
    }
    
    func wrongIndPressed(isTicked: Bool) {
        if isTicked {
            WrongIndustryManager.shared.addToWrong(viewModel?.ticker.symbol ?? "")
            showWrongIndView()
        } else {
            WrongIndustryManager.shared.removeFromWrong(viewModel?.ticker.symbol ?? "")
            showUndoIndView()
        }
    }
    
    func showWrongIndView() {
        wrongIndLbl.text = "Categories and industries marked as wrong. We will double check them, thank you!"
        wrongIndView.isHidden = false
        GainyAnalytics.logEvent("wrong_industry", params: [ "timestamp": Date().timeIntervalSinceReferenceDate, "ticker_symbol": viewModel?.ticker.symbol ?? "",
                                                                   "tag_ids": viewModel?.ticker.tags.compactMap({$0.id}) ?? [],
                                                                   "tag_names": viewModel?.ticker.tags.compactMap({$0.name}) ?? []])
        wrongIndTimer?.invalidate()
        wrongIndTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false, block: {[weak self] _ in
            self?.hideWrongIndView()
        })
    }
    
    func showUndoIndView() {
        wrongIndLbl.text = "Categories and industries marked as right, thank you!"
        wrongIndView.isHidden = false
        GainyAnalytics.logEvent("wrong_industry_undo", params: ["timestamp": Date().timeIntervalSinceReferenceDate,   "ticker_symbol": viewModel?.ticker.symbol ?? "",
                                                                   "tag_ids": viewModel?.ticker.tags.compactMap({$0.id}) ?? [],
                                                                   "tag_names": viewModel?.ticker.tags.compactMap({$0.name}) ?? []])
        wrongIndTimer?.invalidate()
        wrongIndTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false, block: {[weak self] _ in
            self?.hideWrongIndView()
        })
    }
    
    func hideWrongIndView() {
        wrongIndView.isHidden = true
    }
    
    func collectionSelected(collection: RemoteCollectionDetails) {
        coordinator?.showCollectionDetails(collectionID: collection.id ?? -1, delegate: self)
    }
    
    @IBAction @objc private func didTapInvest() {
        let notifyViewController = NotifyViewController.instantiate(.popups)
        let navigationController = UINavigationController.init(rootViewController: notifyViewController)
        navigationController.modalPresentationStyle = .fullScreen
        notifyViewController.sourceId = viewModel?.ticker.symbol ?? ""
        GainyAnalytics.logEvent("invest_pressed_stock", params: ["ticker_id": viewModel?.ticker.symbol ?? ""])
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension TickerViewController: SingleCollectionDetailsViewControllerDelegate {
    
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

extension TickerViewController: BrokersViewControllerDelegate {
    
    func didDismissBrokersViewController() {
        
        self.tableView.reloadData()
    }
}

extension TickerViewController: MetricsViewControllerDelegate {
    
    func didDismissMetricsViewController(needRefresh: Bool) {
        
        viewModel?.dataSource.ticker.updateMarketData()
        self.delegate?.didUpdateTickerMetrics()
        self.tableView.reloadData()
    }
}

extension TickerViewController: CollectionsBottomViewDelegate {
    func bottomActionPressed(view: CollectionsBottomView) {
        if let model = viewModel?.compareCollectionDTO() {
            coordinator?.showCompareDetails(model: model, delegate: nil)
        }
    }
}
