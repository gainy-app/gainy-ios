//
//  HoldingsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 15.11.2021.
//

import UIKit
import SkeletonView

final class HoldingsViewController: BaseViewController {
    
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
        }
    }
    //MARK: - Inner
    private let viewModel = HoldingsViewModel()
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadData(){
        tableView.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
        viewModel.loadHoldingsAndSecurities {[weak self] in
            self?.tableView.hideSkeleton()
        }
    }
    
}
