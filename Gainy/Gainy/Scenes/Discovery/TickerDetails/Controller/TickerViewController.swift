import UIKit

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
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel?.dataSource
            tableView.delegate = viewModel?.dataSource
            viewModel?.dataSource.delegate = self
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
        loadTicketInfo()
    }
    
    func loadTicketInfo() {
        tableView.contentOffset = .zero
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        showNetworkLoader()
        viewModel?.dataSource.chartLoader.startAnimating()
        dprint("SHOWING LOADER")
        viewModel?.dataSource.ticker.loadDetails(mainDataLoaded: {[weak self] in
            dprint("DISMISS LOADIER")
            DispatchQueue.main.async {
            self?.hideLoader()
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
    
    //MARK: - Actions
    
    @IBAction func shareAction(_ sender: Any) {
        
        guard let symbol = viewModel?.dataSource.ticker.symbol else {
            return
        }
        if let currentBrocker = UserProfileManager.shared.selectedBrokerToTrade {
            if let url = currentBrocker.brokerURLWithSymbol(symbol: symbol) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, completionHandler: { (success) in
                        GainyAnalytics.logEvent("ticker_shared", params: ["tickerSymbol" : symbol])
                    })
                }
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
                let viewModel = TickerDetailsViewModel(ticker: TickerInfo(ticker: stock))
                self.viewModel = viewModel
                self.tableView.dataSource = viewModel.dataSource
                self.tableView.delegate = viewModel.dataSource
                viewModel.dataSource.delegate = self
                self.loadTicketInfo()
            }
            
        }
        NotificationManager.shared.showMessage(title: "Warning", text: "Are you sure want to load \(stock.name ?? "") stock?", cancelTitle: "No", actions: [yesAction])
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
}

extension TickerViewController: BrokersViewControllerDelegate {
    
    func didDismissBrokersViewController() {
        
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
