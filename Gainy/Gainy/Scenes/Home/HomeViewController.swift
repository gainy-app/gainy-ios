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

final class HomeViewController: BaseViewController {
    
    var mainCoordinator: MainCoordinator?
    
    //MARK: - Inner
    private let viewModel = HomeViewModel()
    private var refreshControl = UIRefreshControl()
    
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
            tableView.dataSource = viewModel.dataSource
            tableView.delegate = viewModel.dataSource
            viewModel.dataSource.delegate = self
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
        
        setupPanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBasedOnState()
    }
    
    private func loadBasedOnState() {
        if let first = UserProfileManager.shared.firstName, let last = UserProfileManager.shared.lastName {
            nameLbl.text = "Hi, \(first) \(last)"
        } else {
            nameLbl.text = ""
        }
        tableView.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        viewModel.loadHomeData { [weak tableView, weak refreshControl] in
            refreshControl?.endRefreshing()
            tableView?.hideSkeleton()
            tableView?.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            view.showAnimatedSkeleton()
        }
    
    override func userLoggedOut() {
        super.userLoggedOut()
        
    }
    
    @objc func refreshAction() {
        loadBasedOnState()
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
                .full: FloatingPanelLayoutAnchor(absoluteInset: 300, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 300, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 300, edge: .bottom, referenceGuide: .safeArea),
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

extension HomeViewController: HomeDataSourceDelegate {
    
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        showWLView(stock: stock, cell: cell)
    }
    
    func articlePressed(article: WebArticle) {
        let articleVC = ArticleViewController.instantiate(.home)
        articleVC.articleUrl = article.url ?? ""
        present(articleVC, animated: true, completion: nil)
    }
    
    func collectionSelected(collection: RemoteShortCollectionDetails) {
        mainCoordinator?.showCollectionDetails(collectionID: collection.id ?? 0, collection: collection)
    }
    
    func tickerSelected(ticker: RemoteTicker) {
        mainCoordinator?._showCardDetailsViewController(TickerInfo.init(ticker: ticker))
    }
    
    func tickerSortCollectionsPressed() {
        guard self.presentedViewController == nil else {return}
        sortingCollectionsVC.delegate = self
        fpc.layout = SortCollectionsPanelLayout()
        self.fpc.set(contentViewController: sortingCollectionsVC)
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    func tickerSortWLPressed() {
        guard self.presentedViewController == nil else {return}
        sortingWatchlistVC.delegate = self
        sortingWatchlistVC.collectionId = Constants.CollectionDetails.watchlistCollectionID
        fpc.layout = SortWLPanelLayout()
        self.fpc.set(contentViewController: sortingWatchlistVC)
        self.present(self.fpc, animated: true, completion: nil)
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
    func selectionChanged(vc: SortCollectionDetailsViewController, sorting: String) {
        
        self.fpc.dismiss(animated: true, completion: nil)
        viewModel.sortWatchlist()
        self.tableView.reloadData()
    }
}

extension HomeViewController: SortCollectionsViewControllerDelegate {
    
    func selectionChanged(vc: SortCollectionsViewController, sorting: String) {
        
        self.fpc.dismiss(animated: true, completion: nil)
        viewModel.sortFavCollections()
        self.tableView.reloadData()
    }
}
