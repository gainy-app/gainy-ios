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
        
        loadTicketInfo()
        addBottomView()
    }
    
    func reloadTicker(_ ticker: RemoteTicker) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTicketInfo()
    }
    
    func loadTicketInfo() {
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        showNetworkLoader()
        print("SHOWING LOADIER")
        viewModel?.dataSource.ticker.loadDetails {[weak self] in
            print("DISMISS LOADIER")
            self?.hideLoader()
            self?.tableView.reloadData()
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
        bottomViewModel = CollectionsBottomViewModel.init(actionTitle: "Compare \((viewModel?.ticker.tickersToCompare.count ?? 0) + 1) stocks", actionIcon: "compare_icon")
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
    func loadingState(started: Bool) {
        DispatchQueue.main.async { [weak self] in
            if started {
                self?.showNetworkLoader()
            } else {
                self?.hideLoader()
            }
        }
    }
    
    func comparedStocksChanged() {
        let stocksCount = (viewModel?.ticker.tickersToCompare.count ?? 0) + 1
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

extension TickerViewController: CollectionsBottomViewDelegate {
    func bottomActionPressed(view: CollectionsBottomView) {
        let compareVC = CompareStocksViewController.instantiate(.discovery)
        
        
        if let curStock = viewModel?.ticker.ticker.toAltTicker() {
            if !(viewModel?.ticker.tickersToCompare.contains(curStock) ?? false) {
                viewModel?.ticker.tickersToCompare.insert(curStock, at: 0)
            }
        }
        
        compareVC.stocks =  viewModel?.ticker.tickersToCompare ?? []
        present(compareVC, animated: true, completion: nil)
    }
}
