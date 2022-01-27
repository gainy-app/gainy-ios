import UIKit
import SkeletonView

// TODO: move into a separate file
protocol CardDetailsViewModelProtocol {
    //    var initialCollectionIndex: Int { get set }
    //    var collectionDetails: [CollectionDetailViewCellModel] { get set }
}


final class TickerViewController: BaseViewController {
    
    //MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: TickerDetailsViewModel?
    
    //MARK: - Outlets
    private let refreshControl = LottieRefreshControl()
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel?.dataSource
            tableView.delegate = viewModel?.dataSource
            tableView.refreshControl = refreshControl
            viewModel?.dataSource.delegate = self
            refreshControl.addTarget(self, action: #selector(loadTicketInfo), for: .valueChanged)
        }
    }
    
    //MARK:- Inner
    
    private var lastYOffset = 0.0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func loadTicketInfo() {
        refreshControl.endRefreshing()
        viewModel?.dataSource.ticker.isChartDataLoaded = false
        
        tableView.contentOffset = .zero
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        delay(0.3) {
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
        if let currentBrocker = UserProfileManager.shared.selectedBrokerToTrade {
            if let url = currentBrocker.brokerURLWithSymbol(symbol: symbol) {
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
                }
            }
        } else {
            GainyAnalytics.logEvent("add_to_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.addTickerToWatchlist(symbol) { success in
                if success {
                    sender.isSelected = true
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
}
extension TickerViewController: TickerDetailsDataSourceDelegate {
    
    func didRequestShowBrokersListForSymbol(symbol: String) {
        
        self.coordinator?.showBrokersViewController(symbol: symbol, delegate: self)
    }
    
    func isStockCompared(stock: AltStockTicker) -> Bool {
        viewModel?.tickersToCompare.contains(where: {$0.symbol == stock.symbol}) ?? false
    }
    
    func altStockPressed(stock: AltStockTicker) {
        let yesAction = UIAlertAction.init(title: "Yes", style: .default) { _ in
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
        NotificationManager.shared.showMessage(title: "Warning", text: "Are you sure you want to load \(stock.name ?? "") stock?", cancelTitle: "No", actions: [yesAction])
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
    
    func didDismissMetricsViewController() {
        
        viewModel?.dataSource.ticker.updateMarketData()
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
