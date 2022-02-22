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
    
    //MARK: - Inner
    @IBOutlet weak var nameLbl: UILabel!
    
    //MARK: - Outlets
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
        viewModel.loadHomeData { [weak tableView] in
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
}

extension HomeViewController: HomeDataSourceDelegate {
    func altStockPressed(stock: AltStockTicker, isGainers: Bool) {
        if isGainers {
            if let index = viewModel.topGainers.firstIndex(where: {$0.symbol == stock.symbol}) {
                mainCoordinator?.showCardsDetailsViewController(viewModel.topGainers.compactMap({TickerInfo(ticker: $0)}), index: index)
            }
        } else {
            if let index = viewModel.topLosers.firstIndex(where: {$0.symbol == stock.symbol}) {
                mainCoordinator?.showCardsDetailsViewController(viewModel.topLosers.compactMap({TickerInfo(ticker: $0)}), index: index)
            }
        }
    }
}
