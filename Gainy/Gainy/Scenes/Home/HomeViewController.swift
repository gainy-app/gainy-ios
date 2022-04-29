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

final class HomeViewController: BaseViewController {
    
    var mainCoordinator: MainCoordinator?
    
    //MARK: - Inner
    private let viewModel = HomeViewModel()
    private var refreshControl = LottieRefreshControl()
    
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
    
    //MARK: - Life Cycle
    
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
}
