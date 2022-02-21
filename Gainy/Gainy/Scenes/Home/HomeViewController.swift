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
            tableView.dataSource = viewModel.dataSource
            tableView.delegate = viewModel.dataSource
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
        tableView.showSkeleton()
        viewModel.loadHomeData { [weak tableView] in
            tableView?.hideSkeleton()
            tableView?.reloadData()
        }
    }
    
    override func userLoggedOut() {
        super.userLoggedOut()
        
    }
}
