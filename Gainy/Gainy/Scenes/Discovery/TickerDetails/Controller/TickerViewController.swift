import UIKit
import GainyDriveWealth
import SkeletonView
import GainyAPI

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
    
    var isFromHome: Bool = false
    
    var symbol: String  {
        viewModel?.dataSource.ticker.symbol ?? ""
    }
    
    //MARK: - Outlets
    @IBOutlet private weak var wlView: UIView!
    @IBOutlet private weak var wlInfoLbl: UILabel!
    private let refreshControl = LottieRefreshControl()
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel?.dataSource
            tableView.delegate = viewModel?.dataSource
            tableView.refreshControl = refreshControl
            tableView.register(HistoryTableCell.self, forCellReuseIdentifier: HistoryTableCell.cellIdentifier)
            tableView.register(PositionTableCell.self, forCellReuseIdentifier: PositionTableCell.cellIdentifier)
            tableView.register(CurrentTablePositionCell.self, forCellReuseIdentifier: CurrentTablePositionCell.cellIdentifier)
            viewModel?.dataSource.delegate = self
            refreshControl.addTarget(self, action: #selector(refreshTicketInfo), for: .valueChanged)
        }
    }
    @IBOutlet private weak var wrongIndView: UIView!
    @IBOutlet private weak var wrongIndLbl: UILabel!
    
    lazy var tradeBtn: CollectionInvestButtonView = {
        let view = CollectionInvestButtonView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var isPurchased: Bool = false {
        didSet {
            tradeBtn.mode = isPurchased ? .reconfigure : .invest
        }
    }
    private var haveHistory: Bool = false
    
    //MARK:- Inner
    
    private var lastYOffset: CGFloat? = nil
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomView()
        if RemoteConfigManager.shared.isInvestBtnVisible {
            addInvestbutton()
        }
        
        viewModel?.dataSource.cancellOrderPressed = {[weak self] history in
            let alertController = UIAlertController(title: nil, message: NSLocalizedString("Are you sure want to cancel your order?", comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Back", comment: ""), style: .cancel) { (action) in
                
            }
            let proceedAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .destructive) { (action) in
                GainyAnalytics.logEvent("stock_cancel_pending_transaction", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
                
                self?.showNetworkLoader()
                Task {
                    let accountNumber = await CollectionsManager.shared.cancelStockOrder(orderId: history.tradingOrder?.id ?? -1)
                    NotificationCenter.default.post(name: NotificationManager.dwTTFBuySellNotification, object: nil, userInfo: ["name" : history.name ?? ""])
                    await MainActor.run {
                        
                        self?.hideLoader()
                    }
                }
            }
            alertController.addAction(proceedAction)
            alertController.addAction(cancelAction)
            self?.present(alertController, animated: true, completion: nil)
        }
        viewModel?.dataSource.showMorePressed = { [weak coordinator] history in
            coordinator?.dwShowAllHistoryForItem(history: history, from: self)
        }
        
        viewModel?.dataSource.tapOrderPressed = { [weak self] history in
            guard UserProfileManager.shared.userRegion == .us else { return }
            //Getting correct mode
            var mode: DWHistoryOrderMode = .other(history: TradingHistoryFrag())
            if let tradingCollectionVersion = history.tradingCollectionVersion {
                if tradingCollectionVersion.targetAmountDelta ?? 0.0  >= 0.0 {
                    mode = .buy(history: history)
                } else {
                    mode = .sell(history: history)
                }
            } else {
                mode = .other(history: history)
            }
            self?.impactOccured()
            self?.coordinator?.showDetailedOrderHistory(name: self?.viewModel?.ticker.name ?? "",
                                                        amount: Double(history.amount ?? 0.0),
                                                        mode: mode,
                                                        from: self)
        }
        
        
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
        
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateScoringSettings)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] notification in
            self?.refreshTicketInfo()
        }.store(in: &cancellables)
        NotificationCenter.default.publisher(for: NotificationManager.dwTTFBuySellNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] notification in
            if let sourceName = notification.userInfo?["name"] as? String {
                guard let self = self else {return}
                
                
                guard let symbol = self.viewModel?.dataSource.ticker.symbol else {
                    return
                }
                
                guard let name = self.viewModel?.dataSource.ticker.name else {
                    return
                }
                
                guard sourceName == name else {return}
                
                self.viewModel?.dataSource.ticker.resetMainData()
                let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
                    item == symbol
                }
                //Adding to WL if not
                if !addedToWatchlist {
                    GainyAnalytics.logEvent("ticker_added_to_wl", params: ["af_content_id" : symbol, "af_content_type" : "ticker"])
                    GainyAnalytics.logEventAMP("ticker_added_to_wl", params: ["tickerSymbol" : symbol, "tickerType" : "stock", "action" : "bookmark", "isFromSearch": "false", "source" : "ticker_card"])
                    UserProfileManager.shared.addTickerToWatchlist(symbol) { success in
                        if success {
                            guard let cell = self.viewModel?.dataSource.headerCell else {
                                return
                            }
                            cell.updateAddToWatchlistToggle()
                            self.modifyDelegate?.didModifyWatchlistTickers(isAdded: true, tickerSymbol: symbol)
                        }
                        //Reloading
                        self.refreshTicketInfo()
                    }
                } else {
                    //Reloading
                    self.refreshTicketInfo()
                }
            }
        }.store(in: &cancellables)
        setUIBasedOnHome()
    }
    
    private func setUIBasedOnHome() {
        viewModel?.isFromHome = isFromHome
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
        tradeBtn.isHidden = true
        if !fromRefresh {
            guard !(self.viewModel?.dataSource.ticker.isMainDataLoaded ?? false) else {return}
        }
        
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.", report: true)
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
                
                self?.tradeBtn.configureWith(name: self?.viewModel?.ticker.name ?? "",
                                             imageName: "",
                                             imageUrl: "",
                                             collectionId: -1)
                self?.tradeBtn.investButton.backgroundColor = UIColor(hexString: "0062FF")
                self?.tradeBtn.isHidden = !RemoteConfigManager.shared.isInvestBtnVisible
                if RemoteConfigManager.shared.isInvestBtnVisible {
                    self?.tradeBtn.isHidden = !(self?.viewModel?.ticker.isTradingEnabled ?? false)
                }
                
                if UserProfileManager.shared.userRegion == .us {
                    self?.isPurchased = (self?.viewModel?.ticker.isPurchased ?? false)
                    self?.haveHistory = (self?.viewModel?.ticker.haveHistory ?? false)
                } else {
                    self?.isPurchased = false
                    self?.haveHistory = false
                }
                self?.viewModel?.dataSource.updateConfigurators()
                self?.isLoadingInfo = false
                self?.viewModel?.dataSource.calculateHeights()
                self?.tableView.reloadData()
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
            GainyAnalytics.logEvent("ticker_added_to_wl", params: ["af_content_id" : symbol, "af_content_type" : "ticker"])
            GainyAnalytics.logEventAMP("ticker_added_to_wl", params: ["tickerSymbol" : symbol, "tickerType" : "stock", "action" : "bookmark", "isFromSearch": "false", "source" : "ticker_card"])
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
    
    fileprivate func addInvestbutton() {
        view.insertSubview(tradeBtn, at: 1)
        tradeBtn.autoPinEdge(toSuperviewEdge: .bottom, withInset: 36.0)
        tradeBtn.autoSetDimension(.height, toSize: 96.0)
        tradeBtn.autoPinEdge(toSuperviewEdge: .left)
        tradeBtn.autoPinEdge(toSuperviewEdge: .right)
        
        tradeBtn.investButtonPressed = { [weak self] in
            if let self  {
                self.demoDWFlow()
            }
        }
        tradeBtn.buyButtonPressed = {[weak self] in
            if let self  {
                self.coordinator?.dwShowBuyToStock(symbol: self.viewModel?.ticker.symbol ?? "",
                                                   name: self.viewModel?.ticker.name ?? "", from: self)
            }
        }
        tradeBtn.sellButtonPressed = { [weak self] in
            if let self  {
                self.coordinator?.dwShowSellToStock(symbol: self.viewModel?.ticker.symbol ?? "",
                                                    name: self.viewModel?.ticker.name ?? "",
                                                    available: Double(self.viewModel?.ticker.tradeStatus?.actualValue ?? 0.0), from: self)
            }
        }
        view.bringSubviewToFront(tradeBtn)
    }
    
    private func demoDWFlow() {        
        if Configuration().environment == .production {
            GainyAnalytics.logEventAMP("ticker_invest_tapped", params: ["tickerType" : "stock", "tickerSymbol" : self.viewModel?.ticker.symbol ?? ""])
            self.coordinator?.showDWFlowStock(symbol: self.viewModel?.ticker.symbol ?? "",
                                               name: self.viewModel?.ticker.name ?? "",
                                              from: self)
        } else {
            let testOptionsAlertVC = UIAlertController.init(title: "DEMO", message: "Choose your way", preferredStyle: .actionSheet)
            testOptionsAlertVC.addAction(UIAlertAction(title: "KYC", style: .default, handler: { _ in
                self.coordinator?.dwShowKyc(from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Deposit", style: .default, handler: { _ in
                self.coordinator?.dwShowDeposit(from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Withdraw", style: .default, handler: { _ in
                self.coordinator?.dwShowWithdraw(from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Invest", style: .default, handler: { _ in
                self.coordinator?.dwShowInvestStock(symbol: self.viewModel?.ticker.symbol ?? "",
                                                    name: self.viewModel?.ticker.name ?? "",
                                                    from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Buy", style: .default, handler: { _ in
                self.coordinator?.dwShowBuyToStock(symbol: self.viewModel?.ticker.symbol ?? "",
                                                   name: self.viewModel?.ticker.name ?? "",
                                                   from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Sell", style: .default, handler: { _ in
                self.coordinator?.dwShowSellToStock(symbol: self.viewModel?.ticker.symbol ?? "",
                                                    name: self.viewModel?.ticker.name ?? "",
                                                    available: Double(self.viewModel?.ticker.tradeStatus?.actualValue ?? 0.0),
                                                    from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Original flow", style: .default, handler: { _ in
                self.coordinator?.showDWFlowStock(symbol: self.viewModel?.ticker.symbol ?? "",
                                                   name: self.viewModel?.ticker.name ?? "",
                                                  from: self)
            }))
            
            present(testOptionsAlertVC, animated: true)
        }
    }
    
    
    //MARK: - Wrong Ind Logic
    
    private var wrongIndTimer: Timer?
    @IBAction func closeWrongIndViewAction(_ sender: Any) {
        hideWrongIndView()
    }
    
    @IBAction func undoWrongIndViewAction(_ sender: Any) {
        guard let symbol = viewModel?.ticker.symbol else {return}

        if WrongIndustryManager.shared.isIndWrong(symbol) {
            GainyAnalytics.logEvent("wrong_industry_undo", params: ["timestamp": Date().timeIntervalSinceReferenceDate,   "ticker_symbol": viewModel?.ticker.symbol ?? "",
                                                                       "tag_ids": viewModel?.ticker.tags.compactMap({$0.id}) ?? [],
                                                                       "tag_names": viewModel?.ticker.tags.compactMap({$0.name}) ?? []])
            WrongIndustryManager.shared.removeFromWrong(symbol)
            guard let cell = tableView.visibleCells.first(where: {$0 is TickerDetailsRecommendedViewCell}) as? TickerDetailsRecommendedViewCell else {return}
            cell.unhighlightIndustries()
        } else {
            GainyAnalytics.logEvent("wrong_industry", params: ["timestamp": Date().timeIntervalSinceReferenceDate,   "ticker_symbol": viewModel?.ticker.symbol ?? "",
                                                                       "tag_ids": viewModel?.ticker.tags.compactMap({$0.id}) ?? [],
                                                                       "tag_names": viewModel?.ticker.tags.compactMap({$0.name}) ?? []])
            WrongIndustryManager.shared.addToWrong(symbol)
            guard let cell = tableView.visibleCells.first(where: {$0 is TickerDetailsRecommendedViewCell}) as? TickerDetailsRecommendedViewCell else {return}
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
        view.bringSubviewToFront(wlView)
    }
    
    private var wlTimer: Timer?
    @IBAction func closeWLViewAction(_ sender: Any) {
        hideWLView()
    }
    
    @IBAction func undoWLAction(_ sender: Any) {
        guard let wlInfo = wlInfo else {return}
        GainyAnalytics.logEvent("remove_from_watch_pressed", params: ["tickerSymbol" : wlInfo.stock.symbol , "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        UserProfileManager.shared.removeTickerFromWatchlist(wlInfo.stock.symbol ) { success in
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
    func endUpdates() {
        tableView.endUpdates()
    }
    
    func beginUpdates() {
        tableView.beginUpdates()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    func onboardPressed() {
        let interestsVC = PersonalizationPickInterestsViewController.instantiate(.onboarding)
        let navigationController = UINavigationController.init(rootViewController: interestsVC)
        interestsVC.mainCoordinator = self.coordinator
        self.present(navigationController, animated: true, completion: nil)
    }
    
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
            
            GainyAnalytics.logEventAMP("ticker_card_opened", params: ["tickerSymbol" : stock.symbol, "tickerType" : "stock", "isFromSearch" : "false", "collectionID" : "none", "ticker_card_alternative" : "ttf_Card"])
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
        view.bringSubviewToFront(wrongIndView)
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
        let type = UserProfileManager.shared.favoriteCollections.contains(collection.id ?? 0) ? "your" : "none"
        GainyAnalytics.logEventAMP("ttf_card_opened", params: ["id" : collection.id ?? 0, "isFromSearch" : "false", "type": type, "source" : "ticker_card"])
        if UserDefaults.isFirstLaunch() {
            GainyAnalytics.logEventAMP("ttf_card_opened_disc_initial", params: ["collectionID" : collection.id ?? 0])
        }
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
